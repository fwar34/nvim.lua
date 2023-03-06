return {
    {
        -- https://github.com/noib3/nvim-cokeline#wrench-configuration
        -- https://github.com/rafcamlet/tabline-framework.nvim
        'akinsho/bufferline.nvim',
        -- enabled = false,
        event = 'VimEnter *',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        version = 'v3.5.0',
        config = function()
            local setup = function()
                require("bufferline").setup {
                    options = {
                        -- 使用 nvim 内置lsp
                        -- diagnostics = "nvim_lsp",
                        custom_filter = function(buf)
                            if require('sessionmgr.sessionmgr').is_buf_hide(buf) then
                                return false
                            end
                            return true;
                        end
                    }
                }
            end
            setup()
            vim.api.nvim_create_user_command('TT', setup, {})
        end
    },
}
