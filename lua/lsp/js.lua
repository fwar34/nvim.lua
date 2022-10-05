local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require 'lspconfig'.cssmodules_ls.setup {
    capabilities = capabilities,
    on_attach = require 'lsp.common'.custom_lsp_attach,
}

require 'lspconfig'.tsserver.setup {}

--Enable (broadcasting) snippet capability for completion
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require 'lspconfig'.jsonls.setup {
    capabilities = capabilities,
}
