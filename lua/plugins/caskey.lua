return {
    {
        "Nexmean/caskey.nvim",
        dependencies = {
            "folke/which-key.nvim", -- optional, only if you want which-key integration
        },
        config = function ()
            require("caskey.wk").setup(require("caskey_mappings"))
        end
    }
}
