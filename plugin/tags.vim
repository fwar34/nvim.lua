" 设定项目目录标志：不在 git/svn 内的项目，需要在项目根目录 touch 一个空的 .root/.project 等文件
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 默认生成的数据文件集中到 ~/.cache/tags 避免污染项目目录，好清理
let g:gutentags_cache_dir = expand('~/.cache/tags')
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_exclude_project_root = [expand('~/.vim')]
let g:gutentags_ctags_exclude = ['*/debian/*', '*.am', '*.sh', 'makefile', 'Makefile', '*.html']

"有pygments的话对gtags添加其他语言的支持
"if executable('pygmentize')
"    "let $GTAGSLABEL = 'native-pygments'
"    let $GTAGSLABEL = 'pygments'
"    "let $GTAGSLABEL = 'native'
"    if has('win32')
"        let $GTAGSCONF = expand('~/global/share/gtags/gtags.conf')
"    else
"        let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'
"    endif
"endif

"not gutentags for vim
"let g:gutentags_exclude_filetypes = ['vim', 'go']

" 默认禁用自动生成
let g:gutentags_modules = []
" 如果有 ctags 可执行就允许动态生成 ctags 文件
if executable('ctags')
    let g:gutentags_modules += ['ctags']
endif
" 如果有 gtags 可执行就允许动态生成 gtags 数据库
if executable('gtags-cscope') && executable('gtags')
    let g:gutentags_modules += ['gtags_cscope']
endif

" 设置 ctags 的参数
let g:gutentags_ctags_extra_args = []
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 如果使用 universal ctags 需要增加下面两行
" Universal Ctags support Wildcard in options.
" let g:gutentags_ctags_extra_args = ['--fields=*', '--extras=*', '--kinds-all=*']
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']


" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1

" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0

" 错误排查：gutentags: gutentags: gtags-cscope job failed, returned: 1
"这是因为 gutentags 调用 gtags 时，gtags 返回了错误值 1，具体是什么情况，
"需要进一步打开日志，查看 gtags 的错误输出：
let g:gutentags_define_advanced_commands = 1
"先在 vimrc 中添加上面这一句话，允许 gutentags 打开一些高级命令和选项。
"然后打开你出错的源文件，运行 “:GutentagsToggleTrace”命令打开日志，
"然后保存一下当前文件，触发 gtags 数据库更新，接下来你应该能看到一些讨厌的日志输出，
"这里不够的话，~/.cache/tags 目录下还有对应项目名字的 log 文件，
"ægs 具体输出了什么，然后进行相应的处理。
let g:gutentags_define_advanced_commands = 1

"输出trace信息
"let g:gutentags_trace = 1

" 0 or s: Find this symbol
" 1 or g: Find this definition
" 2 or d: Find functions called by this function
" 3 or c: Find functions calling this function
" 4 or t: Find this text string
" 6 or e: Find this egrep pattern
" 7 or f: Find this file
" 8 or i: Find files #including this file
" 9 or a: Find places where this symbol is assigned a value
" You can disable the default keymaps by:
let g:gutentags_plus_nomap = 1
" and define your new maps:
noremap <silent> <Leader>hs :GscopeFind s <C-R><C-W><cr>
noremap <silent> <Leader>hg :GscopeFind g <C-R><C-W><cr>
noremap <silent> <Leader>hc :GscopeFind c <C-R><C-W><cr>
noremap <silent> <Leader>ht :GscopeFind t <C-R><C-W><cr>
noremap <silent> <Leader>he :GscopeFind e <C-R><C-W><cr>
noremap <silent> <Leader>hf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
noremap <silent> <Leader>hi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
noremap <silent> <Leader>hd :GscopeFind d <C-R><C-W><cr>
noremap <silent> <Leader>ha :GscopeFind a <C-R><C-W><cr>

"gutentags.txt
augroup MyGutentagsStatusLineRefresher
    autocmd!
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
augroup END


