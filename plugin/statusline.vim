function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" gitgutter
function! GitStatus()
    let [a,m,r] = GitGutterGetHunkSummary()
    if a || m || r
        return printf('+%d ~%d -%d', a, m, r)
    endif
    return ''
endfunction

let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'component': {'charvaluehex': '0x%B'},
            \ 'active':
            \    {'left': [ [ 'mode', 'paste' ],
            \               [ 'gitbranch', 'gitstatus', 'readonly', 'filename', 'modified', 'method' ] ],
            \     'right': [ [ 'lineinfo' ],
            \                [  'charvaluehex', 'scorestatus', 'fileformat', 'fileencoding', 'filetype' ] ]
            \    },
            \ 'component_function':
            \    {
            \     'method': 'NearestMethodOrFunction',
            \     'gitbranch': 'FugitiveStatusline',
            \     'scorestatus': 'ScrollStatus',
            \     'gitstatus': 'GitStatus',
            \    },
            \ }

"FugitiveStatusline FugitiveHead
