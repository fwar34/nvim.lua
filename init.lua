local vim = vim
local api = vim.api

require("options")

local function set_leader()
    vim.g.mapleader = ";"
    vim.g.maplocalleader = " "
    api.nvim_set_keymap('n', ' ', '', {noremap = true})
    api.nvim_set_keymap('x', ' ', '', {noremap = true})
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

require("key_mappings")
require("autocmd")
-- require("terminal").setup()
require("lsp")
