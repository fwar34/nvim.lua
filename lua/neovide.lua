local env = vim.env

local function setup()
    vim.g.neovide_cursor_trail_legnth = 0
    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_remember_window_size = true
    -- vim.g.neovide_transparency = 0.9
    -- vim.g.neovide_cursor_vfx_mode = 'railgun'
    vim.g.neovide_cursor_vfx_mode = 'torpedo'
    -- vim.g.neovide_cursor_vfx_mode = 'pixiedust'

    -- vim.g.neovide_cursor_vfx_mode = 'sonicboom'
    -- vim.g.neovide_cursor_vfx_mode = 'wireframe'
    -- vim.g.neovide_cursor_vfx_mode = "ripple"
    vim.g.neovide_no_idle = true
    -- local hostname = require('global').hostname
    if env.MYHOSTNAME == 'archlinux' then -- pve-archlinux
        -- https://github.com/laishulu/Sarasa-Mono-SC-Nerd
        vim.opt.guifont = 'Sarasa Mono SC Nerd:h13'
        -- vim.o.guifont = "Jetbrains Mono"
        -- vim.o.guifont = 'Sarasa Mono SC Nerd'
    elseif env.MYHOSTNAME == 'ubuntu-work' then -- work
        vim.opt.guifont = 'Sarasa Mono SC Nerd:h12'
    elseif env.MYHOSTNAME == 'desktop-archlinux' then -- taishi-archlinux
        vim.opt.guifont = 'Sarasa Mono SC Nerd:h14'
    end

end

setup()
