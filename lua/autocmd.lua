local autocmd = {}
local vim = vim

local function goto_last_position()
    vim.cmd [[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]
end

local function cmd_for_packer()
    vim.cmd [[ autocmd! BufWritePost plugins.lua PackerCompile ]]
end

local function map_q_to_quit()
    vim.cmd [[ autocmd! FileType help,qf,netrw,startuptime :map <buffer> q <CMD>q<CR> ]]
end

local function map_wq_to_quit()
    vim.cmd [[ autocmd! FileType gitcommit :map <buffer> q <CMD>wq<CR> ]]
end

local function help_mouse()
    vim.cmd [[ autocmd! BufEnter *.txt lua require('futil'):set_mouse() ]]
    vim.cmd [[ autocmd! BufLeave *.txt lua require('futil'):restore_mouse() ]]
end

local function golang_autocmd()
    vim.cmd [[ autocmd! FileType go :imap <buffer> ; <Space>:=<Space>]]
end

local function disable_auto_comment()
    -- "禁止vim换行后自动添加的注释符号
    vim.cmd [[ augroup Format-Options ]]
    vim.cmd [[ autocmd! ]]
    -- https://superuser.com/questions/271023/can-i-disable-continuation-of-comments-to-the-next-line-in-vim
    -- "autocmd BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    -- " This can be done as well instead of the previous line, for setting formatoptions as you choose:
    vim.cmd [[ autocmd BufEnter * setlocal formatoptions-=cro ]]
    -- "让vim显示行尾的空格
    -- "autocmd BufEnter * highlight WhitespaceEOL ctermbg=red guibg=red
    -- "autocmd BufEnter * match WhitespaceEOL /\s\+$/
    vim.cmd [[ augroup END ]]
end

function autocmd.setup()
    goto_last_position()
    cmd_for_packer()
    map_q_to_quit()
    map_wq_to_quit()
    help_mouse()
    disable_auto_comment()
    golang_autocmd()
end

return autocmd
