return {
    -- Status line
    {
        'ojroques/vim-scrollstatus',
        config = function()
            vim.g.scrollstatus_size = 12
            vim.g.scrollstatus_symbol_track = '-'
            vim.g.scrollstatus_symbol_bar = '#'
        end
    },

    -- Status line
    'itchyny/lightline.vim',
    -- 'glepnir/spaceline.vim'
}
