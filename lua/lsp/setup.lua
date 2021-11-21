local lsp_lua = require('lsp.lua')
local lsp_python = require('lsp.python')

local M = {}
function M.setup()
    lsp_lua.setup()
    lsp_python.setup()
end

return M
