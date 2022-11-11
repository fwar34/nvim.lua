local futil = require('futil')
local api = vim.api

local current_session = nil
local last_session = nil
local session_directory = '~/.config/nvim/sessionmgr/'

local function check_file_exist(filename)
    local file, err = io.open(vim.fn.expand(filename), 'r')
    if file then
        file:close()
    end
    return err == nil
end

local function gen_session_path(session_name)
    return session_directory .. session_name .. '.vim'
end

local function session_save(session_name)
    local session_path = gen_session_path(session_name)
    -- futil.info('save current:%s', session_path)
    vim.cmd('silent mksession! ' .. session_path)
    return check_file_exist(session_path)
end

local function session_load(session_name)
    local session_path = gen_session_path(session_name)
    if not check_file_exist(session_path) then
        futil.err('sessionmgr: session file(%s) not exist', session_path)
        return
    end
    vim.cmd('silent source ' .. session_path)

    if session_name ~= current_session then
        last_session = current_session
    end
    current_session = session_name
end

local function session_delete(session_name)
    local session_path = gen_session_path(session_name)
    if check_file_exist(session_path) then
        os.remove(vim.fn.expand(session_path))
    end
end

if not check_file_exist(session_directory) then
    os.execute('mkdir -p ' .. session_directory)
end

local function session_complete()
    local match = {}
    local output = vim.fn.execute('!ls ' .. vim.fn.expand(session_directory))
    for line in string.gmatch(output, "(%w+).vim") do
        table.insert(match, line)
    end
    return match
end

api.nvim_create_user_command('SSave', function (argument)
    session_save(argument.args)
    current_session = argument.args
end, { nargs = 1, bang = true })

api.nvim_create_user_command('SDelete', function (argument)
    session_delete(argument.args)
end, { nargs = 1, complete = session_complete })

api.nvim_create_user_command('SLoad', function (argument)
    futil.delete_buffers(false)
    session_load(argument.args)
    -- futil.info('current:%s, last:%s', current_session, last_session)
end, { nargs = 1, complete = session_complete })

api.nvim_create_user_command('SSwitch', function (argument)
    if session_save(current_session) then
        futil.delete_buffers(false)
        session_load(argument.args)
    end
end, { nargs = 1, complete = session_complete })

api.nvim_create_user_command('SPrevious', function ()
    if session_save(current_session) then
        futil.delete_buffers(false)
        session_load(last_session)
    end
end, {})

api.nvim_create_user_command('SPrint', function ()
    futil.info('current:%s, last:%s', current_session, last_session)
    session_complete()
end, {})
