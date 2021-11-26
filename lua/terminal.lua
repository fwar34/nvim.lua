local terminal = setmetatable({}, {__index = {mouse_floaterm = '', mouse_terminal = ''}})

function terminal.setup()
    -- floaterm mouse autocmd
    vim.cmd [[ augroup floaterm_mouse ]]
    vim.cmd [[   autocmd! ]]
    -- vim.cmd [[   autocmd FileType floaterm lua require('terminal'):set_mouse_for_floaterm() ]]
    vim.cmd [[   autocmd BufLeave * lua require('terminal'):restore_mouse_from_floaterm() ]]
    vim.cmd [[ augroup END ]]

    -- terminal mouse autocmd
    vim.cmd [[ augroup terminal_mouse ]]
    vim.cmd [[   autocmd! ]]
    -- vim.cmd [[   autocmd BufEnter * lua require('terminal'):set_mouse_for_terminal() ]]
    vim.cmd [[   autocmd BufLeave * lua require('terminal'):restore_mouse_from_terminal() ]]
    vim.cmd [[ augroup END ]]
end

function terminal:set_mouse_for_floaterm()
    self.mouse_floaterm = vim.o.mouse
    vim.o.mouse = 'n'
end

function terminal:restore_mouse_from_floaterm()
    if vim.bo.filetype == 'floaterm' then
        vim.o.mouse = self.mouse_floaterm
    end
end

function terminal:set_mouse_for_terminal()
    if string.find(vim.fn.bufname(), 'term:', 1) ~= nil and vim.bo.filetype ~= 'floaterm' then
        self.mouse_terminal = vim.o.mouse
        vim.o.mouse = 'n'
    end
    print(vim.fn.bufname())
end

function terminal:restore_mouse_from_terminal()
    if string.find(vim.fn.bufname(), 'term:', 1) ~= nil and vim.bo.filetype ~= 'floaterm' then
        vim.o.mouse = self.mouse_terminal
    end
end

return terminal
