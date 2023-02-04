return {
    { "folke/which-key.nvim", lazy = true },
    {'tjdevries/colorbuddy.nvim'},

    {'junegunn/fzf', build = './install --all', pin = true},
    {
        -- 需要使用最新版的 bat 来预览，可以直接在 release 页面下载
        'junegunn/fzf.vim', event = 'VimEnter *',
        config = function()
            vim.g.fzf_preview_window = { 'up:50%', 'ctrl-/' }
        end,
        -- requires = {
        --     {'junegunn/fzf', run = './install --all', lock = true},
        -- }
    }
}
