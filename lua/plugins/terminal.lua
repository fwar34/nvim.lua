-- If <C-\> is pressed, the next key is sent unless it is <C-N> or <C-O>.
-- Use <C-\><C-N> to return to normal mode. |CTRL-\_CTRL-N|
-- Use <C-\><C-O> to execute one normal mode command and then return to terminal mode.
return {
    -- Terminal
    -- {
    --     'voldikss/vim-floaterm', event = 'VimEnter *',
    --     init = function()
    --         -- Type Number. The transparency of the floating terminal. Only works in neovim.
    --         vim.g.floaterm_winblend = 8
    --         if vim.env.MYHOSTNAME == 'ubuntu-work' then
    --             vim.g.floaterm_width = 0.9
    --         else
    --             vim.g.floaterm_width = 0.7
    --         end
    --         vim.g.floaterm_height = 0.9
    --         -- vim.g.floaterm_keymap_new = '<F7>'
    --         -- vim.g.floaterm_keymap_prev = '<F8>'
    --         -- vim.g.floaterm_keymap_next = '<F9>'
    --         vim.g.floaterm_keymap_toggle = '<leader>tm'
    --     end
    -- },

    {
        'skywind3000/vim-terminal-help', event = 'VimEnter *',
        config = function()
            vim.g.terminal_height = 20
            vim.g.terminal_list = 0 -- set to 0 to hide terminal buffer in the buffer list.
        end
    },

    {
        'akinsho/toggleterm.nvim',
        config = function()
            require('toggleterm').setup()
            vim.cmd([[
" set
autocmd TermEnter term://*toggleterm#*
      \ tnoremap <silent><C-\> <Cmd>exe v:count1 . "ToggleTerm"<CR>

" By applying the mappings this way you can pass a count to your
" mapping to open a specific window.
" For example: 2<C-\> will open terminal 2
nnoremap <silent><C-\> <Cmd>exe v:count1 . "ToggleTerm"<CR>
inoremap <silent><C-\> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>
tnoremap <silent><Esc> <C-\><C-N>
            ]])
        end,
        init = function()
            if require('futil').is_windows() then
                -- https://github.com/akinsho/toggleterm.nvim/wiki/Tips-and-Tricks#using-toggleterm-with-powershell
                local powershell_options = {
                    shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
                    shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
                    shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
                    shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
                    shellquote = "",
                    shellxquote = "",
                }

                for option, value in pairs(powershell_options) do
                    vim.opt[option] = value
                end
            end
        end
    },
}
