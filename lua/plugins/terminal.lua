return {
    -- Terminal
    {
        'voldikss/vim-floaterm', event = 'VimEnter *',
        setup = function()
            -- Type Number. The transparency of the floating terminal. Only works in neovim.
            vim.g.floaterm_winblend = 8
            if vim.env.MYHOSTNAME == 'ubuntu-work' then
                vim.g.floaterm_width = 0.9
            else
                vim.g.floaterm_width = 0.7
            end
            vim.g.floaterm_height = 0.9
            -- vim.g.floaterm_keymap_new = '<F7>'
            -- vim.g.floaterm_keymap_prev = '<F8>'
            -- vim.g.floaterm_keymap_next = '<F9>'
            vim.g.floaterm_keymap_toggle = '<leader>tm'
        end
    },

    {
        'skywind3000/vim-terminal-help', event = 'VimEnter *',
        config = function()
            vim.g.terminal_height = 20
            vim.g.terminal_list = 0 -- set to 0 to hide terminal buffer in the buffer list.
        end
    }
}
