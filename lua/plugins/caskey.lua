local cmd = vim.cmd
return {
    {
        "Nexmean/caskey.nvim",
        dependencies = {
            "folke/which-key.nvim", -- optional, only if you want which-key integration
        },
        config = function()
            local ck = require("caskey")
            require("caskey.wk").setup({
                -- options are inherits so you can define most regular at the top of keymaps config
                mode = { "n", "v" },

                -- Simple keymap with `caskey.cmd` helper and mode override
                -- ["<Esc>"] = { act = ck.cmd "noh", desc = "no highlight", mode = "n" },

                -- group keymaps to reuse options or just for config structuring
                {
                    mode = { "i", "t", "c" },

                    -- ["<C-a>"] = { act = "<Home>", desc = "Beginning of line" },
                    -- ["<C-e>"] = { act = "<End>", desc = "End of line" },
                    -- ["<C-f>"] = { act = "<Right>", desc = "Move forward" },
                    -- ["<C-b>"] = { act = "<Left>", desc = "Move back" },
                    -- override options
                    ["<C-d>"] = { act = "<Delete>", desc = "Delete next character", mode = { "i", "c" } },
                },
                {
                    ['<leader>lz'] = { act = ck.cmd 'Lazy', desc = 'Lazy'}
                },

                -- structure your keymaps as a tree and define which-key prefixes
                -- ["<leader>t"] = {
                --     name = "tabs",
                --
                --     n = { act = ck.cmd "tabnew", desc = "new tab" },
                --     x = { act = ck.cmd "tabclose", desc = "close tab" },
                --     -- t = {act = ck.cmd "Telescope telescope-tabs list_tabs", desc = "list tabs"},
                -- },

                -- define buffer local keymaps
                -- ["q"] = {
                --     act = ck.cmd "close",
                --     desc = "close window",
                --     when = {
                --         ck.ft "Outline",
                --         ck.bt { "quickfix", "help" },
                --         -- that is equivalent to:
                --         {
                --             event = "FileType",
                --             pattern = "Outline",
                --         },
                --         {
                --             event = "BufWinEnter",
                --             condition = function()
                --                 return vim.tbl_contains({ "quickfix", "help" }, vim.o.buftype)
                --             end
                --         }
                --     },
                -- },

                -- use functions as config bodies
                -- ["<leader>h"] = function ()
                --   local gs = require("gitsigns")
                --
                --   return {
                --     name = "hunk",
                --
                --     mode = "n",
                --
                --     -- Sometimes there aren't events which describe that you need to setup buffer local mappings.
                --     -- For such cases you can use custom events.
                --     -- Caskey provides api for emitting them:
                --     --   -- nvim/lua/user/plugins/gitsigns.lua
                --     --   ...
                --     --   on_attach = function (bufnr)
                --     --     require("caskey").emit("Gitsigns", bufnr)
                --     --   end
                --     --   ...
                --     --
                --     -- And then you can use `ck.emit` to describe when to setup mappings
                --     when = ck.emitted "Gitsigns",
                --
                --     s = {act = gs.stage_hunk     , desc = "stage hunk"},
                --     r = {act = gs.reset_hunk     , desc = "rest hunk"},
                --     S = {act = gs.stage_buffer   , desc = "stage buffer"},
                --     u = {act = gs.undo_stage_hunk, desc = "unstage hunk"},
                --     d = {act = gs.preview_hunk   , desc = "preview hunk"} ,
                --     b = {act = gs.blame_line     , desc = "blame line"},
                --   }
                -- end,

                -- {
                --     mode = "n",
                --     when = "LspAttach",
                --     ["gd"] = { act = ck.cmd "Telescope lsp_definitions", desc = "lsp definition" },
                --     ["<C-s>"] = {
                --         act = ck.cmd "SymbolsOutline",
                --         desc = "toggle outline",
                --         -- extend mode or buffer local configuration
                --         mode_extend = "v",
                --         when_extend = ck.ft "Outline",
                --     },
                -- },

                {
                    name = 'toggleterm',
                    ['<leader>t'] = {
                        m = {
                            act = ck.cmd 'ToggleTerm',
                            desc = 'toggle terminal',
                        },
                        mode = 't'
                    },
                    ['<leader>tm'] = {
                        act = function()
                            vim.g.cwd = vim.fn.getcwd()
                            cmd('ToggleTerm')
                        end,
                        desc = 'toggle terminal',
                    },
                    ['<C-j>'] = { act = function() vim.api.nvim_input('cd ' .. vim.g.cwd .. '<CR>') end, desc = 'jump to directory of buffer', mode = 't' },
                    -- ['<Esc>'] = { act = vim}
                },
                {
                    name = 'code_runner.nvim',
                    ['<leader>rc'] = {
                        act = ck.cmd('RunCode'),
                        desc = 'RunCode'
                    }
                },
                {
                    name = 'toggle win32yank',
                    ['<F10>'] = {
                        act = function ()
                            if require('global').is_windows then
                                if vim.g.IsWin32yankActive then
                                    vim.opt.clipboard:remove('unnamedplus')
                                else
                                    vim.opt.clipboard:append('unnamedplus')
                                end
                                vim.g.IsWin32yankActive = not vim.g.IsWin32yankActive
                            end
                        end,
                        mode = {'n', 'v', 'i'}
                    }
                },
                {
                    name = 'markdown',
                    ['<leader>m'] = {
                        t = {
                            act = ck.cmd 'MarkdownPreviewToggle',
                            desc = 'markdown preview toggle'
                        }
                    }
                }
            })
        end
    }
}
