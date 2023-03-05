return {
    {
        -- tabline plugin
        'romgrk/barbar.nvim',
        enabled = false,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require 'bufferline'.setup({
                -- Enable/disable animations
                animation = true,
                -- Enables/disable clickable tabs
                --  - left-click: go to buffer
                --  - middle-click: delete buffer
                clickable = true,
                -- Excludes buffers from the tabline
                -- exclude_ft = {'javascript'},
                -- exclude_name = {'package.json'},
                -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
                -- hide = {extensions = true, inactive = true},
                -- Enable/disable icons
                -- if set to 'numbers', will show buffer index in the tabline
                -- if set to 'both', will show buffer index and icons in the tabline
                icons = require('global').hostname == 'ubuntu-work' and false or true,
                icon_pinned = '車',
            })
        end
    },
    {
        -- https://github.com/noib3/nvim-cokeline#wrench-configuration
        -- https://github.com/rafcamlet/tabline-framework.nvim
        'akinsho/bufferline.nvim',
        -- enabled = false,
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        version = 'v3.5.0',
        config = function()
            require("bufferline").setup {
                options = {
                    -- 使用 nvim 内置lsp
                    diagnostics = "nvim_lsp",
                    -- 左侧让出 nvim-tree 的位置
                    offsets = { {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        highlight = "Directory",
                        text_align = "left"
                    } }
                }
            }
        end
    },
    {
        'noib3/nvim-cokeline',
        enabled = false,
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require('cokeline').setup()
        end
    }
}
