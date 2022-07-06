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

require("neovide")
require("options")
require("key_mappings")
require("autocmd")
-- require("terminal").setup()
require("lsp")
