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
                -- rainbow = {
                --     enable = true,
                --     -- list of languages you want to disable the plugin for
                --     -- disable = { "jsx", "cpp" },
                --     -- Which query to use for finding delimiters
                --     -- query = 'rainbow-parens',
                --     -- Highlight the entire buffer all at once
                --     -- strategy = require 'ts-rainbow.strategy.global',
                --     -- Do not enable for files with more than n lines
                --     max_file_lines = 3000
                -- }
            }
        end
    },
    -- 'HiPhish/nvim-ts-rainbow2',
}