local api = vim.api
return {
    {
        'nvim-treesitter/nvim-treesitter', build = ':TSUpdate',
        event = 'BufReadPost',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    'bash', 'c', 'cpp', 'lua', 'css', 'html', 'javascript', 'json', 'julia', 'go', 'java', 'thrift', 'vim', 'markdown', 'regex',
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

            -- 下面的代码高亮有问题，取消此文件的高亮
            -- aui->isLiveInvitedWebRtcUser_ = (
            --         strstr(custom_str, R"("sams_id":")") != nullptr
            --     && 	strstr(custom_str, R"("sams_client_id":")") != nullptr
            api.nvim_create_autocmd('FileType', {
                pattern = 'cpp',
                callback = function()
                    if vim.fn.expand('%:t') == 'AudioSystem.cpp' then
                        vim.treesitter.stop()
                    end
                end
            })
        end,
        -- enabled = not require('global').is_windows
    },
    -- 'HiPhish/nvim-ts-rainbow2',
}
