local futil = require('futil')
local is_windows = require('global').is_windows
local api = vim.api
local cmd = vim.cmd

local current_session = nil
local last_session = nil

local session_directory = vim.fn.expand(is_windows and '~/AppData/Local/nvim/sessionmgr/' or '~/.config/nvim/sessionmgr/')
-- print(session_directory)
if vim.fn.isdirectory(session_directory) == 0 then
    vim.fn.mkdir(session_directory, 'p')
end

local function check_file_exist(filename)
    -- local file, err = io.open(vim.fn.expand(filename), 'r')
    -- if file then
    --     file:close()
    -- end
    -- return err == nil
    return vim.fn.filereadable(filename) == 1
end

local function gen_session_path(session_name)
    return session_directory .. session_name .. '.vim'
end

local function session_save(session_name)
    local session_path = gen_session_path(session_name)
    -- futil.info('save current:%s', session_path)
    local view = require('nvim-tree.view')
    if view.is_visible() then
        cmd('NvimTreeToggle')
    end
    cmd('silent mksession! ' .. session_path)
    return check_file_exist(session_path)
end

local function session_load(session_name)
    local session_path = gen_session_path(session_name)
    if not check_file_exist(session_path) then
        futil.err('sessionmgr: session file(%s) not exist', session_path)
        return
    end
    -- silent加上!,会跳过错误信息
    cmd('silent! source ' .. session_path)

    if session_name ~= current_session then
        last_session = current_session
    end
    current_session = session_name
end

local function session_delete(session_name)
    local session_path = gen_session_path(session_name)
    if check_file_exist(session_path) then
        os.remove(session_path)
    end
end

-- local function session_complete(arg, cmd_line)
local function session_complete(arg)
    -- futil.info('arg: %s', arg)
    -- futil.info('cmd_line: %s', cmd_line)
    local match = {}
    -- local output = is_windows and vim.fn.execute('!dir ' .. session_directory) or vim.fn.execute('!ls ' .. session_directory)
    local output = vim.fn.execute(is_windows and '!dir ' .. session_directory or '!ls ' .. session_directory)
    for line in string.gmatch(output, "(%w+).vim") do
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
    argument.args = argument.args ~= '' and argument.args or current_session
    session_save(argument.args)
    current_session = argument.args
end, { nargs = '?', bang = true, complete = session_complete })

api.nvim_create_user_command('SDelete', function(argument)
    session_delete(argument.args)
end, { nargs = 1, complete = session_complete })

api.nvim_create_user_command('SLoad', function(argument)
    if not check_file_exist(gen_session_path(argument.args)) then
        futil.info('session %s not exist', argument.args)
        return
    end

    if current_session then
        session_save(current_session)
    end

    futil.delete_buffers(false)
    session_load(argument.args)
    -- futil.info('current:%s, last:%s', current_session, last_session)
end, { nargs = 1, complete = session_complete })

api.nvim_create_user_command('SSwitch', function(argument)
    if session_save(current_session) then
        futil.delete_buffers(false)
        if not check_file_exist(gen_session_path(argument.args)) then
            if session_save(argument.args) then
                last_session = current_session
                current_session = argument.args
            end
        else
            session_load(argument.args)
        end
    end
end, { nargs = 1, complete = session_complete })

api.nvim_create_user_command('SPrevious', function()
    if not last_session then
        futil.info('last_session is empty!')
        return
    end

    if session_save(current_session) then
        futil.delete_buffers(false)
        session_load(last_session)
    end
end, {})

api.nvim_create_user_command('SPrint', function()
    futil.info('current:%s, last:%s', current_session, last_session)
    session_complete()
end, {})

api.nvim_create_autocmd({ 'VimLeavePre' }, {
    callback = function()
        if current_session then
            session_save(current_session)
        end
    end,
})

function CurrentSession()
    return current_session and current_session or ''
end

cmd([[ 
function! SessionMgrStatus()
return v:lua.CurrentSession()
endfunction 
]])
