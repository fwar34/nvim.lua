-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- pyright 依赖 nodejs 和 npm
-- require('lspconfig')['pyright'].setup {
--     capabilities = capabilities
-- }
require('lspconfig')['pylsp'].setup {
    capabilities = capabilities
}
