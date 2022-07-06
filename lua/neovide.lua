local function setup()
    vim.g.neovide_cursor_trail_legnth = 0
    vim.g.neovide_cursor_animation_length = 0
    -- vim.o.guifont = "Jetbrains Mono"
    -- https://github.com/laishulu/Sarasa-Mono-SC-Nerd
    vim.o.guifont = 'Sarasa Mono SC Nerd'
    vim.g.neovide_remember_window_size = true
    -- vim.g.neovide_transparency = 0.9
    vim.g.neovide_cursor_vfx_mode = "ripple"
end

setup()
