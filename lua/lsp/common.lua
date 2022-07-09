-- https://github.com/neovim/nvim-lspconfig#Suggested-configuration
local M = {}
function M.custom_lsp_attach(client, bufnr)
    -- See `:help nvim_buf_set_keymap()` for more information
    vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true })
    vim.api.nvim_buf_set_keymap(0, 'n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true })
    vim.api.nvim_buf_set_keymap(0, 'n', '<localleader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', { noremap = true })
    -- ... and other keymappings for LSP

    local opts = { noremap = true }
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>ee', vim.diagnostic.open_float, opts)

    local bufopts = { noremap = true, buffer = bufnr }
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)

    -- Use LSP as the handler for omnifunc.
    --    See `:help omnifunc` and `:help ins-completion` for more information.
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- For plugins with an `on_attach` callback, call them here. For example:
    -- require('completion').on_attach()
end

return M
