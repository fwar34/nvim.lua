map <leader>wi <plug>WinWin
command WinWinWin :call win#Win()

let g:win_ext_command_map = {
            \   'c': 'wincmd c',
            \   'C': 'close!',
            \   'V': 'wincmd v',
            \   'S': 'wincmd s',
            \   'n': 'bnext',
            \   'N': 'bnext!',
            \   'p': 'bprevious',
            \   'P': 'bprevious!',
            \   "\<c-n>": 'tabnext',
            \   "\<c-p>": 'tabprevious',
            \   '=': 'wincmd =',
            \   't': 'tabnew',
            \   'q': 'Win#exit'
            \ }
