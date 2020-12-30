local global = require('global')
local futil = {mouse_help = '', mouse_g = ''}
local vim = vim

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
    if vim.o.mouse == 'n' then
        vim.o.mouse = ''
        print('set mouse=')
    else
        vim.o.mouse = 'n'
        print('set mouse = n')
    end
end

function futil.make_fennel()
    local cur_pwd = vim.fn.getcwd()
    vim.cmd('tcd ~/.config/nvim/lua/')
    vim.fn.execute('!make', '')
    vim.cmd('tcd ' .. cur_pwd)
end

function futil.search_word()
    vim.cmd('normal vey')
    vim.cmd('Ag ' .. vim.fn.getreg('0'))
end

function futil.coc_status()
    print(vim.fn['coc#status']())
end

-- reference from help : restore-position
function futil.display_function()
    -- get mark s info
    mark_s = vim.fn.getpos("'X")
    mark_t = vim.fn.getpos("'Y")
    -- get cursor info
    cur_pos = vim.fn.getcurpos()
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

return futil
