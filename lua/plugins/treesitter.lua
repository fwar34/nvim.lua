return {
    {
        'nvim-treesitter/nvim-treesitter', build = ':TSUpdate',
        config = function ()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    'bash', 'c', 'cpp', 'lua', 'css', 'fennel', 'html', 'javascript', 'json', 'julia', 'go',
                    'ocaml', 'ocaml_interface', 'python', 'rust', 'toml', 'typescript', 'clojure', 'fennel'
                },     -- one of "all", "language", or a list of languages
                highlight = {
                    enable = true,              -- false will disable the whole extension
                    -- disable = { "c", "rust" },  -- list of language that will be disabled
                },
            }
        end
    }
}
