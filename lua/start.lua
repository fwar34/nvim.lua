local options = require('options')
local key_mappings = require('key_mappings')
local autocmd = require('autocmd')
local terminal = require('terminal')
local vim = vim
local lsp_lua = require('lsp.lua')

-- vim.fn.execute('!make')
-- require('fennel_test')

local start = {}

local function check_packer()
    local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
        vim.cmd 'packadd packer.nvim'
    else
        require('plugins')
    end
end

function start.init()
    check_packer()
    options.load_options()
    key_mappings.setup()
    autocmd.setup()
    terminal.setup()
    lsp_lua.setup()
end

return start
