return {
    {
        "folke/which-key.nvim",
        config = function ()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end
    },
    {'tjdevries/colorbuddy.nvim'},

    {'junegunn/fzf', build = './install --all', pin = true},
    {
        -- 需要使用最新版的 bat 来预览，可以直接在 release 页面下载
        'junegunn/fzf.vim', event = 'VimEnter *',
        config = function()
            vim.g.fzf_preview_window = { 'up:50%', 'ctrl-/' }
        end,
        -- requires = {
        --     {'junegunn/fzf', run = './install --all', lock = true},
        -- }
    },
    -- Registers
    -- Peekaboo extends " and @ in normal mode and <CTRL-R> in insert mode so you can see the contents of the registers.
    'junegunn/vim-peekaboo',
    -- Marks
    {
        'kshenoy/vim-signature',
        config = function ()
            vim.g.SignatureIncludeMarks = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVW'
        end
    },
    -- Movement
    'easymotion/vim-easymotion',
    -- Do stuff like :sudowrite
    -- use 'lambdalisue/suda.vim'
    -- 提供一系列 shell 命令
    'tpope/vim-eunuch',
    -- Profiling
    {'dstein64/vim-startuptime', cmd = 'StartupTime'},
    -- vim-multiple-cursors
    {
        'terryma/vim-multiple-cursors',
        config = function()
            -- If set to 0, insert mappings won't be supported in Insert mode anymore.
            vim.g.multi_cursor_support_imap = 0
        end
    },

    -- Surround
    {
        'tpope/vim-surround',
        config = function()
            -- 有定义 i<C-g>s 等 map 导致其他地方定义的 <C-g> 等待超时才起效
            -- 定义下面的变量可以防止在 insert 模式 vim-surround 定义相关 key mappings
            vim.g.surround_no_insert_mappings = 1
        end
    },

    -- Highlight for stl
    {
        'octol/vim-cpp-enhanced-highlight', event = 'VimEnter *',
        config = function()
            vim.g.cpp_class_scope_highlight = 1
            vim.g.cpp_class_decl_highlight = 1
        end
    },

    -- Highlight whitespace and fix
    -- use {'bronson/vim-trailing-whitespace', event = 'VimEnter *'}
    {
        'ntpeters/vim-better-whitespace',
        config = function()
            vim.g.better_whitespace_operator = '<leader>ss'
            vim.g.better_whitespace_enabled = 0
            vim.g.better_whitespace_filetypes_blacklist = {'gitcommit', 'unite', 'qf', 'help', 'markdown', 'packer',}
            vim.cmd [[let g:show_spaces_that_precede_tabs = 1]]
        end
    },

    -- Improved Lua 5.3 syntax and indentation support for Vim.
    {'tbastos/vim-lua', ft = 'lua'},

    {
        'vim-python/python-syntax', ft = 'python',
        config = function()
            vim.g.python_highlight_all = 1
        end
    },

    -- A Vim text editor plugin to swap delimited items.
    {
        'machakann/vim-swap', event = 'VimEnter *',
    },

    -- adds various text objects to give you more targets to operate on.
    {
        'wellle/targets.vim', event = 'VimEnter *',
    },

    {
        'dstein64/vim-win', event = 'VimEnter *',
        config = function()
        end
    },
    -- Async task
    {
        'skywind3000/asynctasks.vim', after = 'asyncrun.vim',
        requires = {'skywind3000/asyncrun.vim', event = 'VimEnter *'},
        config = function()
            -- 告诉 asyncrun 运行时自动打开高度为 6 的 quickfix 窗口，不然你看不到任何输出
            vim.g.asyncrun_open = 6
            vim.g.asyncrun_rootmarks = {'.svn', '.git', '.root', '.bzr', '_darcs', 'build.xml', "pom.xml"}
        end
    },

    -- 前面编译运行时需要频繁的操作 quickfix 窗口，ale查错时也需要快速再错误间跳转（location list），
    -- 就连文件比较也会用到快速跳转到上/下一个差异处，unimpaired 插件帮你定义了一系列方括号开头的快捷键，
    -- 被称为官方 Vim 中丢失的快捷键。
    {
        'tpope/vim-unimpaired', event = 'VimEnter *',
    },

    -- switch file betten .cpp and .h
    {
        'derekwyatt/vim-fswitch', ft = {'cpp', 'c'},
    },

    {
        'skywind3000/awesome-cheatsheets', event = 'VimEnter *',
    },

    { 'ianva/vim-youdao-translater', event = 'VimEnter *', },
    -- 调颜色插件
    -- Provides command :XtermColorTable, as well as variants for different splits
    -- Xterm numbers on the left, equivalent RGB values on the right
    -- Press # to yank current color (shortcut for yiw)
    -- Press t to toggle RGB text visibility
    -- Press f to set RGB text to current color
    -- Buffer behavior similar to Scratch.vim
    {
        'guns/xterm-color-table.vim', cmd = 'XtermColorTable'
    },

    -- {
    --     'luochen1990/rainbow',
    --     config = function ()
    --         vim.g.rainbow_active = 1
    --     end
    -- },

    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },

    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require'colorizer'.setup()
        end
    },

    {
        -- 用 v 选中一个区域后，ALT_+/- 按分隔符扩大/缩小选区
        'terryma/vim-expand-region',
        config = function()
            -- ALT_+/- 用于按分隔符扩大缩小 v 选区
            vim.cmd [[map <m-=> <Plug>(expand_region_expand)]]
            vim.cmd [[map <m--> <Plug>(expand_region_shrink)]]
        end
    },

    {
        -- powershell 脚本文件的语法高亮
        'pprovost/vim-ps1', ft = { 'ps1' }
    },

    {
        -- " 额外语法文件
        'justinmk/vim-syntax-extra', ft = { 'c', 'bison', 'flex', 'cpp' }
    },

    {
        -- rust 语法增强
        'rust-lang/rust.vim', ft = 'rust'
    },

    {
        -- vim org-mode
        'jceb/vim-orgmode', ft = 'org'
    },
    -- {
    --     -- tabline plugin
    --     'romgrk/barbar.nvim',
    --     dependencies = {'kyazdani42/nvim-web-devicons'}
    -- },

    'gcmt/wildfire.vim',
    'azabiong/vim-highlighter',
    -- TODO:
    {
        "folke/todo-comments.nvim",
        dependencies = {'nvim-lua/plenary.nvim'},
        config = function()
            require("todo-comments").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    },

    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
            -- {{{ https://github.com/numToStr/Comment.nvim/issues/70, https://github.com/numToStr/Comment.nvim/pull/73
            local A = vim.api
            function _G.___gdc(vmode)
                local C = require('Comment.config')
                local U = require('Comment.utils')
                local Op = require('Comment.opfunc')

                local range = U.get_region(vmode)
                local cfg = C:get()
                local ctx = {
                    cmode = U.cmode.comment, -- Always comment the line
                    cmotion = U.cmotion.line, -- Line action `gy2j`
                    ctype = U.ctype.line, -- Use line style comment
                    range = range,
                }
                local lcs, rcs = U.parse_cstr(cfg, ctx)
                local lines = U.get_lines(range)

                -- Copying the block
                local srow = ctx.range.erow
                A.nvim_buf_set_lines(0, srow, srow, false, lines)

                -- Doing the comment
                Op.linewise({
                    cfg = cfg,
                    cmode = ctx.cmode,
                    lines = lines,
                    lcs = lcs,
                    rcs = rcs,
                    range = range,
                })

                -- Move the cursor
                local erow = srow + 1
                local line = U.get_lines({ srow = srow, erow = erow })
                local _, col = U.grab_indent(line[1])
                A.nvim_win_set_cursor(0, { erow, col })
            end

            -- gy0 当前行，光标必须在非空字符上, 其他 gy2j gy2k等等
            -- local opt = { silent = true, noremap = true }
            local opt = { noremap = true }
            A.nvim_set_keymap('x', 'gy', '<ESC><CMD>lua ___gdc(vim.fn.visualmode())<CR>', opt)
            A.nvim_set_keymap('n', 'gy', '<CMD>set operatorfunc=v:lua.___gdc<CR>g@', opt)
            -- }}}
        end
    },
    -- better quickfix
    'kevinhwang91/nvim-bqf',

    'solarnz/thrift.vim',
    'ibhagwan/fzf-lua',

    -- A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
    {
        "folke/trouble.nvim",
        dependencies = {'kyazdani42/nvim-web-devicons'},
        config = function()
            require("trouble").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    },
    -- Lua
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
                require('telescope').load_extension('projects')
            }
        end
    },
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        dependencies = {
            "SmiteshP/nvim-navic",
            -- "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        opts = {
            -- configurations go here
        },
        config = function()
            require("barbecue").setup()
        end,
    },
}