"--------------------------------------------------------------------------
" 使用 vim-preview 插件高效的在 quickfix 中先快速预览所有结果，再有针对性的打开必要文件
" This plugin solves a series of user experience problems in vim's preview window and
" provide a handy way to preview tags, files and function signatures.
"--------------------------------------------------------------------------
" noremap <silent> <C-h> :PreviewScroll -1<cr>
" noremap <silent> <C-l> :PreviewScroll +1<cr>
" inoremap <C-h> <c-\><c-o>:PreviewScroll -1<cr>
" inoremap <C-l> <c-\><c-o>:PreviewScroll +1<cr>
" autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
" autocmd FileType qf nnoremap <silent><buffer> q :PreviewClose<cr>
" noremap <F4> :PreviewSignature!<cr>
" inoremap <F4> <c-\><c-o>:PreviewSignature!<cr>

"----------------------------------------------------------------------
" 终端下功能键设置
"----------------------------------------------------------------------
function! s:key_escape(name, code)
	if has('nvim') == 0 && has('gui_running') == 0
		exec "set ".a:name."=\e".a:code
	endif
endfunc


"----------------------------------------------------------------------
" 功能键终端码矫正
"----------------------------------------------------------------------
call s:key_escape('<F1>', 'OP')
call s:key_escape('<F2>', 'OQ')
call s:key_escape('<F3>', 'OR')
call s:key_escape('<F4>', 'OS')
call s:key_escape('<S-F1>', '[1;2P')
call s:key_escape('<S-F2>', '[1;2Q')
call s:key_escape('<S-F3>', '[1;2R')
call s:key_escape('<S-F4>', '[1;2S')
call s:key_escape('<S-F5>', '[15;2~')
call s:key_escape('<S-F6>', '[17;2~')
call s:key_escape('<S-F7>', '[18;2~')
call s:key_escape('<S-F8>', '[19;2~')
call s:key_escape('<S-F9>', '[20;2~')
call s:key_escape('<S-F10>', '[21;2~')
call s:key_escape('<S-F11>', '[23;2~')
call s:key_escape('<S-F12>', '[24;2~')


"----------------------------------------------------------------------
" 防止tmux下vim的背景色显示异常
" Refer: http://sunaku.github.io/vim-256color-bce.html
"----------------------------------------------------------------------
if &term =~ '256color' && $TMUX != ''
	" disable Background Color Erase (BCE) so that color schemes
	" render properly when inside 256-color tmux and GNU screen.
	" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
	set t_ut=
endif

"----------------------------------------------------------------------
" 配置微调
"----------------------------------------------------------------------

" 修正 ScureCRT/XShell 以及某些终端乱码问题，主要原因是不支持一些
" 终端控制命令，比如 cursor shaping 这类更改光标形状的 xterm 终端命令
" 会令一些支持 xterm 不完全的终端解析错误，显示为错误的字符，比如 q 字符
" 如果你确认你的终端支持，不会在一些不兼容的终端上运行该配置，可以注释
if has('nvim')
	set guicursor=
elseif (!has('gui_running')) && has('terminal') && has('patch-8.0.1200')
	let g:termcap_guicursor = &guicursor
	let g:termcap_t_RS = &t_RS
	let g:termcap_t_SH = &t_SH
	set guicursor=
	set t_RS=
	set t_SH=
endif

" 打开文件时恢复上一次光标所在位置
autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\	 exe "normal! g`\"" |
	\ endif

" 定义一个 DiffOrig 命令用于查看文件改动
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

