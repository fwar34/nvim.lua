return {
    {
        'iamcco/markdown-preview.nvim',
        -- 在 windows 上面可能安装失败，需要手动去目录里面安装
        build = 'cd app && yarn install',
        ft = 'markdown',
    },
    {
        'toppair/peek.nvim',
        build = 'deno task --quiet build:fast',
        ft = 'markdown'
    }
}
