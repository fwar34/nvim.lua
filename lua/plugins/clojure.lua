return {
    {'guns/vim-sexp', ft = {'fennel', 'clojure', 'lisp'}},
    {'tpope/vim-sexp-mappings-for-regular-people', ft = {'fennel', 'clojure', 'lisp'}},
    -- {'Olical/conjure', tag = 'v4.9.0',},
    {'Olical/conjure', tag = 'v4.9.0', ft = {'fennel', 'clojure'}, config = function ()
        vim.cmd('let g:conjure#mapping#prefix = ","')
        vim.cmd('let g:conjure#log#hud#width = 0.8')
        vim.cmd('let g:conjure#log#hud#height = 0.5')
    end},
    {'tpope/vim-dispatch', event = 'VimEnter *'},
    -- Jack in to Boot, Clj & Leiningen from Vim. Inspired by the feature in CIDER.el.
    {'clojure-vim/vim-jack-in', cmd = {'Clj', 'Lein', 'Boot'}},
    -- Vim highlighting for Fennel, heavily modified from vim-clojure-static.
    {'bakpakin/fennel.vim', event = 'VimEnter *'},
    -- Aniseed bridges the gap between Fennel (a Lisp that compiles to Lua)
    -- and Neovim. Allowing you to easily write plugins or configuration in
    -- a Clojure-like Lisp with great runtime performance.
    -- {'Olical/aniseed', tag = 'v3.11.0'},
    -- {'Olical/nvim-local-fennel', tag = 'v2.4.0'},
    -- Interactive Repls Over Neovim
    -- Iron is both a plugin and a library to allow users to deal with repls.
    {'hkupty/iron.nvim',},
    -- This is a vim plugin for using parinfer to indent your clojure and lisp code.
    -- Parinfer is trigger on all TextChanged events within vim. In addition, you may use the following mapped commands:
    -- <Tab> - indents s-expression
    -- <Tab-S> - dedents s-expression
    -- dd - deletes line and balances parenthesis
    -- p - puts line and balances parenthesis
    -- {'bhurlow/vim-parinfer', ft = {'fennel', 'clojure', 'lisp'}}
}
