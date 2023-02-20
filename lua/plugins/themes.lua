local cmd = vim.cmd
return {
    -- A colorscheme helper for Neovim.
    'tjdevries/colorbuddy.nvim',
    -- Color scheme
    'tjdevries/gruvbuddy.nvim',
    {
        'Th3Whit3Wolf/onebuddy',  config = function ()
            -- require('colorbuddy').colorscheme('onebuddy')
        end
    },

    {
        -- "joshdick/onedark.vim",
        'ii14/onedark.nvim',
        -- 'navarasu/onedark.nvim',
        -- 'olimorris/onedarkpro.nvim',
        config = function ()
            cmd [[ colorscheme onedark ]]
        end
    },

    -- Themes
    {
        'glepnir/oceanic-material', config = function ()
            -- cmd [[ colorscheme oceanic_material ]]
        end
    },
    -- You can alias plugin names
    {'dracula/vim', name = 'dracula'},
    -- {'fwar34/vim-color-wombat256.git', as = 'wombat256'}

    -- Note: vim-colorschemes conflict with onedark
    -- {'flazz/vim-colorschemes'}, -- one stop shop for vim colorschemes.
}
