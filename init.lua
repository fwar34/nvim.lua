local vim = vim
local api = vim.api
local cmd = vim.cmd

-- https://github.com/nvim-tree/nvim-tree.lua
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

cmd('set termguicolors')

require("options")

local function set_leader()
    vim.g.mapleader = ";"
    vim.g.maplocalleader = " "
    api.nvim_set_keymap('n', ' ', '', { noremap = true })
    api.nvim_set_keymap('x', ' ', '', { noremap = true })
end

set_leader()

-- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
require('impatient')

require("autocmd")
require("lsp")
require("key_mappings")

require('group.manager')
require('group.buffers')
