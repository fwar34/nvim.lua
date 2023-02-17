local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
--Enable (broadcasting) snippet capability for completion
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- if not require('futil').is_windows() then
--     require 'lspconfig'.cssmodules_ls.setup {
--         capabilities = capabilities,
--         on_attach = require 'lsp.common'.custom_lsp_attach,
--     }
-- end

require 'lspconfig'.tsserver.setup {
    capabilities = capabilities,
    on_attach = require'lsp.common'.custom_lsp_attach,
}

