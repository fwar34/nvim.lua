-- local terminal = setmetatable({}, {__index = {mouse_floaterm = '', mouse_terminal = ''}})
local terminal = { mouse_floaterm = '', mouse_terminal = '' }
local cmd = vim.cmd

function terminal:set_mouse_for_floaterm()
  self.mouse_floaterm = vim.o.mouse
  vim.o.mouse = 'a'
end

function terminal:restore_mouse_from_floaterm()
  if vim.bo.filetype == 'floaterm' then
    vim.o.mouse = self.mouse_floaterm
  end
end

function terminal:set_mouse_for_terminal()
  if string.find(vim.fn.bufname(), 'term:', 1) ~= nil and vim.bo.filetype ~= 'floaterm' then
    self.mouse_terminal = vim.o.mouse
    vim.o.mouse = 'a'
  end
  print(vim.fn.bufname())
end

function terminal:restore_mouse_from_terminal()
  if string.find(vim.fn.bufname(), 'term:', 1) ~= nil and vim.bo.filetype ~= 'floaterm' then
    vim.o.mouse = self.mouse_terminal
  end
end

function terminal.setup()
  -- floaterm mouse autocmd
  -- cmd [[ augroup floaterm_mouse ]]
  -- cmd [[   autocmd! ]]
  -- -- cmd [[   autocmd FileType floaterm lua require('terminal'):set_mouse_for_floaterm() ]]
  -- cmd [[   autocmd BufLeave * lua require('terminal'):restore_mouse_from_floaterm() ]]
  -- cmd [[ augroup END ]]
  --
  -- -- terminal mouse autocmd
  -- cmd [[ augroup terminal_mouse ]]
  -- cmd [[   autocmd! ]]
  -- -- cmd [[   autocmd BufEnter * lua require('terminal'):set_mouse_for_terminal() ]]
  -- cmd [[   autocmd BufLeave * lua require('terminal'):restore_mouse_from_terminal() ]]
  -- cmd [[ augroup END ]]
end

return terminal
