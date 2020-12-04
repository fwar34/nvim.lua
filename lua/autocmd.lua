local autocmd = {}

local function cmd_for_packer()
    vim.cmd [[ autocmd! BufWritePost plugins.lua PackerCompile ]]
end

local function auto_themes()
    vim.cmd [[ autocmd! FileType c,cpp colorscheme wombat256 ]]
end

local function map_q_to_quit()
    vim.cmd [[ autocmd! FileType help :map <buffer> q <CMD>q<CR> ]]
end

function autocmd.setup()
    cmd_for_packer()
    map_q_to_quit()
    -- auto_themes()
end

return autocmd
