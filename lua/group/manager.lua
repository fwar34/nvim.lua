--[[
group 文件保存的第一行是 current_buf_name
]]
local api = vim.api
local cmd = vim.cmd
local fn = vim.fn
local futil = require('futil')
local is_windows = require('global').is_windows
local check_file_exist = require('global').check_file_exist
local render = require('bufferline.render')
local view = require('nvim-tree.view')

local last_group = nil
local current_group = nil
-- local loaded_groups = {}
local M = {}

local group_directory = fn.expand(is_windows and '~/AppData/Local/nvim/sessionmgr/' or '~/.config/nvim/sessionmgr/')
if fn.isdirectory(group_directory) == 0 then
    fn.mkdir(group_directory, 'p')
end

local function gen_group_path(group_name)
    return group_directory .. group_name .. '.session'
end

function M.is_buf_exclude(bufnr)
    if not api.nvim_buf_is_valid(bufnr) then
        return true
    end

    local ft = api.nvim_buf_get_option(bufnr, 'filetype')
    if ft == 'floaterm' or ft == 'rnvimr' or ft == 'toggleterm' or ft == '' or ft == 'help' or ft == 'qf' or
        string.len(api.nvim_buf_get_name(bufnr)) == 0 then
        return true
    end
    return false
end

function M.current_group()
    return current_group
end

local function update_buffer_var(bufnr, group_name)
    local old = api.nvim_buf_get_var(bufnr, 'buffer_groups')
    if not vim.tbl_contains(old, group_name) then
        api.nvim_buf_set_var(bufnr, 'buffer_groups', table.insert(old, group_name))
    end
end

local function clear_all_buffer_var()
    for _, bufnr in ipairs(api.nvim_list_bufs()) do
        if not M.is_buf_exclude(bufnr) then
            api.nvim_buf_set_var(bufnr, 'buffer_groups', nil)
        end
    end
end

-- local function update_groups(group_name)
--     if not vim.tbl_contains(loaded_groups, group_name) then
--         table.insert(loaded_groups, group_name)
--     end
-- end

local function group_save(group_name)
    local group_path = gen_group_path(group_name)
    local f = io.open(group_path, 'w+')
    if not f then
        futil.err({ title = 'group_save' }, 'failed to open file(%s)', group_path)
        return nil
    end

    if view.is_visible() then
        cmd('NvimTreeToggle')
    end

    local current_bufnr = api.nvim_get_current_buf()
    if not M.is_buf_exclude(current_bufnr) then
        local current_buf_name = api.nvim_buf_get_name(current_bufnr)
        f:write(current_buf_name .. '\n') -- 第一行保存 current_buf_name
        table.insert(ret, current_bufnr)
        update_buffer_var(current_bufnr, group_name)
    end

    local ret = {}
    local buffers = api.nvim_list_bufs()
    for _, bufnr in ipairs(buffers) do
        -- futil.debug({ title = 'group_load', timeout = 0 },
        --     'buf-------------------(%u) name(%s) is_exclude(%u) buflisted(%u) is_valid(%u) name length(%u) filetype(%s)',
        --     buf, api.nvim_buf_get_name(buf), (is_exclude(buf) and 1 or 0),
        --     (api.nvim_buf_get_option(buf, 'buflisted') and 1 or 0),
        --     (api.nvim_buf_is_valid(buf) and 1 or 0), string.len(api.nvim_buf_get_name(buf)),
        --     api.nvim_buf_get_option(buf, 'filetype'))
        local buffer_groups = api.nvim_buf_get_var(bufnr, 'buffer_groups')
        if not M.is_buf_exclude(bufnr)
            and api.nvim_buf_get_option(bufnr, 'buflisted')
            and bufnr ~= current_bufnr
            and (not current_group or not buffer_groups or vim.tbl_contains(buffer_groups, current_group)) then
            f:write(api.nvim_buf_get_name(bufnr) .. '\n')
            table.insert(ret, bufnr)
            update_buffer_var(bufnr, group_name)
        end
    end

    f:close()
    -- update_groups(group_name)
    -- vim.pretty_print(ret)
    return ret
end

local function open_buffer(buffer_name)
    local bufnr = fn.bufnr(buffer_name)
    if bufnr == -1 then
        vim.cmd('silent! e ' .. buffer_name)
        bufnr = fn.bufnr(buffer_name)
    end
    return bufnr
end

local function group_load(group_name)
    local group_path = gen_group_path(group_name)
    if not check_file_exist(group_path) then
        futil.err({ title = 'group_load' }, 'sessionmgr: group file(%s) not exist', group_path)
        return
    end

    local f = io.open(group_path, 'r')
    if not f then
        futil.err({ title = 'group_load' }, 'open file(%s) failed', group_path)
        return
    end

    local buffers = {}
    local current_bufnr = nil
    -- local is_group_loaded = vim.tbl_contains(loaded_groups, group_name)
    for line in f:lines() do
        -- if not is_group_loaded then
            -- vim.cmd('silent! e ' .. line)
        -- end

        local bufnr = open_buffer(line)
        if api.nvim_buf_is_valid(bufnr) then
            table.insert(buffers, bufnr)
            update_buffer_var(bufnr, group_name)
            if not current_bufnr then -- 第一行是 current_buf_name
                api.nvim_set_current_buf(bufnr)
            end
        end
    end
    f:close()

    if table.maxn(buffers) == 0 then
        futil.err({ title = 'group_load' }, 'file(%s) content empty', group_path)
        return
    end

    if group_name ~= current_group then
        last_group = current_group
    end
    current_group = group_name
    -- update_groups(group_name)
end

