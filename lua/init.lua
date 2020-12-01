local options = require('options')
local plugins = require('plugins')
local key_mappings = require('key_mappings')

local core = {}

local function check_packer()
    local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
        vim.cmd 'packadd packer.nvim'
    end
end

function core.init()
    check_packer()
    options.load_options()
    key_mappings.setup()
end

return core
