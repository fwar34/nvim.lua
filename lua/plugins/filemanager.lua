local is_windows = require('global').is_windows
local api = vim.api
local set = vim.keymap.set
return {
    -- File manager
    -- pip3 install --user pynvim
    {
        'kyazdani42/nvim-tree.lua',
        version = 'nightly', -- optional, updated every week. (see issue #1193)
        cmd = { 'NvimTreeToggle', 'NvimTreeFindFileToggle' },
        keys = {
            { '<Leader>tf', '<CMD>NvimTreeToggle<CR>',          'nvim tree toggle' },
            { '<Leader>tt', '<CMD>NvimTreeFindFileToggle!<CR>', 'nvim tree find file toggle' },
        },
        config = function()
            local args = {
                sort_by = "case_sensitive",
                view = {
                    adaptive_size = true,
                    mappings = {
                        list = {
                            { key = "u", action = "dir_up" },
                            { key = "h", action = "dir_up" },
                            { key = "l", action = "cd" },
                        },
                    },
                },
                filters = {
                    dotfiles = true,
                },
            }
            if is_windows or vim.g.neovide then
                args = vim.tbl_deep_extend('error', args, {
                    renderer = {
                        group_empty = true,
                    },
                })
            else
                args = vim.tbl_deep_extend('error', args, {
                    renderer = {
                        group_empty = true,
                        icons = {
                            glyphs = {
                                bookmark = '*',
                            }
                        }
                    },
                })
            end
            require("nvim-tree").setup(args)


            api.nvim_create_autocmd("FileType", {
                pattern = 'NvimTree',
                callback = function()
                    -- set('n', '<Leader>tn', function () buffer_hydra:activate() end, { desc = 'nvim-tree', buffer = true })
                    -- buffer_hydra:activate()
                    local Hydra = require('hydra')
                    Hydra({
                        name = 'nvim-tree',
                        config = {
                            -- exit = true,
                            color = 'amaranth',
                        },
                        body = '<Leader>t',
                        heads = {
                            { 's',     require('nvim-tree.api').marks.navigate.select, { desc = 'select mark', exit = true } },
                            { 'n',     require('nvim-tree.api').marks.navigate.next,   { desc = 'next mark' } },
                            { 'p',     require('nvim-tree.api').marks.navigate.prev,   { desc = 'prev mark' } },
                            { 'q',     nil,                                            { exit = true } },
                            { '<Esc>', nil,                                            { exit = true, desc = 'quit' } }
                        }
                    })
                end
            })
            set({'n', 'v'}, '<Leader>ts', require('nvim-tree.api').marks.navigate.select, {desc = 'nvim-tree bookmark select'})
        end
    },
    {
        'kevinhwang91/rnvimr', cmd = 'RnvimrToggle',
        config = function()
            -- Make Ranger replace Netrw and be the file explorer
            vim.g.rnvimr_enable_ex = 1
            -- Make Ranger to be hidden after picking a file
            vim.g.rnvimr_enable_picker = 1
            -- Make Neovim wipe the buffers corresponding to the files deleted by Ranger
            vim.g.rnvimr_enable_bw = 1
            -- Link CursorLine into RnvimrNormal highlight in the Floating window
            -- cmd [[ highlight link RnvimrNormal CursorLine ]]

            -- if vim.fn.empty(vim.fn.glob(cheatsheets_path)) > 0 then
            -- end
            -- Map Rnvimr action
            vim.g.rnvimr_action = {
                ['<C-t>'] = 'NvimEdit tabedit',
                ['<C-x>'] = 'NvimEdit split',
                ['<C-v>'] = 'NvimEdit vsplit',
                ['gw'] = 'JumpNvimCwd',
                ['yw'] = 'EmitRangerCwd',
            }
        end,
        enabled = not is_windows
    },
    -- Ranger
    -- use { -- nnn
    --     'mcchrish/nnn.vim', cmd = {'NnnPicker', 'Np'},
    --     config = function()
    --         -- Disable default mappings
    --         cmd [[ let g:nnn#set_default_mappings = 0 ]]
    --         -- Floating window (neovim latest and vim with patch 8.2.191)
    --         -- vim.g['nnn#layout'] = { window = { width = 0.9, height = 0.6, highlight = 'Debug'}}
    --         cmd [[ let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } } ]]
    --     end
    -- }
}
