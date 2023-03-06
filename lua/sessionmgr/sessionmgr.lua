--[[
group 文件保存的第一行是 current_buf_name
]]
local api = vim.api
local cmd = vim.cmd
local fn = vim.fn
local futil = require('futil')
local is_windows = require('global').is_windows
local check_file_exist = require('global').check_file_exist

local last_session = nil
local current_session = nil
--[[ sessions = {
    session1 = {
        '/home/xxx/test.cpp', -- 第一个元素为 current buffer
        '/home/xxx/test2.cpp',
    },
    session2 = {
        '/home/xxx/test.cpp',
        '/home/xxx/manager.el',
    },
} ]]
sessions = {}
local M = {}

local function insert_session(session, bufnr)
    local buffer_name = api.nvim_buf_get_name(bufnr)
    if not vim.tbl_contains(sessions[session], buffer_name) then
        table.insert(sessions[session], buffer_name)
    end
end

local function update_session_state(session)
    if session ~= current_session then
        last_session = current_session
    end
    current_session = session
end

local session_dirctory = fn.expand(is_windows and '~/.sessions/' or '~/.sessions/')
if fn.isdirectory(session_dirctory) == 0 then
    fn.mkdir(session_dirctory, 'p')
end

local function gen_session_path(session)
    return session_dirctory .. session .. '.session'
end

function M.is_buf_exclude(bufnr)
    if not api.nvim_buf_is_valid(bufnr) then
        return true
    end

    if not api.nvim_buf_get_option(bufnr, 'buflisted') then
        return true
    end

    local ft = api.nvim_buf_get_option(bufnr, 'filetype')
    if ft == 'floaterm' or ft == 'rnvimr' or ft == 'toggleterm' or ft == '' or ft == 'help' or ft == 'qf' or
        string.len(api.nvim_buf_get_name(bufnr)) == 0 then
        return true
    end
    return false
end

function M.current_session()
    return current_session
end

-- TODO:
function M.is_buf_hide(bufnr)
    if sessions[current_session] and not vim.tbl_contains(sessions[current_session], api.nvim_buf_get_name(bufnr)) then
        -- futil.warn('current(%s) last(%s) hide buf(%s)', current_session, last_session, api.nvim_buf_get_name(bufnr))
        return true
    end
    -- futil.warn('current(%s) last(%s) show buf(%s)', current_session, last_session, api.nvim_buf_get_name(bufnr))
    return false
end

local function session_save(session)
    local session_path = gen_session_path(session)
    local f = io.open(session_path, 'w+')
    if not f then
        futil.err({ title = 'session_save' }, 'failed to open file(%s)', session_path)
        return nil
    end

    if require('nvim-tree.view').is_visible() then
        cmd('NvimTreeToggle')
    end

    local current_bufnr = api.nvim_get_current_buf()
    local current_buf_name = api.nvim_buf_get_name(current_bufnr)
    if sessions[session] then -- session 存在的话先更新 current buffer 到第一个元素
        if not M.is_buf_exclude(current_bufnr) then
            for i, v in pairs(sessions[session]) do
                if v == current_buf_name then
                    table.remove(sessions[session], i)
                    break
                end
            end
            table.insert(sessions[session], 1, api.nvim_buf_get_name(current_bufnr))
        end
    else
        -- futil.info('session_save current(%s) last(%s)', current_session, last_session)
        sessions[session] = {}
        if not M.is_buf_exclude(current_bufnr) then
            -- 索引 1 是 current 文件 buffer
            insert_session(session, current_bufnr)
        end

        for _, bufnr in pairs(api.nvim_list_bufs()) do
            if not M.is_buf_exclude(bufnr) and bufnr ~= current_bufnr then
                insert_session(session, bufnr)
            end
        end
    end

    for _, buffer_name in pairs(sessions[session]) do
        f:write(buffer_name .. '\n')
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

local function session_load(session)
    local session_path = gen_session_path(session)
    if not check_file_exist(session_path) then
        futil.err({ title = 'session_load' }, 'sessionmgr: group file(%s) not exist', session_path)
        return
    end

    local f = io.open(session_path, 'r')
    if not f then
        futil.err({ title = 'session_load' }, 'open file(%s) failed', session_path)
        return
    end

    sessions[session] = {}
    local current_bufnr = nil
    for line in f:lines() do
        -- futil.info('read file(%s) line(%s) current(%s) last(%s)', session_path, line, current_session, last_session)
        local bufnr = open_buffer(line)
        if api.nvim_buf_is_valid(bufnr) then
            -- futil.info('load bufer(%s) current(%s) last(%s) current_bufnr', line, current_session, last_session, current_bufnr)
            if not current_bufnr then -- 第一行是 current_buf_name
                current_bufnr = bufnr
            end
            insert_session(session, bufnr)
        end
    end
    f:close()

    api.nvim_set_current_buf(current_bufnr)
end

local function session_delete(session)
    local session_path = gen_session_path(session)
    if check_file_exist(session_path) then
        os.remove(session_path)
    end

    sessions[session] = nil

    if session == current_session then
        current_session = nil
    end

    if session == last_session then
        last_session = nil
    end
