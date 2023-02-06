return {
    -- Status line
    {
        'ojroques/vim-scrollstatus',
        config = function()
            vim.g.scrollstatus_size = 12
            vim.g.scrollstatus_symbol_track = '-'
            vim.g.scrollstatus_symbol_bar = '#'
        end
    },

    -- Status line
    {
        'itchyny/lightline.vim',
        config = function ()
            vim.g.lightline = {
                colorscheme = 'wombat',
                component = {charvaluehex = '0x%B'},
                active = {
                    left = {{'mode', 'sessionmgr', 'paste'}, {'gitbranch', 'gitstatus', 'readonly', 'filename', 'session_name', 'modified', 'method'}},
                    right = {{'lineinfo'}, {'charvaluehex', 'scorestatus', 'fileformat', 'fileencoding', 'filetype'}},
                },
                component_function = {
                        sessionmgr = 'SessionMgrStatus',
                        method = 'NearestMethodOrFunction',
                        gitbranch = 'FugitiveStatusline',
                        scorestatus = 'ScrollStatus',
                        gitstatus = 'sy#repo#get_stats_decorated',
                    },
                }
            end
        },
        -- 'glepnir/spaceline.vim'
        -- {
        --     'nvim-lualine/lualine.nvim',
        -- },
    }
