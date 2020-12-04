local autocmd = {}

local function cmd_for_packer()
    vim.cmd [[ autocmd! BufWritePost plugins.lua PackerCompile ]]
end

local function auto_themes()
    vim.cmd [[ autocmd! FileType c,cpp colorscheme wombat256 ]]
end

function autocmd.setup()
    cmd_for_packer()
    -- auto_themes()
end

return autocmd
