local is_windows = require('global').is_windows
-- local cmd = vim.cmd
return {
    -- File manager
    -- pip3 install --user pynvim
    {
        'kyazdani42/nvim-tree.lua',
        version = 'nightly', -- optional, updated every week. (see issue #1193)
        keys = {
            {'<Leader>tt', '<CMD>NvimTreeToggle<CR>', 'nvim tree toggle'},
            {'<Leader>tf', '<CMD>NvimTreeFindFileToggle<CR>', 'nvim tree find file toggle'},
        },
        config = function()
            -- require("nvim-tree").setup()
            require("nvim-tree").setup({
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
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = true,
                },
            })
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
                [ '<C-t>' ] = 'NvimEdit tabedit',
                [ '<C-x>' ] = 'NvimEdit split',
                [ '<C-v>' ] = 'NvimEdit vsplit',
                [ 'gw' ] = 'JumpNvimCwd',
                [ 'yw' ] = 'EmitRangerCwd',
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
