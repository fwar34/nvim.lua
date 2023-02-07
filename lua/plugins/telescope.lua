return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function ()
            local use_devicons = function ()
                if vim.env.MYHOSTNAME == 'ubuntu-work' then
                    return false
                else
                    return true
                end
            end
            -- You dont need to set any of these options. These are the default ones. Only
            -- the loading is important
            require('telescope').setup {
                defaults = {
                    -- Default configuration for telescope goes here:
                    -- config_key = value,
                    mappings = {
                        i = {
                            -- map actions.which_key to <C-h> (default: <C-/>)
                            -- actions.which_key shows the mappings for your picker,
                            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                            ["<C-h>"] = "which_key",
                            -- ["<C-g>"] = "close",
                            ["<C-g>"] = require('telescope.actions').close,
                        },
                        n = {
                            -- ["<C-g>"] = "close",
                            ["<C-g>"] = require('telescope.actions').close,
                        }
                    },

                    layout_strategy = 'vertical',
                    -- layout_config = { height = 0.95 },
                    color_devicons = use_devicons(),
                },
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--hidden",
                },
                file_ignore_patterns = {},
                --pickers = {
                --    find_files = {
                --        find_command = { "fd", "--type=file", "--hidden", "--smart-case" },
                --    },
                --    live_grep = {
                --        --@usage don't include the filename in the search results
                --        only_sort_text = true,
                --    },
                --},
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    },
                    undo = {
                        side_by_side = true,
                        layout_strategy = "horizontal",
                        layout_config = {
                            preview_height = 0.4,
                        },
                    }
                }
            }
        end,

    },
    {
        'nvim-telescope/telescope-fzf-native.nvim', build = 'make',
        config = function ()
            -- To get fzf loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            require('telescope').load_extension('fzf')
        end
    },
    {
        -- need install sqlit
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
            require("telescope").load_extension("frecency")
        end,
        dependencies = {"tami5/sqlite.lua"}
    },
    {
        'nvim-telescope/telescope-live-grep-raw.nvim',
        config = function()
            require("telescope").load_extension("live_grep_args")
        end,
    },
    {
        'debugloop/telescope-undo.nvim',
        config = function ()
            require("telescope").load_extension("undo")
        end
    }
}
