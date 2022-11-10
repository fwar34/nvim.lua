" set PATH environment
let $PATH=$PATH . ':'
let $PATH=$PATH . $HOME
let $PATH=$PATH . '/go/bin:'
let $PATH=$PATH . $HOME . ''
let $PATH=$PATH . $HOME . '/bin:'
let $PATH=$PATH . '/snap/bin:'
let $PATH=$PATH . $HOME . '/.local/bin:'
let $PATH=$PATH . $HOME . '/.local/share/nvim/site/pack/packer/start/fzf/bin:'
let $PATH=$PATH . '/usr/local/go/bin:'
let $PATH=$PATH . $HOME . '/go/bin:'
let $PATH=$PATH . $HOME . '/.cargo/bin:'
let $PATH=$PATH . $HOME . '/bin/maven/bin:'
let $PATH=$PATH . $HOME . '/jdk-13.0.2/bin:'
let $PATH=$PATH . '/usr/share/maven/bin'

" Set Editor Font
if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    " GuiFont FiraCode\ Nerd\ Font\ Mono:h18
    " for neovim-qt
    " Guifont! JetBrains\ Mono:h13
    " Guifont! JetBrainsMono\ Nerd\ Font:h13
    if $MYHOSTNAME == "FL-Notebook"
        Guifont! Iosevka\ Curly\ Slab:h18
    elseif $MYHOSTNAME == "ubuntu-awesome"
        Guifont! JetBrainsMono\ Nerd\ Font:h16
    elseif $MYHOSTNAME == "archlinux-dell"
        Guifont! Sarasa\ Mono\ SC\ Nerd:h13
    else
        Guifont! Sarasa\ Mono\ SC\ Nerd:h12
    endif
endif

" Disable GUI Tabline
if exists(':GuiTabline')
    GuiTabline 0
endif

" Disable GUI Popupmenu
if exists(':GuiPopupmenu')
    GuiPopupmenu 0
endif

" Enable GUI ScrollBar
if exists(':GuiScrollBar')
    GuiScrollBar 0
endif

"reduce line space
" GuiLinespace 1

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv

" call GuiWindowMaximized(1)
