--[[
group 文件保存的第一行是 current_buf_name
]]
local futil = require('futil')
local is_windows = require('global').is_windows
local api = vim.api
local cmd = vim.cmd

local current_group = nil
local last_group = nil

local group_directory = vim.fn.expand(is_windows and '~/AppData/Local/nvim/groupmgr/' or '~/.config/nvim/groupmgr/')
-- print(group_directory)
if vim.fn.isdirectory(group_directory) == 0 then
    vim.fn.mkdir(group_directory, 'p')
end

local function check_file_exist(filename)
    return vim.fn.filereadable(filename) == 1
end

local function gen_group_path(group_name)
    return group_directory .. group_name .. '.group'
end

local function is_exclude(buf)
    if not api.nvim_buf_is_valid(buf) then
        return true
    end

    local ft = api.nvim_buf_get_option(buf, 'filetype')
    if ft == 'floaterm' or ft == 'rnvimr' or ft == 'toggleterm' or ft == '' or ft == 'help' or ft == 'qf' or
        string.len(api.nvim_buf_get_name(buf)) == 0 then
        return true
    end
    return false
end

local function group_save(group_name)
    local group_path = gen_group_path(group_name)
    local f = io.open(group_path, 'w+')
    if not f then
        futil.err({title = 'group_save'}, 'failed to open file(%s)', group_path)
        return nil
    end

    local view = require('nvim-tree.view')
    if view.is_visible() then
        cmd('NvimTreeToggle')
    end

    local current_buf = api.nvim_get_current_buf()
    if not api.nvim_buf_is_valid(current_buf) then
        futil.err({title = 'group_save'}, 'failed to get current_buf')
        return nil
    end

    local ret = { current_buf }
    local current_buf_name = api.nvim_buf_get_name(current_buf)
    if string.len(current_buf_name) ~= 0 then
        f:write(current_buf_name .. '\n') -- 第一行保存 current_buf_name
    end
    local buffers = api.nvim_list_bufs()
    for _, buf in ipairs(buffers) do
        futil.debug({ title = 'group_load', timeout = 0 },
            'buf-------------------(%u) name(%s) is_exclude(%u) buflisted(%u) is_valid(%u) name length(%u) filetype(%s)',
            buf, api.nvim_buf_get_name(buf), (is_exclude(buf) and 1 or 0),
            (api.nvim_buf_get_option(buf, 'buflisted') and 1 or 0),
            (api.nvim_buf_is_valid(buf) and 1 or 0), string.len(api.nvim_buf_get_name(buf)),
            api.nvim_buf_get_option(buf, 'filetype'))

        if not is_exclude(buf) and api.nvim_buf_get_option(buf, 'buflisted') and buf ~= current_buf then
            f:write(api.nvim_buf_get_name(buf) .. '\n')
            table.insert(ret, buf)
        end
    end

    f:close()
    -- print('current_buf:' .. current_buf)
    -- vim.pretty_print(ret)
    return ret
end

local function group_load(group_name)
    local group_path = gen_group_path(group_name)
    if not check_file_exist(group_path) then
        futil.err({title = 'group_load'}, 'groupmgr: group file(%s) not exist', group_path)
        return
    end

    local f = io.open(group_path, 'r')
    if not f then
        futil.err({title = 'group_load'}, 'open file(%s) failed', group_path)
        return
    end

    local buffers = {}
    local current_buf = nil
    for line in f:lines() do
        vim.cmd('silent! e ' .. line)
        if not current_buf then -- 第一行是 current_buf_name
            local tmp_current = vim.fn.bufnr(line)
            if api.nvim_buf_is_valid(tmp_current) then
                table.insert(buffers, tmp_current)
                current_buf = tmp_current
                api.nvim_buf_set_option(current_buf, 'buflisted', true)
            end
        else
            local buf = vim.fn.bufnr(line)
            if api.nvim_buf_is_valid(buf) then
                table.insert(buffers, buf)
                api.nvim_buf_set_option(buf, 'buflisted', true)
            end
        end
    end
    f:close()

    if table.maxn(buffers) == 0 then
        futil.err({title = 'group_load'}, 'file(%s) content empty', group_path)
        return
    end

    if current_buf then
        api.nvim_set_current_buf(current_buf)
    end

    if group_name ~= current_group then
        last_group = current_group
    end
    current_group = group_name
