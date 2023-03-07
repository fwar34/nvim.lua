return {
    'folke/noice.nvim',
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        {
            "MunifTanjim/nui.nvim",
            config = function ()
                -- override the default split view to always enter the split when it opens
                require("noice").setup({
                    relative = "win",
                    size = {
                        width = 80,
                        height = 40,
                    },
                    position = {
                        row = 30,
                        col = 20,
                    },
                })
            end
        },
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        -- "rcarriga/nvim-notify",
    },
    config = function()
        require("noice").setup({
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
            },
        })
        require("telescope").load_extension("noice")

        vim.keymap.set("c", "<S-Enter>", function()
            require("noice").redirect(vim.fn.getcmdline())
        end, { desc = "Redirect Cmdline" })

        vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
            if not require("noice.lsp").scroll(4) then
                return "<c-f>"
            end
        end, { silent = true, expr = true })

        vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
            if not require("noice.lsp").scroll( -4) then
                return "<c-b>"
            end
        end, { silent = true, expr = true })
    end
}
