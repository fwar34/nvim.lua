local global = require('global')
local futil = {mouse_help = '', mouse_g = ''}

function futil.toggle_line_number()
    if vim.wo.number then
        vim.cmd('set nonumber')
    else
        vim.cmd('set number')
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


return futil
