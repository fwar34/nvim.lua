-- https://github.com/neovim/nvim-lspconfig#Suggested-configuration
local M = {}

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, vim.tbl_extend('force', opts, { desc = 'diagnostic goto_prev' }))
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, vim.tbl_extend('force', opts, { desc = 'diagnostic goto_next' }))
vim.keymap.set('n', '<space>ee', vim.diagnostic.open_float,
    vim.tbl_extend('force', opts, { desc = 'diagnostic open_float' }))
vim.keymap.set('n', '<space>qe', vim.diagnostic.setloclist,
    vim.tbl_extend('force', opts, { desc = 'diagnostic setloclist' }))

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
function M.custom_lsp_attach(_, bufnr)
    -- Use LSP as the handler for omnifunc.
    --    See `:help omnifunc` and `:help ins-completion` for more information.
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    -- See `:help nvim_buf_set_keymap()` for more information
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', bufopts, { desc = 'goto declaration' }))
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', bufopts, { desc = 'goto definition' }))
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', bufopts, { desc = 'lsp buffer hover' }))
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
        vim.tbl_extend('force', bufopts,
            { desc = 'Lists all the implementations for the symbol under the cursor in the quickfix window.' }))
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition,
        vim.tbl_extend('force', bufopts, { desc = 'lsp type_definition' }))
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action,
        vim.tbl_extend('force', bufopts, { desc = 'lsp code_action' }))
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', bufopts, { desc = 'find references' }))
    vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, vim.tbl_extend('force', bufopts, { desc = 'goto definition' }))
    vim.keymap.set('n', '<space>==', function() vim.lsp.buf.format { async = true } end,
        vim.tbl_extend('force', bufopts, { desc = 'lsp buffer format' }))
    -- ... and other keymappings for LSP
end

return M
