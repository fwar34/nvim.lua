-- vim.fn.execute('!make')
-- require('fennel_test')

-- check packer install
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    vim.cmd 'packadd packer.nvim'
else
    require('plugins')
end

require("options")
require("key_mappings")
require("autocmd")
-- require("terminal").setup()
require("lsp").setup()
-- require("lsp")

if vim.g.neovide then
    vim.g.neovide_cursor_trail_legnth = 0
    vim.g.neovide_cursor_animation_length = 0
    -- vim.o.guifont = "Jetbrains Mono"
    -- https://github.com/laishulu/Sarasa-Mono-SC-Nerd
    vim.o.guifont = 'Sarasa Mono SC Nerd'
end