"----------------------------------------------------------------------
" 文件类型微调
"----------------------------------------------------------------------
augroup InitFileTypesGroup

	" 清除同组的历史 autocommand
	au!

	" C/C++ 文件使用 // 作为注释
	au FileType c,cpp setlocal commentstring=//\ %s

	" markdown 允许自动换行
	au FileType markdown setlocal wrap

	" lisp 进行微调
	au FileType lisp setlocal ts=8 sts=2 sw=2 et

	" scala 微调
	au FileType scala setlocal sts=4 sw=4 noet

	" haskell 进行微调
	au FileType haskell setlocal et

	" quickfix 隐藏行号
	au FileType qf setlocal nonumber

	" 强制对某些扩展名的 filetype 进行纠正
	au BufNewFile,BufRead *.as setlocal filetype=actionscript
	au BufNewFile,BufRead *.pro setlocal filetype=prolog
	au BufNewFile,BufRead *.es setlocal filetype=erlang
	au BufNewFile,BufRead *.asc setlocal filetype=asciidoc
	au BufNewFile,BufRead *.vl setlocal filetype=verilog

augroup END

"----------------------------------------------------------------------
" F2 在项目目录下 Grep 光标下单词，默认 C/C++/Py/Js ，扩展名自己扩充
" 支持 rg/grep/findstr ，其他类型可以自己扩充
" 不是在当前目录 grep，而是会去到当前文件所属的项目目录 project root
" 下面进行 grep，这样能方便的对相关项目进行搜索
"----------------------------------------------------------------------
if executable('rg')
	nnoremap <silent><F2> :AsyncRun! -cwd=<root> rg -n --no-heading 
				\ --color never -g *.h -g *.c* -g *.py -g *.js -g *.vim 
				\ <C-R><C-W> "<root>" <cr>
elseif has('win32') || has('win64')
	noremap <silent><F2> :AsyncRun! -cwd=<root> findstr /n /s /C:"<C-R><C-W>" 
				\ "\%CD\%\*.h" "\%CD\%\*.c*" "\%CD\%\*.py" "\%CD\%\*.js"
				\ "\%CD\%\*.vim"
				\ <cr>
else
	noremap <silent><F2> :AsyncRun! -cwd=<root> grep -n -s -R <C-R><C-W> 
				\ --include='*.h' --include='*.c*' --include='*.py' 
				\ --include='*.js' --include='*.vim'
				\ '<root>' <cr>
endif

"----------------------------------------------------------------------
" 终端设置，隐藏行号和侧边栏
"----------------------------------------------------------------------
if has('terminal') && exists(':terminal') == 2
	if exists('##TerminalOpen')
		augroup VimUnixTerminalGroup
			au! 
			au TerminalOpen * setlocal nonumber signcolumn=no
		augroup END
	endif
endif

"----------------------------------------------------------------------
" quickfix 设置，隐藏行号
"----------------------------------------------------------------------
augroup VimInitStyle
    au!
    au FileType qf setlocal nonumber
augroup END

"----------------------------------------------------------------------
" 标签栏文字风格：默认为零，GUI 模式下空间大，按风格 3显示
" 0: filename.txt
" 2: 1 - filename.txt
" 3: [1] filename.txt
"----------------------------------------------------------------------
if has('gui_running')
	let g:config_vim_tab_style = 3
endif


"----------------------------------------------------------------------
" 终端下的 tabline
"----------------------------------------------------------------------
function! Vim_NeatTabLine()
	let s = ''
	for i in range(tabpagenr('$'))
		" select the highlighting
		if i + 1 == tabpagenr()
			let s .= '%#TabLineSel#'
		else
			let s .= '%#TabLine#'
		endif

		" set the tab page number (for mouse clicks)
		let s .= '%' . (i + 1) . 'T'

		" the label is made by MyTabLabel()
		let s .= ' %{Vim_NeatTabLabel(' . (i + 1) . ')} '
	endfor

	" after the last tab fill with TabLineFill and reset tab page nr
	let s .= '%#TabLineFill#%T'

	" right-align the label to close the current tab page
	if tabpagenr('$') > 1
		let s .= '%=%#TabLine#%999XX'
	endif

	return s
endfunc