end

local function update_bufferline()
    if sessions[current_session] then
        vim.cmd('redrawtabline')
    end
end

-- local function group_complete(arg, cmd_line)
local function group_complete(arg)
    -- futil.info('arg: %s', arg)
    -- futil.info('cmd_line: %s', cmd_line)
    local match = {}
    -- local output = is_windows and fn.execute('!dir ' .. session_dirctory) or fn.execute('!ls ' .. session_dirctory)
    local output = fn.execute(is_windows and '!dir ' .. session_dirctory or '!ls ' .. session_dirctory)
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
    argument.args = argument.args or current_session
    session_save(argument.args)
    update_session_state(argument.args)
    update_bufferline()
end, { nargs = '?', bang = true, complete = group_complete })

api.nvim_create_user_command('SDelete', function(argument)
    session_delete(argument.args)
    -- TODO: need switch to another session file
    -- if not current_session and loaded_groups[1] then
    --     session_load(loaded_groups[1])
    -- end
    update_bufferline()
end, { nargs = 1, complete = group_complete })

api.nvim_create_user_command('SLoad', function(argument)
    if not check_file_exist(gen_session_path(argument.args)) then
        futil.warn({ title = 'SLoad' }, 'group(%s) not exist', argument.args)
        return
    end

    if argument.args == current_session then
        futil.warn({ title = 'SLoad' }, 'target group(%s) is equal to current group', argument.args)
        return
    end

    -- futil.info('current:%s, last:%s', current_session, last_session)
    if current_session then
        session_save(current_session)
        -- vim.pretty_print(sessions)
        -- futil.info('SLoad:complete save------------------------')
        update_session_state(argument.args)
        session_load(argument.args)
        -- vim.pretty_print(sessions)
        -- futil.info('SLoad:complete load------------------------')
    else
        futil.delete_buffers(false)
        session_load(argument.args)
        update_session_state(argument.args)
    end
    update_bufferline()
    -- futil.info('current:%s, last:%s', current_session, last_session)
end, { nargs = 1, complete = group_complete })

api.nvim_create_user_command('SSwitch', function(argument)
    if argument.args == current_session then
        futil.warn({ title = 'SSwitch' }, 'target group(%s) is equal to current group', argument.args)
        return
    end

    if not check_file_exist(gen_session_path(argument.args)) then
        futil.err({ title = 'SSwitch' }, 'target group(%s) not exist', argument.args)
        return
    end

    session_save(current_session)
    update_session_state(argument.args)
    session_load(argument.args)
    update_bufferline()
end, { nargs = 1, complete = group_complete })

api.nvim_create_user_command('SPrevious', function()
    if not last_session then
        futil.warn({ title = 'SPrevious' }, 'last_session is empty!')
        return
    end

    local previous_session = last_session
    -- futil.info('SPrevious current:%s, last_session:%s', current_session, last_session)
    session_save(current_session)
    -- vim.pretty_print(sessions)
    -- futil.info('SPrevious:complete save------------------------')
    update_session_state(previous_session)
    session_load(previous_session)
    -- vim.pretty_print(sessions)
    -- futil.info('SPrevious:complete load------------------------')
    update_bufferline()
end, {})

api.nvim_create_user_command('SPrint', function()
    futil.info({ title = 'SPrint' }, 'current(%s), last(%s)', current_session, last_session)
    vim.pretty_print(sessions)
end, {})

api.nvim_create_user_command('SClear', function()
    if current_session then
        session_save(current_session)
    end
    sessions = {}
    current_session = nil
    last_session = nil
    update_bufferline()
end, {})

api.nvim_create_autocmd('VimLeavePre', {
    callback = function()
        if current_session then
            session_save(current_session)
        end
    end,
})

api.nvim_create_autocmd('BufEnter', {
    pattern = '*',
    callback = function(arg)
        if sessions[current_session] and not M.is_buf_exclude(arg.buf) then
            -- futil.info('BufEnter -> bufnr:%u name(%s) current_session(%s) last_session(%s)', arg.buf, arg.file, current_session, last_session)
            insert_session(current_session, arg.buf)
            -- update_bufferline()
        end
    end
})

api.nvim_create_autocmd('BufDelete', {
    pattern = '*',
    callback = function(arg)
        if sessions[current_session] and not M.is_buf_exclude(arg.buf) then
            -- futil.info('BufDelete -> bufnr:%u name(%s) current_session(%s) last_session(%s)', arg.buf, arg.file, current_session, last_session)
            local buffer_name = api.nvim_buf_get_name(arg.buf)
            for i, v in pairs(sessions[current_session]) do
                if v == buffer_name then
                    table.remove(sessions[current_session], i)
                    break
                end
            end
            -- update_bufferline()
        end
    end
})

function SessionMgrGroup()
    return current_session or ''
end

cmd([[
function! SessionMgrStatus()
return v:lua.SessionMgrGroup()
endfunction
]])

return M
