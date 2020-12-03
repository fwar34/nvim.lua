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
    use {'itchyny/lightline.vim', event = 'Vimenter *'}
    -- use 'glepnir/spaceline.vim'

    -- Interface
    -- use {'liuchengxu/vim-which-key'}

    -- Coding
    use {'liuchengxu/vista.vim',}

    -- Find everythings
    use {
        'liuchengxu/vim-clap', opt = true, event = 'VimEnter *',
        config = function()
            vim.g.clap_theme = 'material_design_dark'
            vim.g.clap_current_selection_sign = { text = '=>', 
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
    use {'tpope/vim-fugitive'}
    use {'airblade/vim-gitgutter', event = 'VimEnter *'}

    -- Themes
    use {
        {'glepnir/oceanic-material', config = 'vim.cmd [[ colorscheme oceanic_material ]]'},
        -- You can alias plugin names
        {'dracula/vim', as = 'dracula'}
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
            {'junegunn/fzf', run = './install --all'}, 
            {'junegunn/fzf.vim'}, -- need for preview
        },
    }

    -- Profiling
    use {'dstein64/vim-startuptime', cmd = 'StartupTime'}

    -- Ranger
    use {'kevinhwang91/rnvimr', cmd = 'RnvimrToggle'}

    -- Undo
    use {'mbbill/undotree', cmd = 'UndotreeToggle'}

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
end)
