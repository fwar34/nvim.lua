local futil = {}

function futil.toggle_line_number()
    if vim.wo.number then
        vim.cmd('set nonumber')
    else
        vim.cmd('set number')
    end
end

return futil
