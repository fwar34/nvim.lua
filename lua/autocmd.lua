local autocmd = {}

local function cmd_for_packer()
    vim.cmd [[ autocmd BufWritePost plugins.lua PackerCompile ]]
end

function autocmd.setup()
    cmd_for_packer()
end

return autocmd