end

local function group_delete(group_name)
    local group_path = gen_group_path(group_name)
    if check_file_exist(group_path) then
        os.remove(group_path)
    end
    if group_name == current_group then
        current_group = nil
    end
end

local function group_hide(buffers)
    for _, buf in ipairs(buffers) do
        if not is_exclude(buf) then
            api.nvim_buf_set_option(buf, 'buflisted', false)
        end
    end
end

-- local function group_complete(arg, cmd_line)
local function group_complete(arg)
    -- futil.info('arg: %s', arg)
    -- futil.info('cmd_line: %s', cmd_line)
    local match = {}
    -- local output = is_windows and vim.fn.execute('!dir ' .. group_directory) or vim.fn.execute('!ls ' .. group_directory)
    local output = vim.fn.execute(is_windows and '!dir ' .. group_directory or '!ls ' .. group_directory)
    for line in string.gmatch(output, "(%w+)%.group") do
        if string.match(line, arg) then
            table.insert(match, 1, line)
        else
            table.insert(match, line)
        end
    end
    -- vim.pretty_print('match: ', match)
    return match
end

api.nvim_create_user_command('GSave', function(argument)
    argument.args = argument.args ~= '' and argument.args or current_group
    group_save(argument.args)
    current_group = argument.args
end, { nargs = '?', bang = true, complete = group_complete })

api.nvim_create_user_command('GDelete', function(argument)
    group_delete(argument.args)
end, { nargs = 1, complete = group_complete })

api.nvim_create_user_command('GLoad', function(argument)
    if not check_file_exist(gen_group_path(argument.args)) then
        futil.warn({title = 'GLoad'}, 'group(%s) not exist', argument.args)
        return
    end

    if argument.args == current_group then
        futil.warn({title = 'GLoad'}, 'target group(%s) is equal to current group', argument.args)
        return
    end

    -- futil.info('current:%s, last:%s', current_group, last_group)
    if current_group then
        local previous_buffers = group_save(current_group)
        if previous_buffers then
            group_hide(previous_buffers)
            group_load(argument.args)
        end
    else
        futil.delete_buffers(false)
        group_load(argument.args)
    end

    -- futil.info('current:%s, last:%s', current_group, last_group)
end, { nargs = 1, complete = group_complete })

api.nvim_create_user_command('GSwitch', function(argument)
    if argument.args == current_group then
        futil.warn({title = 'GSwitch'}, 'target group(%s) is equal to current group', argument.args)
        return
    end

    if not check_file_exist(gen_group_path(argument.args)) then
        futil.err({title = 'GSwitch'}, 'target group(%s) not exist', argument.args)
        return
    end

    local previous_buffers = group_save(current_group)
    if previous_buffers then
        group_hide(previous_buffers)
        group_load(argument.args)
    end
end, { nargs = 1, complete = group_complete })

api.nvim_create_user_command('GPrevious', function()
    if not last_group then
        futil.warn({title = 'GPrevious'}, 'last_group is empty!')
        return
    end

    local previous_buffers = group_save(current_group)
    if previous_buffers then
        group_hide(previous_buffers)
        group_load(last_group)
    end
end, {})

api.nvim_create_user_command('GPrint', function()
    futil.info({title = 'GPrint'}, 'current(%s), last(%s)', current_group, last_group)
end, {})

api.nvim_create_user_command('GClear', function ()
    if current_group then
        group_save(current_group)
    end
    current_group = nil
end, {})

api.nvim_create_autocmd('VimLeavePre', {
    callback = function()
        if current_group then
            group_save(current_group)
        end
    end,
})

function CurrentGroup()
    return current_group or ''
end

cmd([[
function! GroupMgrStatus()
return v:lua.CurrentGroup()
endfunction
]])
