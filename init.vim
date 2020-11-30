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

execute 'source' fnamemodify(expand('<sfile>'), ':h').'/plugin/coc.vim'
