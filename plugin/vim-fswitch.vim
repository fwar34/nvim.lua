 "--------------------------------------------------------------------------
  " switch c with cpp
  "--------------------------------------------------------------------------
  nnoremap <silent> <Leader>fo :FSHere<CR>
  augroup fswitch_grp
      autocmd!
      au! BufEnter *.cc let b:fswitchdst = 'hpp,h' | let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/**|,ifrel:|/src/|../incl  ude|'
      au! BufEnter *.h let b:fswitchdst = 'c,cpp,m,cc' | let b:fswitchlocs = 'reg:/include/src/,reg:/include.*/src/,ifrel:|/include/|  ../src|'
      au! BufEnter *.hpp let b:fswitchdst = 'c,cpp,m,cc' | let b:fswitchlocs = 'reg:/include/src/,reg:/include.*/src/,ifrel:|/include  /|../src|'
  augroup END
