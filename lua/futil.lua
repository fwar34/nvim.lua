local global = require('global')
local futil = {mouse_help = '', mouse_g = ''}
local vim = vim
local api = vim.api
local cmd = vim.cmd

function futil.toggle_line_number()
    if vim.wo.number then
        cmd('set nonumber')
        -- cmd('set norelativenumber')
    else
        cmd('set number')
        -- cmd('set relativenumber')
        global.dump(vim.bo.filetype)
    end
end

function futil:set_mouse()
    if vim.bo.filetype == 'help' then
        self.mouse_help = vim.o.mouse
        vim.o.mouse = 'n'
    end
end

function futil:restore_mouse()
    if vim.bo.filetype == 'help' then
        vim.o.mouse = self.mouse_help
    end
end

function futil.toggle_mouse()
    if vim.o.mouse == 'a' then
        vim.o.mouse = ''
        print('set mouse=')
    else
        vim.o.mouse = 'a'
        print('set mouse = a')
    end
end

function futil.make_fennel()
    local cur_pwd = vim.fn.getcwd()
    cmd('tcd ~/.config/nvim/lua/')
    vim.fn.execute('!make', '')
    cmd('tcd ' .. cur_pwd)
end

function futil.search_word()
    cmd('normal ye')
    cmd('Ag ' .. vim.fn.getreg('0'))
end

function futil.coc_status()
    print(vim.fn['coc#status']())
end

-- reference from help : restore-position
function futil.display_function()
    -- get mark s info
    local mark_s = vim.fn.getpos("'X")
    local mark_t = vim.fn.getpos("'Y")
    -- get cursor info
    local cur_pos = vim.fn.getcurpos()
    if mark_s[2] ~= cur_pos[2] then
        vim.fn.setpos("'X", cur_pos)
    end
    -- cmd('normal H')
    -- get cursor info
    cur_pos = vim.fn.getcurpos()
    if mark_t[2] ~= cur_pos[2] then
        vim.fn.setpos("'Y", cur_pos)
    end
    cmd('normal `X[[k')
    local func_name = vim.fn.getline('.')
    cmd("normal 'Yzt`X")
    print(func_name)
end

function futil.find_previous_brace_in_first_column()
    local current = vim.fn.getpos('.')
    local line_num = current[2]
    repeat
        local current_line_array = api.nvim_buf_get_lines(0, line_num, line_num + 1, false) -- nvim_buf_get_lines 行数从0开始，左闭右开
        local current_line = current_line_array[1]
        if current_line ~= nil and string.sub(current_line, 1, 1) == '{' and line_num - 1 >= 0 then
            local ret_line = api.nvim_buf_get_lines(0, line_num - 1, line_num, false)
            print(ret_line[1])
            return
        end
        line_num = line_num - 1
    until line_num < 0
    print('not found { in first column!')
end

function futil.unmap(maps)
    for _, v in ipairs(maps) do
        cmd [[ unmap .. v ]]
        print("yyyyy")
    end
end

function futil.delete_buffers(exclude_current)
    local buffers = api.nvim_list_bufs()
    local current = api.nvim_get_current_buf()
    -- print("list:", vim.inspect(buffers), "current:", current)

    for _, buf in ipairs(buffers) do
        -- vim.pretty_print('buf:' .. api.nvim_buf_get_name(buf) .. ' is load:' .. (vim.api.nvim_buf_is_loaded(buf) and 1 or 0) .. ' ft:' .. api.nvim_buf_get_option(buf, 'filetype'))
        local ft = api.nvim_buf_get_option(buf, 'filetype')
        if ft ~= 'floaterm' and ft ~= 'rnvimr' then
            if exclude_current then
                if buf ~= current then
                    api.nvim_buf_delete(buf, {})
                end
            else
                api.nvim_buf_delete(buf, {})
            end
        end
    end
end

function futil.is_windows()
    return vim.loop.os_uname().sysname == 'Windows_NT'
end

function futil.dump_all_buffers()
    local buffers = api.nvim_list_bufs()
    for _, buf in ipairs(buffers) do
        vim.pretty_print('buf num:' .. buf ..
        ' name:' .. api.nvim_buf_get_name(buf) ..
        ' is load:' .. (vim.api.nvim_buf_is_loaded(buf) and 1 or 0) ..
        ' ft:' .. api.nvim_buf_get_option(buf, 'filetype') ..
        ' valid:' .. (api.nvim_buf_is_valid(buf) and 1 or 0))
    end
end

api.nvim_create_user_command('DumpBuffers', futil.dump_all_buffers, {})

function futil.info(...)
    vim.notify(string.format(...), vim.log.levels.INFO)
end

function futil.warn(...)
    vim.notify(string.format(...), vim.log.levels.WARN)
end

function futil.err(...)
    vim.notify(string.format(...), vim.log.levels.ERROR)
end

function futil.put(...)
    local objects = {}
    for i = 1, select('#', ...) do
        local v = select(i, ...)
        table.insert(objects, vim.inspect(v))
     end

     print(table.concat(objects, '\n'))
     return ...
end

return futil
