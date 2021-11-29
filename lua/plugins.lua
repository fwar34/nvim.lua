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

    -- use {
    --     'akinsho/nvim-bufferline.lua', event = 'VimEnter *',
    --     requires = {'kyazdani42/nvim-web-devicons'},
    --     config = function()
    --         require ("bufferline").setup {
    --             options = {
    --                 -- view = "multiwindow" | "default",
    --                 view = "default",
    --                 -- numbers = "none" | "ordinal" | "buffer_id",
    --                 numbers = "ordinal",
    --                 -- number_style = "superscript" | "",
    --                 number_style = "",
    --                 mappings = true,
    --                 buffer_close_icon= '',
    --                 modified_icon = '●',
    --                 close_icon = '',
    --                 left_trunc_marker = '@',
    --                 right_trunc_marker = '$',
    --                 max_name_length = 18,
    --                 max_prefix_length = 15, -- prefix used when a buffer is deduplicated
    --                 tab_size = 18,
    --                 show_buffer_close_icons = false,
    --                 persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    --                 -- can also be a table containing 2 custom separators
    --                 -- [focused and unfocused]. eg: { '|', '|' }
    --                 enforce_regular_tabs = false,
    --                 -- separator_style = "slant" | "thick" | "thin" | { 'any', 'any' },
    --                 separator_style =  'thick',
    --                 always_show_bufferline = true,
    --                 -- sort_by = 'extension' | 'relative_directory' | 'directory' | function(buffer_a, buffer_b)
    --                 --     -- add custom logic
    --                 --     return buffer_a.modified > buffer_b.modified
    --                 -- end
    --             }
    --         }
    --     end
    -- }

    -- Simple plugins can be specified as strings
    -- use '9mm/vim-closer'

    -- Lazy loading:
    -- Load on specific commands
    -- use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

    -- Load on an autocommand event
    -- use {
    --     'andymass/vim-matchup', opt = true, event = 'VimEnter *',
    --     config = function()
    --         vim.cmd [[ let g:matchup_matchparen_offscreen = {'method': 'popup'} ]]
    --     end
    -- }

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

    -----------------------------------------------------------------------------------------
    -- A colorscheme helper for Neovim.
    use {'tjdevries/colorbuddy.nvim'}
    -- Color scheme
    use {'tjdevries/gruvbuddy.nvim',}
    use {'Th3Whit3Wolf/onebuddy',  config = function ()
        -- require('colorbuddy').colorscheme('onebuddy')
    end}
    use {
        -- "joshdick/onedark.vim",
        'ii14/onedark.nvim',
        -- 'navarasu/onedark.nvim',
        config = function ()
            vim.cmd [[ colorscheme onedark ]]
        end
    }

    -- Themes
    use {
        {'glepnir/oceanic-material', config = function ()
            -- vim.cmd [[ colorscheme oceanic_material ]]
        end},
        -- You can alias plugin names
        {'dracula/vim', as = 'dracula'},
        -- {'fwar34/vim-color-wombat256.git', as = 'wombat256'}
        {'flazz/vim-colorschemes'}, -- one stop shop for vim colorschemes.
    }

    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
    config = function ()
        require('nvim-treesitter.configs').setup {
            ensure_installed = {
                'bash', 'c', 'cpp', 'lua', 'css', 'fennel', 'html', 'javascript', 'json', 'julia', 'go',
                'ocaml', 'ocaml_interface', 'python', 'rust', 'toml', 'typescript', 'clojure', 'fennel'
            },     -- one of "all", "language", or a list of languages
            highlight = {
                enable = true,              -- false will disable the whole extension
                -- disable = { "c", "rust" },  -- list of language that will be disabled
            },
        }
    end}

    -- use {'p00f/nvim-ts-rainbow', config = function ()
    --     require('nvim-treesitter.configs').setup {
    --         rainbow = {
    --             enable = true,
    --             disable = {'bash', 'cpp'} -- please disable bash until I figure #1 out
    --         }
    --     }
    -- end}

    use {'hrsh7th/cmp-nvim-lsp'}
    use {'hrsh7th/cmp-buffer'}
    use {'hrsh7th/cmp-path'}
    use {'hrsh7th/cmp-cmdline'}
	use {'hrsh7th/nvim-cmp', config = function()
        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end
        local luasnip = require("luasnip")

		-- Setup nvim-cmp.
		local cmp = require'cmp'
		cmp.setup({
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
					require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					-- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
				end,
			},

            mapping = {
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                -- ... Your other mappings ...
                ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                ['<C-g>'] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                }),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            },
			sources = cmp.config.sources({
				-- { name = 'nvim_lsp' },
				-- { name = 'vsnip' }, -- For vsnip users.
				{ name = 'luasnip' }, -- For luasnip users.
				-- { name = 'ultisnips' }, -- For ultisnips users.
				-- { name = 'snippy' }, -- For snippy users.
			}, {
				{ name = 'buffer' },
			})
		})

		-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
		-- cmp.setup.cmdline('/', {
		-- 	sources = {
		-- 		{ name = 'buffer' }
		-- 	}
		-- })

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		-- cmp.setup.cmdline(':', {
		-- 	sources = cmp.config.sources({
		-- 		{ name = 'path' }
		-- 	}, {
		-- 		{ name = 'cmdline' }
		-- 	})
		-- })

	end}

    -- Lsp
    use {
        'neovim/nvim-lspconfig',
        'williamboman/nvim-lsp-installer',
    }

    -- Status line
    use {'itchyny/lightline.vim'}
    -- use 'glepnir/spaceline.vim'

    -- Coding
    use {'liuchengxu/vista.vim', event = 'VimEnter *'}
    -- use {'majutsushi/tagbar', cmd = 'TagbarToggle'}

    -- Find everythings
    use {
        'liuchengxu/vim-clap', opt = true, event = 'VimEnter *',
        -- run = ':Clap install-binary',
        run = ':eval(clap#installer#force_download())', -- proxychinas4
        config = function()
            -- vim.g.clap_theme = 'material_design_dark'
            vim.g.clap_current_selection_sign = { 
                text = '->', texthl = 'ClapCurrentSelectionSign', linehl = 'ClapCurrentSelection' 
            }

            -- Change the CamelCase of related highlight group name to under_score_case.
            -- let g:clap_theme = { 'search_text': {'guifg': 'red', 'ctermfg': 'red'} }
            vim.g.clap_theme = { ClapInput = {guifg = 'red', ctermfg = 'red'} }

            local cheatsheets_path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/awesome-cheatsheets/README.md'
            -- `:Clap dotfiles` to open some dotfiles quickly.
            vim.g.clap_provider_dot = {
                source = {
                    '~/.config/nvim/lua/start.lua',
                    '~/.config/nvim/lua/plugins.lua',
                    '~/.config/nvim/lua/key_mappings.lua',
                    '~/.config/nvim/lua/autocmd.lua',
                    '~/.config/nvim/init.vim',
                    -- '~/.config/nvim/plugin/coc.vim',
                    '~/.config/nvim/plugin/which-vim-key.vim',
                    '~/.config/nvim/cheatsheets.md',
                    '~/.zshrc',
                    '~/.tmux.conf',
                    cheatsheets_path,
                },
                sink = 'e'
            }
        end
    }

    use { 'liuchengxu/vim-which-key', opt = true, cmd = {'WhichKey', 'WhichKey!'}}
    -- use {
    --     'AckslD/nvim-whichkey-setup.lua',
    --     requires = {'liuchengxu/vim-which-key'},
    -- }

    -- Grepping
    -- use {'mhinz/vim-grepper', opt = true, cmd = 'Grepper'}

    -- File manager
    use {'Shougo/defx.nvim', opt = true, cmd = {'Defx'}}
    use {
        'kevinhwang91/rnvimr', cmd = 'RnvimrToggle',
        config = function()
            -- Make Ranger replace Netrw and be the file explorer
            vim.g.rnvimr_enable_ex = 1
            -- Make Ranger to be hidden after picking a file
            vim.g.rnvimr_enable_picker = 1
            -- Make Neovim wipe the buffers corresponding to the files deleted by Ranger
            vim.g.rnvimr_enable_bw = 1
            -- Link CursorLine into RnvimrNormal highlight in the Floating window
            vim.cmd [[ highlight link RnvimrNormal CursorLine ]]

            -- if vim.fn.empty(vim.fn.glob(cheatsheets_path)) > 0 then
            -- end
            -- Map Rnvimr action
            vim.g.rnvimr_action = {
                 [ '<C-t>' ] = 'NvimEdit tabedit',
                 [ '<C-x>' ] = 'NvimEdit split',
                 [ '<C-v>' ] = 'NvimEdit vsplit',
                 [ 'gw' ] = 'JumpNvimCwd',
                 [ 'yw' ] = 'EmitRangerCwd',
                 }
        end
    } -- Ranger
    -- use { -- nnn
    --     'mcchrish/nnn.vim', cmd = {'NnnPicker', 'Np'},
    --     config = function()
    --         -- Disable default mappings
    --         vim.cmd [[ let g:nnn#set_default_mappings = 0 ]]
    --         -- Floating window (neovim latest and vim with patch 8.2.191)
    --         -- vim.g['nnn#layout'] = { window = { width = 0.9, height = 0.6, highlight = 'Debug'}}
    --         vim.cmd [[ let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } } ]]
    --     end
    -- }

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
    -- use {'euclidianAce/BetterLua.vim', opt = true, ft = {'lua'}}

    -- Registers
    -- Peekaboo extends " and @ in normal mode and <CTRL-R> in insert mode so you can see the contents of the registers.
    use 'junegunn/vim-peekaboo'

    -- Marks
    use {'kshenoy/vim-signature', config = function ()
        vim.g.SignatureIncludeMarks = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVW'
    end}

    -- Buffer management

    -- Movement
    use {'easymotion/vim-easymotion'}

    -- Quickfix

    -- Do stuff like :sudowrite
    use 'lambdalisue/suda.vim'

    -- Coc
    -- use {'neoclide/coc.nvim', branch = 'release'}

    -- use {'vn-ki/coc-clap', after = 'coc.nvim'}

    -- Git
    use {'rhysd/git-messenger.vim', opt = true, cmd = 'GitMessenger'}
    use {'tpope/vim-fugitive', event = 'VimEnter *',}
    -- use {'airblade/vim-gitgutter', }
	use {
        'mhinz/vim-signify',
        config = function()
        end
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
    -- use {
    --     'antoinemadec/coc-fzf',
    --     -- after = 'coc.nvim',
    --     cmd = {'CocFzfList', 'CocFzfListResume'},
    --     branch = 'release',
    --     config = function()
    --         -- Q: How to get the FZF floating window?
    --         -- A: You can look at FZF Vim integration:
    --         vim.cmd [[ let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6  }  } ]]
    --         -- Q: CocFzf looks different from my other Fzf commands. How to make it the same?
    --         -- A: By default, CocFzf tries to mimic CocList. Here is how to change this:
    --         vim.cmd [[ let g:coc_fzf_preview = '' ]]
    --         vim.cmd [[ let g:coc_fzf_opts = [] ]]
    --     end,
    -- }

    use {'junegunn/fzf', run = './install --all', lock = true}
    -- use {
    --     'junegunn/fzf.vim', event = 'VimEnter *',
    --     config = function()
    --         vim.g.fzf_preview_window = { 'up:50%', 'ctrl-/' }
    --     end,
    --     requires = {
    --         {'junegunn/fzf', run = './install --all', lock = true},
    --     }
    -- }

    -- Profiling
    use {'dstein64/vim-startuptime', cmd = 'StartupTime'}

    -- Snippets
    -- use {'honza/vim-snippets', requires = {
    --     {'SirVer/ultisnips', config = function()
    --     -- " Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
    --     -- " - https://github.com/Valloric/YouCompleteMe
    --     -- " - https://github.com/nvim-lua/completion-nvim
    --     -- let g:UltiSnipsExpandTrigger="<tab>"
    --     -- let g:UltiSnipsJumpForwardTrigger="<c-b>"
    --     -- let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    -- end},}}
    use {'L3MON4D3/LuaSnip'}

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
        'octol/vim-cpp-enhanced-highlight', event = 'VimEnter *',
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

    use {
        -- 'Yggdroot/LeaderF', event = 'VimEnter *', 
        -- 'Yggdroot/LeaderF', cmd = 'Leaderf',
        'Yggdroot/LeaderF',
        run = ':LeaderfInstallCExtension',
        config = function()
            -- vim.g.Lf_WindowPosition = 'popup'
            -- vim.g.Lf_PreviewInPopup = 1

            -- vim.cmd [[ unmap <Leader>f ]]
            -- vim.cmd [[ unmap <Leader>b ]]
            -- vim.defer_fn(function()
            --     print("xxxxx")
            -- end, 1000)
        end
    }

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
        -- 提供 ctags/gtags 后台数据库自动更新功能
        {'ludovicchabant/vim-gutentags', event = 'VimEnter *'},
        -- 提供 GscopeFind 命令并自动处理好 gtags 数据库切换
        -- 支持光标移动到符号名上：<leader>cg 查看定义，<leader>cs 查看引用
        {'skywind3000/gutentags_plus', event = 'VimEnter *'},
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
    
    -- 前面编译运行时需要频繁的操作 quickfix 窗口，ale查错时也需要快速再错误间跳转（location list），
    -- 就连文件比较也会用到快速跳转到上/下一个差异处，unimpaired 插件帮你定义了一系列方括号开头的快捷键，
    -- 被称为官方 Vim 中丢失的快捷键。
    use {
        'tpope/vim-unimpaired', event = 'VimEnter *',
    }

    -- switch file betten .cpp and .h
    use {
        'derekwyatt/vim-fswitch', ft = {'cpp', 'c'},
    }

    use {
        'skywind3000/awesome-cheatsheets', event = 'VimEnter *',
    }

    use { 'ianva/vim-youdao-translater', event = 'VimEnter *', }

    -- Highlight yank
    use {
        'machakann/vim-highlightedyank', event = 'VimEnter *',
    }

    -- Create user text objects
    -- use {
    --     'kana/vim-textobj-user'
    -- }

    -- 调颜色插件
    -- Provides command :XtermColorTable, as well as variants for different splits
    -- Xterm numbers on the left, equivalent RGB values on the right
    -- Press # to yank current color (shortcut for yiw)
    -- Press t to toggle RGB text visibility
    -- Press f to set RGB text to current color
    -- Buffer behavior similar to Scratch.vim
    use {
        'guns/xterm-color-table.vim', cmd = 'XtermColorTable'
    }

    use {
        'luochen1990/rainbow',
        config = 'vim.g.rainbow_active = 1',
    }


    use {
        'norcalli/nvim-colorizer.lua', event = 'VimEnter *',
        config = function ()
            require('colorizer').setup()
        end
    }

    -- Clojure
    use {
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

    use {'jiangmiao/auto-pairs', config = function()
        vim.cmd [[ au FileType lisp,clojure,lisp let b:AutoPairs = {'```': '```', '`': '`', '"': '"', '[': ']', '(': ')', '{': '}', '"""': '"""'} ]]
    end}

    use {
        -- 使用 ALT+e 会在不同窗口/标签上显示 A/B/C 等编号，然后字母直接跳转
        't9md/vim-choosewin',
        config = function()
            -- 使用 ALT+E 来选择窗口
            vim.cmd [[ nmap <m-e> <Plug>(choosewin) ]]
        end
    }

    use {
        -- 用 v 选中一个区域后，ALT_+/- 按分隔符扩大/缩小选区
        'terryma/vim-expand-region',
        config = function()
            -- ALT_+/- 用于按分隔符扩大缩小 v 选区
            vim.cmd [[ map <m-=> <Plug>(expand_region_expand) ]]
            vim.cmd [[ map <m--> <Plug>(expand_region_shrink) ]]
        end
    }

    use {
        -- powershell 脚本文件的语法高亮
        'pprovost/vim-ps1', ft = { 'ps1' }
    }

    use {
        -- " 额外语法文件
        'justinmk/vim-syntax-extra', ft = { 'c', 'bison', 'flex', 'cpp' }
    }

    use {
        -- rust 语法增强
        'rust-lang/rust.vim', ft = 'rust'
    }

    use {
        -- vim org-mode 
        'jceb/vim-orgmode', ft = 'org'
    }
end)
