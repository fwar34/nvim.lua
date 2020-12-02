-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
-- vim._update_package_paths()

return require('packer').startup(function()
    -- Packer can manage itself as an optional plugin
    use { 'wbthomason/packer.nvim', opt = true, }

    -- Simple plugins can be specified as strings
    use '9mm/vim-closer'

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
    use {'itchyny/lightline.vim',}
    -- use 'glepnir/spaceline.vim'

    -- Interface
    use {'liuchengxu/vim-which-key'}

    -- Coding
    use {'liuchengxu/vista.vim',}

    -- Find everythings
    use {
        'liuchengxu/vim-clap', opt = true, event = 'VimEnter *', -- cmd = 'Clap',
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
                    '~/.tmux.conf'}, 
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

        -- Beautiful tabline
        use {'mg979/vim-xtabline', }

        -- Coc
        use {'neoclide/coc.nvim', branch = 'release'}

        use {'vn-ki/coc-clap'}

        -- Git
        use {'rhysd/git-messenger.vim', opt = true, cmd = 'GitMessenger'}
        use {'tpope/vim-fugitive'}

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
    end)
