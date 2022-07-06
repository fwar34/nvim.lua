local function setup()
    vim.g.neovide_cursor_trail_legnth = 0
    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_remember_window_size = true
    -- vim.g.neovide_transparency = 0.9
    vim.g.neovide_cursor_vfx_mode = "ripple"
    vim.g.neovide_no_idle = true
    if require('global').hostname == 'archlinux' then -- pve-archlinux
        -- https://github.com/laishulu/Sarasa-Mono-SC-Nerd
        vim.opt.guifont = 'Sarasa Mono SC Nerd:h13'
        -- vim.o.guifont = "Jetbrains Mono"
        -- vim.o.guifont = 'Sarasa Mono SC Nerd'
    end
end

setup()
