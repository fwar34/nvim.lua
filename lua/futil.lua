local global = require('global')
local futil = {}

function futil.toggle_line_number()
    if vim.wo.number then
        vim.cmd('set nonumber')
    else
        vim.cmd('set number')
        futil.toggle_mouse()
    end
end

function futil.toggle_mouse()
    if vim.o.mouse ~= '' then
        vim.o.mouse = 'n'
    else
        vim.o.mouse = ''
    end
end

return futil
