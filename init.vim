lua << EOF
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
	execute 'packadd packer.nvim'
end
EOF

lua require('init').init()

"禁止vim换行后自动添加的注释符号     
augroup Format-Options     
	autocmd!     
	"autocmd BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o     
	" This can be done as well instead of the previous line, for setting formatoptions as you choose:     
	autocmd BufEnter * setlocal formatoptions=crqn2l1j     
	"让vim显示行尾的空格     
	"autocmd BufEnter * highlight WhitespaceEOL ctermbg=red guibg=red     
	"autocmd BufEnter * match WhitespaceEOL /\s\+$/
augroup END

" let g:lightline = {
"       \ 'colorscheme': 'wombat',
"       \ 'component': {
"       \   'filename': '%F%m%r%h%w'
"       \ },
"       \ }

execute 'source' fnamemodify(expand('<sfile>'), ':h').'/coc.vim'
