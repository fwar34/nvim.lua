let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_cache_dir = expand('~/.cache/tags')
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_exclude_project_root = [expand('~/.vim')]

"有pygments的话对gtags添加其他语言的支持
if executable('pygmentize')
    "let $GTAGSLABEL = 'native-pygments'
    let $GTAGSLABEL = 'pygments'
    "let $GTAGSLABEL = 'native'
    if has('win32')
        let $GTAGSCONF = expand('~/global/share/gtags/gtags.conf')
    else
        let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'
    endif
endif

"not gutentags for vim
let g:gutentags_exclude_filetypes = ['vim', 'go']

let g:gutentags_modules = []
if executable('ctags')
    let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
    let g:gutentags_modules += ['gtags_cscope']
endif

" 如果使用 universal ctags 需要增加下面两行
" Universal Ctags support Wildcard in options.
let g:gutentags_ctags_extra_args = ['--fields=*', '--extras=*', '--all-kinds=*']
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']


" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1

" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0

" 错误排查：gutentags: gutentags: gtags-cscope job failed, returned: 1
"这是因为 gutentags 调用 gtags 时，gtags 返回了错误值 1，具体是什么情况，
"需要进一步打开日志，查看 gtags 的错误输出：
"let g:gutentags_define_advanced_commands = 1
"先在 vimrc 中添加上面这一句话，允许 gutentags 打开一些高级命令和选项。
"然后打开你出错的源文件，运行 “:GutentagsToggleTrace”命令打开日志，
"然后保存一下当前文件，触发 gtags 数据库更新，接下来你应该能看到一些讨厌的日志输出，
"这里不够的话，~/.cache/tags 目录下还有对应项目名字的 log 文件，
"ægs 具体输出了什么，然后进行相应的处理。
let g:gutentags_define_advanced_commands = 1

"输出trace信息
"let g:gutentags_trace = 1

let g:gutentags_plus_nomap = 1
noremap <silent> <Leader>gs :GscopeFind s <C-R><C-W><cr>
noremap <silent> <Leader>gg :GscopeFind g <C-R><C-W><cr>
noremap <silent> <Leader>gc :GscopeFind c <C-R><C-W><cr>
noremap <silent> <Leader>gt :GscopeFind t <C-R><C-W><cr>
noremap <silent> <Leader>ge :GscopeFind e <C-R><C-W><cr>
noremap <silent> <Leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
noremap <silent> <Leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
noremap <silent> <Leader>gd :GscopeFind d <C-R><C-W><cr>
noremap <silent> <Leader>ga :GscopeFind a <C-R><C-W><cr>

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
" Plug 'skywind3000/vim-preview'
noremap <silent> <C-h> :PreviewScroll -1<cr>
noremap <silent> <C-l> :PreviewScroll +1<cr>
inoremap <C-h> <c-\><c-o>:PreviewScroll -1<cr>
inoremap <C-l> <c-\><c-o>:PreviewScroll +1<cr>
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> q :PreviewClose<cr>
noremap <F4> :PreviewSignature!<cr>
inoremap <F4> <c-\><c-o>:PreviewSignature!<cr>