"----------------------------------------------------------------------
" 需要显示到标签上的文件名
"----------------------------------------------------------------------
function! Vim_NeatBuffer(bufnr, fullname)
	let l:name = bufname(a:bufnr)
	if getbufvar(a:bufnr, '&modifiable')
		if l:name == ''
			return '[No Name]'
		else
			if a:fullname 
				return fnamemodify(l:name, ':p')
			else
				let aname = fnamemodify(l:name, ':p')
				let sname = fnamemodify(aname, ':t')
				if sname == ''
					let test = fnamemodify(aname, ':h:t')
					if test != ''
						return '<'. test . '>'
					endif
				endif
				return sname
			endif
		endif
	else
		let l:buftype = getbufvar(a:bufnr, '&buftype')
		if l:buftype == 'quickfix'
			return '[Quickfix]'
		elseif l:name != ''
			if a:fullname 
				return '-'.fnamemodify(l:name, ':p')
			else
				return '-'.fnamemodify(l:name, ':t')
			endif
		else
		endif
		return '[No Name]'
	endif
endfunc


"----------------------------------------------------------------------
" 标签栏文字，使用 [1] filename 的模式
"----------------------------------------------------------------------
function! Vim_NeatTabLabel(n)
	let l:buflist = tabpagebuflist(a:n)
	let l:winnr = tabpagewinnr(a:n)
	let l:bufnr = l:buflist[l:winnr - 1]
	let l:fname = Vim_NeatBuffer(l:bufnr, 0)
	let l:num = a:n
	let style = get(g:, 'config_vim_tab_style', 0)
	if style == 0
		return l:fname
	elseif style == 1
		return "[".l:num."] ".l:fname
	elseif style == 2
		return "".l:num." - ".l:fname
	endif
	if getbufvar(l:bufnr, '&modified')
		return "[".l:num."] ".l:fname." +"
	endif
	return "[".l:num."] ".l:fname
endfunc


"----------------------------------------------------------------------
" GUI 下的标签文字，使用 [1] filename 的模式
"----------------------------------------------------------------------
function! Vim_NeatGuiTabLabel()
	let l:num = v:lnum
	let l:buflist = tabpagebuflist(l:num)
	let l:winnr = tabpagewinnr(l:num)
	let l:bufnr = l:buflist[l:winnr - 1]
	let l:fname = Vim_NeatBuffer(l:bufnr, 0)
	let style = get(g:, 'config_vim_tab_style', 0)
	if style == 0
		return l:fname
	elseif style == 1
		return "[".l:num."] ".l:fname
	elseif style == 2
		return "".l:num." - ".l:fname
	endif
	if getbufvar(l:bufnr, '&modified')
		return "[".l:num."] ".l:fname." +"
	endif
	return "[".l:num."] ".l:fname
endfunc



"----------------------------------------------------------------------
" 设置 GUI 标签的 tips: 显示当前标签有哪些窗口
"----------------------------------------------------------------------
function! Vim_NeatGuiTabTip()
	let tip = ''
	let bufnrlist = tabpagebuflist(v:lnum)
	for bufnr in bufnrlist
		" separate buffer entries
		if tip != ''
			let tip .= " \n"
		endif
		" Add name of buffer
		let name = Vim_NeatBuffer(bufnr, 1)
		let tip .= name
		" add modified/modifiable flags
		if getbufvar(bufnr, "&modified")
			let tip .= ' [+]'
		endif
		if getbufvar(bufnr, "&modifiable")==0
			let tip .= ' [-]'
		endif
	endfor
	return tip
endfunc


"----------------------------------------------------------------------
" 标签栏最终设置
"----------------------------------------------------------------------
set tabline=%!Vim_NeatTabLine()
set guitablabel=%{Vim_NeatGuiTabLabel()}
set guitabtooltip=%{Vim_NeatGuiTabTip()}

echo "xxxxxxxxxxxxxxxx"
