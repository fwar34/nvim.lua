function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

let g:lightline = {
            \ 'colorscheme': 'wombat', 
            \ 'active': 
            \    {'left': [ [ 'mode', 'paste' ], 
            \               [ 'gitbranch', 'readonly', 'filename', 'modified', 'method' ] ]
            \ },  
            \ 'component': {'filename': '%F%m%r%h%w'}, 
            \ 'component_function': 
            \    {'method': 'NearestMethodOrFunction', 
            \     'gitbranch': 'FugitiveHead'},
            \ }
