local global = require('global')
local futil = {mouse_help = '', mouse_g = ''}
local vim = vim
local api = vim.api

function futil.toggle_line_number()
    if vim.wo.number then
        vim.cmd('set nonumber')
        -- vim.cmd('set norelativenumber')
    else
        vim.cmd('set number')
        -- vim.cmd('set relativenumber')
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
    vim.cmd('tcd ~/.config/nvim/lua/')
    vim.fn.execute('!make', '')
    vim.cmd('tcd ' .. cur_pwd)
end

function futil.search_word()
    vim.cmd('normal ye')
    vim.cmd('Ag ' .. vim.fn.getreg('0'))
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
    vim.cmd('normal H')
    -- get cursor info
    cur_pos = vim.fn.getcurpos()
    if mark_t[2] ~= cur_pos[2] then
        vim.fn.setpos("'Y", cur_pos)
    end
    vim.cmd('normal `X[[k')
    print(vim.fn.getline('.'))
    vim.cmd("normal 'Yzt`X")
end

function futil.unmap(maps)
    for _, v in ipairs(maps) do
        vim.cmd [[ unmap .. v ]]
        print("yyyyy")
    end
end

function futil.delete_buffers(exclude_current)
    local buffers = vim.api.nvim_list_bufs()
    local current = vim.api.nvim_get_current_buf()
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

return futil
