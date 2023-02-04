return {
    -- Git
    {'rhysd/git-messenger.vim', lazy = true, cmd = 'GitMessenger'},
    {'tpope/vim-fugitive', event = 'VimEnter *',},
	{
        'mhinz/vim-signify',
        config = function()
            -- hunk text object
            vim.cmd [[omap ic <plug>(signify-motion-inner-pending)]]
            vim.cmd [[xmap ic <plug>(signify-motion-inner-visual)]]
            vim.cmd [[omap ac <plug>(signify-motion-outer-pending)]]
            vim.cmd [[xmap ac <plug>(signify-motion-outer-visual)]]

            -- When you jump to a hunk, show "[Hunk 2/15]" by putting this in your vimrc:
            function _G.show_hunk()
                local h = vim.api.nvim_eval('sy#util#get_hunk_stats()')
                -- print(vim.inspect(vim.tbl_keys(h)[1]))
                -- print(type(vim.tbl_keys(h)[1]))
                if type(h) == 'table' and type(vim.tbl_keys(h)[1]) == 'string' then
                    print(string.format('[Hunk %d/%d]', h.current_hunk, h.total_hunks))
                end
            end
            vim.cmd [[autocmd! User SignifyHunk lua _G.show_hunk()]]
        end
    },
}