local function group_delete(group_name)
    local group_path = gen_group_path(group_name)
    if check_file_exist(group_path) then
        os.remove(group_path)
    end

    for _, bufnr in ipairs(api.nvim_list_bufs()) do
        if not M.is_buf_exclude(bufnr) then
            local buffer_groups = api.nvim_buf_get_var(bufnr)
            if buffer_groups and vim.tbl_contains(buffer_groups, group_name) then
                api.nvim_buf_delete(bufnr)
            end
        end
    end

    if group_name == current_group then
        current_group = nil
        -- TODO: need switch to another session file
    end
    -- if loaded_groups then
    --     for i, v in ipairs(loaded_groups) do
    --         if v == group_name then
    --             table.remove(loaded_groups, i)
    --             break
    --         end
    --     end
    -- end

end

-- local function group_hide(buffers)
--     for _, buf in ipairs(buffers) do
--         if not M.is_buf_exclude(buf) then
--             api.nvim_buf_set_option(buf, 'buflisted', false)
--         end
--     end
-- end

local function update_bufferline()
    local exclude_name = {}
    for _, bufnr in ipairs(api.nvim_list_bufs()) do
        if api.nvim_buf_is_valid(bufnr) and api.nvim_buf_get_option(bufnr, 'buflisted') then
            local buffer_name = api.nvim_buf_get_name(bufnr)
            local buffer_groups = api.nvim_buf_get_var(bufnr, 'buffer_groups')
            if string.len(buffer_name) ~= 0 and buffer_groups and (current_group and not vim.tbl_contains(buffer_groups, current_group)) then
                table.insert(exclude_name, vim.fs.basename(api.nvim_buf_get_name(bufnr)))
            end
        end
    end
    api.nvim_set_var('bufferline', { exclude_name = exclude_name })
    render.update()
end

-- local function group_complete(arg, cmd_line)
local function group_complete(arg)
    -- futil.info('arg: %s', arg)
    -- futil.info('cmd_line: %s', cmd_line)
    local match = {}
    -- local output = is_windows and fn.execute('!dir ' .. group_directory) or fn.execute('!ls ' .. group_directory)
    local output = fn.execute(is_windows and '!dir ' .. group_directory or '!ls ' .. group_directory)
    for line in string.gmatch(output, "(%w+)%.session") do
        if string.match(line, arg) then
            table.insert(match, 1, line)
        else
            table.insert(match, line)
        end
    end
    -- vim.pretty_print('match: ', match)
    return match
end

api.nvim_create_user_command('SSave', function(argument)
    argument.args = argument.args ~= '' and argument.args or current_group
    group_save(argument.args)
    current_group = argument.args
    update_bufferline()
end, { nargs = '?', bang = true, complete = group_complete })

api.nvim_create_user_command('SDelete', function(argument)
    group_delete(argument.args)
    -- TODO: need switch to another session file
    -- if not current_group and loaded_groups[1] then
    --     group_load(loaded_groups[1])
    -- end
    update_bufferline()
end, { nargs = 1, complete = group_complete })

api.nvim_create_user_command('SLoad', function(argument)
    if not check_file_exist(gen_group_path(argument.args)) then
        futil.warn({ title = 'SLoad' }, 'group(%s) not exist', argument.args)
        return
    end

    if argument.args == current_group then
        futil.warn({ title = 'SLoad' }, 'target group(%s) is equal to current group', argument.args)
        return
    end

    -- futil.info('current:%s, last:%s', current_group, last_group)
    if current_group then
        group_save(current_group)
        group_load(argument.args)
    else
        futil.delete_buffers(false)
        group_load(argument.args)
    end
    update_bufferline()
    -- futil.info('current:%s, last:%s', current_group, last_group)
end, { nargs = 1, complete = group_complete })

api.nvim_create_user_command('SSwitch', function(argument)
    if argument.args == current_group then
        futil.warn({ title = 'SSwitch' }, 'target group(%s) is equal to current group', argument.args)
        return
    end

    if not check_file_exist(gen_group_path(argument.args)) then
        futil.err({ title = 'SSwitch' }, 'target group(%s) not exist', argument.args)
        return
    end

    group_save(current_group)
    group_load(argument.args)
    update_bufferline()
end, { nargs = 1, complete = group_complete })

api.nvim_create_user_command('SPrevious', function()
    if not last_group then
        futil.warn({ title = 'SPrevious' }, 'last_group is empty!')
        return
    end
    local start_time = require('global').get_time_ms()
    group_save(current_group)
    local current = require('global').get_time_ms()
    print('save time ms:' .. (current - start_time) * 1000)

    start_time = require('global').get_time_ms()
    group_load(last_group)
    update_bufferline()
    current = require('global').get_time_ms()
    print('load time ms:' .. (current - start_time) * 1000)
end, {})

api.nvim_create_user_command('SPrint', function()
    futil.info({ title = 'SPrint' }, 'current(%s), last(%s)', current_group, last_group)
end, {})

api.nvim_create_user_command('SClear', function()
    if current_group then
        group_save(current_group)
    end
    clear_all_buffer_var()
    current_group = nil
    -- loaded_groups = nil
end, {})

api.nvim_create_autocmd('VimLeavePre', {
    callback = function()
        if current_group then
            group_save(current_group)
        end
    end,
})

api.nvim_create_autocmd('BufEnter', {
    pattern = '*',
    callback = function (arg)
        if current_group and not M.is_buf_exclude(arg.buf) then
            update_buffer_var(arg.buf, current_group)
        end
    end
})

function SessionMgrGroup()
    return current_group or ''
end

cmd([[
function! SessionMgrStatus()
return v:lua.SessionMgrGroup()
endfunction
]])

return M
