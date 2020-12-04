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

local function help_mouse()
    vim.cmd [[ autocmd! BufEnter *.txt lua require('futil'):set_mouse() ]]
    vim.cmd [[ autocmd! BufLeave *.txt lua require('futil'):restore_mouse() ]]
end

function autocmd.setup()
    cmd_for_packer()
    map_q_to_quit()
    help_mouse()
    -- auto_themes()
end

return autocmd
