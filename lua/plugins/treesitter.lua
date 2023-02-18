return {
    {
        'nvim-treesitter/nvim-treesitter', build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    'bash', 'c', 'cpp', 'lua', 'css', 'fennel', 'html', 'javascript', 'json', 'julia', 'go', 'java', 'lisp',
                    'commonlisp', 'ocaml', 'ocaml_interface', 'python', 'rust', 'toml', 'typescript', 'clojure', 'fennel', 'org'
                }, -- one of "all", "language", or a list of languages
                highlight = {
                    enable = true, -- false will disable the whole extension
                    -- disable = { "c", "rust" },  -- list of language that will be disabled
                    -- Required for spellcheck, some LaTex highlights and
                    -- code block highlights that do not have ts grammar
                    additional_vim_regex_highlighting = { 'org' },
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
        end,
        -- enabled = not require('futil').is_windows()
    },
    -- 'HiPhish/nvim-ts-rainbow2',
}
