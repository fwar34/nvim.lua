require('lsp.python')
require('lsp.go')
require('lsp.rust')
require('lsp.lua')
require('lsp.js')

local function setup()
    -- LSP handlers configuration
    -- local lsp = {
    --     float = {
    --         focusable = true,
    --         style = "minimal",
    --         border = "rounded",
    --     },
    -- }

    -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    -- vim.lsp.handlers.hover, {
    --     -- Use a sharp border with `FloatBorder` highlights
    --     border = "single"
    -- }
    -- )

    -- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#textDocument_formatting
    -- :h vim.lsp.buf.formatting
    -- vim.lsp.handlers["textDocument/formatting"] = vim.lsp.with(vim.lsp.buf.formatting, {insertSpaces = true})
    -- vim.lsp.handlers["textDocument/formatting"] = vim.lsp.with(vim.lsp.buf.format, {insertSpaces = true, async = true})

    -- Hover configuration
    -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, lsp.float)
    -- Signature help configuration
    -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, lsp.float)


    -- local custom_lsp_attach = function(client)
    --   -- See `:help nvim_buf_set_keymap()` for more information
    --   vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
    --   vim.api.nvim_buf_set_keymap(0, 'n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true})
    --   -- ... and other keymappings for LSP

    --   -- Use LSP as the handler for omnifunc.
    --   --    See `:help omnifunc` and `:help ins-completion` for more information.
    --   vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    --   -- For plugins with an `on_attach` callback, call them here. For example:
    --   -- require('completion').on_attach()
    -- end
end

setup()
