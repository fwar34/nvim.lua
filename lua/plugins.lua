-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
-- vim._update_package_paths()

return require('packer').startup(function()
    -- Packer can manage itself as an optional plugin
    use { 'wbthomason/packer.nvim', opt = true, }

    -- Beautiful tabline
    -- use {
    --     'mg979/vim-xtabline',
    --     config = function()
    --         -- vim.cmd [[ let g:xtabline_settings.enable_mappings = 0 ]]
    --         -- vim.cmd [[ let g:xtabline_settings.tab_number_in_left_corner = 0 ]]
    --         -- vim.cmd [[ let g:xtabline_settings.tab_number_in_buffers_mode = 0 ]]
    --         -- vim.cmd [[ silent! nmap <F6> <Plug>(XT-Select-Buffer) ]]
    --     end
    -- }

    -- use {'ap/vim-buftabline', event = 'VimEnter *'}

    use {
        'akinsho/nvim-bufferline.lua', event = 'VimEnter *',
        requires = {'kyazdani42/nvim-web-devicons'},
        config = function()
            require ("bufferline").setup {
                options = {
                    -- view = "multiwindow" | "default",
                    view = "default",
                    -- numbers = "none" | "ordinal" | "buffer_id",
                    numbers = "ordinal",
                    -- number_style = "superscript" | "",
                    number_style = "",
                    mappings = true,
                    buffer_close_icon= '',
                    modified_icon = '●',
                    close_icon = '',
                    left_trunc_marker = '',
                    right_trunc_marker = '',
                    max_name_length = 18,
                    max_prefix_length = 15, -- prefix used when a buffer is deduplicated
                    tab_size = 18,
                    show_buffer_close_icons = false,
                    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
                    -- can also be a table containing 2 custom separators
                    -- [focused and unfocused]. eg: { '|', '|' }
                    enforce_regular_tabs = false,
                    -- separator_style = "slant" | "thick" | "thin" | { 'any', 'any' },
                    separator_style =  'thick',
                    always_show_bufferline = true,
                    -- sort_by = 'extension' | 'relative_directory' | 'directory' | function(buffer_a, buffer_b)
                    --     -- add custom logic
                    --     return buffer_a.modified > buffer_b.modified
                    -- end
                }
            }
        end
    }

    -- Simple plugins can be specified as strings
    -- use '9mm/vim-closer'

    -- Lazy loading:
    -- Load on specific commands
    use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

    -- Load on an autocommand event
    use {
        'andymass/vim-matchup', opt = true, event = 'VimEnter *',
        config = function()
            vim.cmd [[ let g:matchup_matchparen_offscreen = {'method': 'popup'} ]]
        end
    }

    -- Load on a combination of conditions: specific filetypes or commands
    -- Also run code after load (see the "config" key)
    -- use {
    --     'w0rp/ale',
    --     ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
    --     cmd = 'ALEEnable',
    --     config = 'vim.cmd[[ALEEnable]]'
    -- }

    -- Plugins can have dependencies on other plugins
    -- use {
    --     'haorenW1025/completion-nvim',
    --     opt = true,
    --     requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
    -- }

    -- Local plugins can be included
    --use '~/projects/personal/hover.nvim'

    -- Plugins can have post-install/update hooks
    use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

    -- You can specify multiple plugins in a single call
    use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}

    -----------------------------------------------------------------------------------------

    -- Status line
    use {'itchyny/lightline.vim'}
    -- use 'glepnir/spaceline.vim'

    -- Interface
    use {'liuchengxu/vim-which-key', }

    -- Coding
    use {'liuchengxu/vista.vim',}

    -- Find everythings
    use {
        'liuchengxu/vim-clap', opt = true, event = 'VimEnter *',
        config = function()
            vim.g.clap_theme = 'material_design_dark'
            vim.g.clap_current_selection_sign = { text = '->',
            texthl = 'ClapCurrentSelectionSign', linehl = 'ClapCurrentSelection' }

            -- `:Clap dotfiles` to open some dotfiles quickly.
            vim.g.clap_provider_dot = {
                source = {
                    '~/.config/nvim/lua/init.lua',
                    '~/.config/nvim/lua/plugins.lua',
                    '~/.config/nvim/lua/key_mappings.lua',
                    '~/.config/nvim/lua/autocmd.lua',
                    '~/.config/nvim/init.vim',
                    '~/.config/nvim/plugin/coc.vim',
                    '~/.config/nvim/plugin/which-vim-key.vim',
                    '~/.config/nvim/cheatsheets.md',
                    '~/.zshrc',
                    '~/.tmux.conf'
                },
                sink = 'e'
            }
        end
    }

    -- Grepping
    use {'mhinz/vim-grepper', opt = true, cmd = 'Grepper'}

    -- File manager
    use {'Shougo/defx.nvim', opt = true, cmd = {'Defx'}}
    use {'kevinhwang91/rnvimr', cmd = 'RnvimrToggle'} -- Ranger
    use { -- nnn
        'mcchrish/nnn.vim', cmd = {'NnnPicker', 'Np'},
        config = function()
            -- Disable default mappings
            vim.cmd [[ let g:nnn#set_default_mappings = 0 ]]
            -- Floating window (neovim latest and vim with patch 8.2.191)
            -- vim.g['nnn#layout'] = { window = { width = 0.9, height = 0.6, highlight = 'Debug'}}
            vim.cmd [[ let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } } ]]
        end
    }

    -- Terminal
    use {
        'voldikss/vim-floaterm', event = 'VimEnter *',
        setup = function()
            -- Type Number. The transparency of the floating terminal. Only works in neovim.
            vim.g.floaterm_winblend = 8
            -- vim.g.floaterm_keymap_new = '<F7>'
            -- vim.g.floaterm_keymap_prev = '<F8>'
            -- vim.g.floaterm_keymap_next = '<F9>'
            vim.g.floaterm_keymap_toggle = '<leader>tm'
        end
    }

    use {
        'skywind3000/vim-terminal-help', event = 'VimEnter *',
        config = function()
            vim.g.terminal_height = 20
            vim.g.terminal_list = 0 -- set to 0 to hide terminal buffer in the buffer list.
        end
    }

    -- Better Lua highlighting
    use {'euclidianAce/BetterLua.vim', opt = true, ft = {'lua'}}

    -- Registers
    -- Peekaboo extends " and @ in normal mode and <CTRL-R> in insert mode so you can see the contents of the registers.
    use 'junegunn/vim-peekaboo'

    -- Marks
    use 'kshenoy/vim-signature'

    -- Buffer management

    -- Movement
    use {'easymotion/vim-easymotion'}

    -- Quickfix

    -- Do stuff like :sudowrite
    use 'lambdalisue/suda.vim'

    -- Coc
    use {'neoclide/coc.nvim', branch = 'release'}

    use {'vn-ki/coc-clap', after = 'coc.nvim'}

    -- Git
    use {'rhysd/git-messenger.vim', opt = true, cmd = 'GitMessenger'}
    use {'tpope/vim-fugitive', event = 'VimEnter *',}
    -- use {'airblade/vim-gitgutter', }
	use {
        'mhinz/vim-signify',
        config = function()
        end
    }

    -- Themes
    use {
        {'glepnir/oceanic-material', config = 'vim.cmd [[ colorscheme oceanic_material ]]'},
        -- You can alias plugin names
        {'dracula/vim', as = 'dracula'},
        -- {'fwar34/vim-color-wombat256.git', as = 'wombat256'}
        {'flazz/vim-colorschemes'}, -- one stop shop for vim colorschemes.
    }

    -- Status line
    use {
        'ojroques/vim-scrollstatus',
        config = function()
            vim.g.scrollstatus_size = 12
            vim.g.scrollstatus_symbol_track = '-'
            vim.g.scrollstatus_symbol_bar = '#'
        end
    }

    -- Coc-fzf
    use {
        'antoinemadec/coc-fzf',
        after = 'coc.nvim',
        branch = 'release',
        requires = {
            {'junegunn/fzf', run = './install --all', lock = true},
            {'junegunn/fzf.vim'}, -- need for preview
        },
    }

    -- Profiling
    use {'dstein64/vim-startuptime', cmd = 'StartupTime'}


    -- Undo
    -- use {'mbbill/undotree', cmd = 'UndotreeToggle'}

    -- vim-multiple-cursors
    use {
        'terryma/vim-multiple-cursors',
        config = function()
            -- If set to 0, insert mappings won't be supported in Insert mode anymore.
            vim.g.multi_cursor_support_imap = 0
        end
    }

    -- Icons
    use {'ryanoasis/vim-devicons', }

    -- Surround
    use {'tpope/vim-surround', event = 'VimEnter *'}

    -- Highlight for stl
    use {
        'octol/vim-cpp-enhanced-highlight.git', event = 'VimEnter *',
        config = function()
            vim.g.cpp_class_scope_highlight = 1
            vim.g.cpp_class_decl_highlight = 1
        end
    }

    -- Undo
    use {'sjl/gundo.vim', cmd = 'GundoToggle', config = 'vim.g.gundo_prefer_python3 = 1'}

    -- Highlight whitespace and fix
    -- use {'bronson/vim-trailing-whitespace', event = 'VimEnter *'}
    use {
        'ntpeters/vim-better-whitespace',
        config = function()
            vim.g.better_whitespace_operator = '<leader>ss'
            vim.g.better_whitespace_enabled = 0
            vim.g.better_whitespace_filetypes_blacklist = {'gitcommit', 'unite', 'qf', 'help', 'markdown', 'packer',}
            vim.cmd [[ let g:show_spaces_that_precede_tabs = 1 ]]
        end
    }

    -- use {'Yggdroot/LeaderF', event = 'VimEnter *',}

    -- Comment
    use {
        'tpope/vim-commentary', event = 'VimEnter *',
        config = function ()
            -- My favorite file type isn't supported!
            -- Relax! You just have to adjust 'commentstring':
            -- autocmd FileType apache setlocal commentstring=#\ %s
        end
    }

    -- Tags
    -- use {'jsfaint/gen_tags.vim', event = 'VimEnter *',}
    use {
        {'ludovicchabant/vim-gutentags', event = 'VimEnter *',
        config = function()
        end},

        {'skywind3000/gutentags_plus', event = 'VimEnter *'},
        -- {'skywind3000/vim-preview', event = 'VimEnter *'}
    }

    use {
        'plasticboy/vim-markdown', after = 'tabular', ft = 'markdownd',
        requires = {'godlygeek/tabular'},
    }

    -- This vim bundle adds advanced syntax highlighting for GNU as (AT&T).
    use {
        'Shirk/vim-gas', ft = 'asm',
    }

    -- Improved Lua 5.3 syntax and indentation support for Vim.
    use {'tbastos/vim-lua', ft = 'lua'}

    use {
        'vim-python/python-syntax', ft = 'python',
        config = function()
            vim.g.python_highlight_all = 1
        end
    }

    -- A Vim text editor plugin to swap delimited items.
    use {
        'machakann/vim-swap', event = 'VimEnter *',
    }

    -- adds various text objects to give you more targets to operate on.
    use {
        'wellle/targets.vim', event = 'VimEnter *',
    }

    use {
        'dstein64/vim-win', event = 'VimEnter *',
        config = function()
        end
    }

    -- Async task
    use {
        'skywind3000/asynctasks.vim', after = 'asyncrun.vim',
        requires = {'skywind3000/asyncrun.vim', event = 'VimEnter *'},
        config = function()
            -- 告诉 asyncrun 运行时自动打开高度为 6 的 quickfix 窗口，不然你看不到任何输出
            vim.g.asyncrun_open = 6
        end
    }
end)
