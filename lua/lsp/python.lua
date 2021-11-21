local M = {}

function M.setup()
    require'lspconfig'.pylsp.setup{}
end

return M
