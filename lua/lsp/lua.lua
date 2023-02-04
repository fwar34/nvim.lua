local M = {}

function M.setup()
    -- local system_name
    -- if vim.fn.has("mac") == 1 then
    --     system_name = "macOS"
    -- elseif vim.fn.has("unix") == 1 then
    --     system_name = "Linux"
    -- elseif vim.fn.has('win32') == 1 then
    --     system_name = "Windows"
    -- else
    --     print("Unsupported system for sumneko")
    -- end

    -- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
    local sumneko_root_path = vim.fn.stdpath("data") .. "/lsp_servers/sumneko_lua/extension/server/bin"
    -- local sumneko_binary = sumneko_root_path.."/bin/"..system_name

    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    -- Setup lspconfig.
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

    require'lspconfig'.sumneko_lua.setup {
        -- cmd = {sumneko_binary .. "/lua-language-server", "-E", sumneko_binary .. "/main.lua"};
        cmd = {sumneko_root_path .. "/lua-language-server", "-E", sumneko_root_path .. "/main.lua"};
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Setup your lua path
                    path = runtime_path,
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim'},
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                    -- https://github.com/neovim/nvim-lspconfig/issues/1700
                    checkThirdParty = false, -- THIS IS THE IMPORTANT LINE TO ADD
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
        capabilities = capabilities,
        on_attach = require'lsp.common'.custom_lsp_attach,
    }
end

M.setup()
