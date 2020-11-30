local keybindings = {}

-- noremap <Leader>fd :echo expand('%:p')<CR>

local function set_leader()
    vim.g.mapleader = ";"
    vim.g.maplocalleader = " "
end

function keybindings.setup()
    set_leader()
    vim.api.nvim_buf_set_keymap(0, 'i', '<leader>g', '<C-c>', {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(0, 'v', '<leader>g', '<Esc>', {noremap = true, silent = true})
    -- vim-which-key
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader> :Whichkey', ';<CR>', {noremap = true, silent = true})
end

return keybindings
