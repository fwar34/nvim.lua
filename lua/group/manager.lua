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
--[[ buffer_contents = {
    [bufnr1] = {
        buffer_name = '/home/xxx/test.cpp',
        buffer_groups = {'trunk', 'dev'}
    },
    [bufnr2] = {
        buffer_name = '/home/xxx/test2.cpp',
        buffer_groups = {'trunk'}
    }
} ]]
buffer_contents = {}
local M = {}

local function update_group_state(group_name)
    if group_name ~= current_group then
        last_group = current_group
    end
    current_group = group_name
end

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

local function update_buffer_content(bufnr, group_name)
    local buffer_name = api.nvim_buf_get_name(bufnr)
    -- local bufnr_content = vim.tbl_get(buffer_contents, bufnr)
    local bufnr_content = buffer_contents[bufnr]
    if not bufnr_content or bufnr_content.buffer_name ~= buffer_name then
        buffer_contents[bufnr] = { buffer_name = buffer_name, buffer_groups = { group_name } }
    elseif not vim.tbl_contains(bufnr_content.buffer_groups, group_name) then
        table.insert(buffer_contents[bufnr].buffer_groups, group_name)
    end
    -- print('update group -> bufnr:' .. bufnr .. ' buffer_name:' .. buffer_name)
    -- vim.pretty_print(buffer_contents[bufnr].buffer_groups)
end

local function get_buffer_content(bufnr)
    local bufnr_content = buffer_contents[bufnr]
    if bufnr_content and bufnr_content.buffer_name == api.nvim_buf_get_name(bufnr) then
        -- require('futil').info('bufnr:%u content_name(%s) bufnr_name(%s) current_group(%s)', bufnr, bufnr_content.buffer_name, api.nvim_buf_get_name(bufnr), current_group)
        -- vim.pretty_print(bufnr_content.buffer_groups)
        return bufnr_content.buffer_groups
    end
    return nil
end

local function delete_buffer_content(bufnr)
    buffer_contents[bufnr] = nil
end

local function clear_all_buffer_var()
    buffer_contents = {}
end

function M.is_buf_hide(bufnr)
    local buffer_groups = get_buffer_content(bufnr)
    if buffer_groups and not vim.tbl_contains(buffer_groups, current_group) then
        return true
    end
    return false
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
        -- print('save bufnr:' .. current_bufnr .. ' current_group:' .. current_group)
        -- update_buffer_content(current_bufnr, group_name)
    end

    local buffers = api.nvim_list_bufs()
    for _, bufnr in ipairs(buffers) do
        -- futil.debug({ title = 'group_load', timeout = 0 },
        --     'buf-------------------(%u) name(%s) is_exclude(%u) buflisted(%u) is_valid(%u) name length(%u) filetype(%s)',
        --     buf, api.nvim_buf_get_name(buf), (is_exclude(buf) and 1 or 0),
        --     (api.nvim_buf_get_option(buf, 'buflisted') and 1 or 0),
        --     (api.nvim_buf_is_valid(buf) and 1 or 0), string.len(api.nvim_buf_get_name(buf)),
        --     api.nvim_buf_get_option(buf, 'filetype'))
        local buffer_groups = get_buffer_content(bufnr)
        if not M.is_buf_exclude(bufnr)
            and api.nvim_buf_get_option(bufnr, 'buflisted')
            and bufnr ~= current_bufnr
            and (not current_group or not buffer_groups or vim.tbl_contains(buffer_groups, current_group)) then
            f:write(api.nvim_buf_get_name(bufnr) .. '\n')
            -- print('save bufnr:' .. bufnr .. ' current_group:' .. current_group)
            update_buffer_content(bufnr, group_name)
        end
    end

    f:close()
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

    local current_bufnr = nil
    for line in f:lines() do
        local bufnr = open_buffer(line)
        -- futil.info('load bufnr:%d buffer name:%s group_name:%s', bufnr, line, group_name)
        if api.nvim_buf_is_valid(bufnr) then
            if not current_bufnr then -- 第一行是 current_buf_name
                current_bufnr = bufnr
            end
            -- vim.pretty_print(buffer_contents[bufnr] and buffer_contents[bufnr].buffer_groups or '------ nil -----------')
            update_buffer_content(bufnr, group_name)
        end
    end
    f:close()

    api.nvim_set_current_buf(current_bufnr)
end

local function group_delete(group_name)
    local group_path = gen_group_path(group_name)
    if check_file_exist(group_path) then
        os.remove(group_path)
    end

    for _, bufnr in ipairs(api.nvim_list_bufs()) do
        if not M.is_buf_exclude(bufnr) then
            local buffer_groups = get_buffer_content(bufnr)
            if buffer_groups and vim.tbl_contains(buffer_groups, group_name) then
                api.nvim_buf_delete(bufnr)
            end
            delete_buffer_content(bufnr)
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
            local buffer_groups = get_buffer_content(bufnr)
            if string.len(buffer_name) ~= 0 and buffer_groups and
                (current_group and not vim.tbl_contains(buffer_groups, current_group)) then
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
        update_group_state(argument.args)
        group_load(argument.args)
    else
        futil.delete_buffers(false)
        group_load(argument.args)
        update_group_state(argument.args)
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
    update_group_state(argument.args)
    group_load(argument.args)
    update_bufferline()
end, { nargs = 1, complete = group_complete })

api.nvim_create_user_command('SPrevious', function()
    if not last_group then
        futil.warn({ title = 'SPrevious' }, 'last_group is empty!')
        return
    end

    group_save(current_group)
    update_group_state(last_group)
    group_load(last_group)
    update_bufferline()
end, {})

api.nvim_create_user_command('SPrint', function()
    futil.info({ title = 'SPrint' }, 'current(%s), last(%s)', current_group, last_group)
    vim.pretty_print(buffer_contents)
end, {})

api.nvim_create_user_command('SClear', function()
    if current_group then
        group_save(current_group)
    end
    clear_all_buffer_var()
    current_group = nil
    last_group = nil
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
    callback = function(arg)
        if current_group and not M.is_buf_exclude(arg.buf) then
            -- futil.info('BufEnter -> bufnr:%u name(%s) current_group(%s) last_group(%s)', arg.buf, arg.file, current_group, last_group)
            update_buffer_content(arg.buf, current_group)
            update_bufferline()
        end
    end
})

api.nvim_create_autocmd('BufDelete', {
    pattern = '*',
    callback = function (arg)
        if current_group and not M.is_buf_exclude(arg.buf) then
            -- futil.info('BufDelete -> bufnr:%u name(%s) current_group(%s) last_group(%s)', arg.buf, arg.file, current_group, last_group)
            delete_buffer_content(arg.buf)
            update_bufferline()
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
