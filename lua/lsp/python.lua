-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- pyright 依赖 nodejs 和 npm
-- require('lspconfig')['pyright'].setup {
--     capabilities = capabilities
-- }
-- 需要去 zshenv 添加 path 环境变量
require('lspconfig')['jedi_language_server'].setup {
    capabilities = capabilities,
    on_attach = require'lsp.common'.custom_lsp_attach,
}
