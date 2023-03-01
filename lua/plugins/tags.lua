local set = vim.keymap.set
return {
    -- Coding
    'liuchengxu/vista.vim',
    -- use {'jsfaint/gen_tags.vim', event = 'VimEnter *',}
    -- 提供 ctags/gtags 后台数据库自动更新功能
    {
        'ludovicchabant/vim-gutentags',
        config = function()
            -- " 设定项目目录标志：不在 git/svn 内的项目，需要在项目根目录 touch 一个空的 .root/.project 等文件
            vim.g.gutentags_project_root = { '.root', '.svn', '.git', '.hg', '.project' }
            local tags_cache_dir = vim.fn.expand('~/.cache/tags')
            if vim.fn.isdirectory(tags_cache_dir) == 0 then
                vim.fn.mkdir(tags_cache_dir, 'p')
            end
            vim.g.gutentags_cache_dir = tags_cache_dir
            vim.g.gutentags_ctags_tagfile = '.tags'
            -- let g:gutentags_exclude_project_root = [expand('~/.vim')]
            vim.g.gutentags_ctags_exclude = { '*/debian/*', '*.am', '*.sh', 'makefile', 'Makefile', '*.html', '*.thrift', '*/doxygen-doc/*' }

            if vim.fn.executable('gtags-cscope') and vim.fn.executable('gtags') then
                vim.g.gutentags_modules = { 'ctags', 'gtags_cscope' }
            end

            -- " 如果使用 universal ctags 需要增加下面两行
            -- " Universal Ctags support Wildcard in options.
            -- vim.g.gutentags_ctags_extra_args = { '--fields=*', '--extras=*', '--kinds-all=*', '--output-format=e-ctags' }

            -- " change focus to quickfix window after search (optional).
            vim.g.gutentags_plus_switch = 1

            -- " 禁用 gutentags 自动加载 gtags 数据库的行为
            vim.g.gutentags_auto_add_gtags_cscope = 0

            -- " 错误排查：gutentags: gutentags: gtags-cscope job failed, returned: 1
            -- "这是因为 gutentags 调用 gtags 时，gtags 返回了错误值 1，具体是什么情况，
            -- "需要进一步打开日志，查看 gtags 的错误输出：
            vim.g.gutentags_define_advanced_commands = 1
            -- "先在 vimrc 中添加上面这一句话，允许 gutentags 打开一些高级命令和选项。
            -- "然后打开你出错的源文件，运行 “:GutentagsToggleTrace”命令打开日志，
            -- "然后保存一下当前文件，触发 gtags 数据库更新，接下来你应该能看到一些讨厌的日志输出，
            -- "这里不够的话，~/.cache/tags 目录下还有对应项目名字的 log 文件，
            -- "ægs 具体输出了什么，然后进行相应的处理。

            -- "输出trace信息
            -- vim.g.gutentags_trace = 1
            vim.api.nvim_create_user_command('GutentagsToggleTrace', function()
                vim.g.gutentags_trace = not vim.g.gutentags_trace
            end, {})
        end
    },
    {
        -- 提供 GscopeFind 命令并自动处理好 gtags 数据库切换
        -- 支持光标移动到符号名上：<leader>cg 查看定义，<leader>cs 查看引用
        'skywind3000/gutentags_plus',
        enabled = false,
        init = function ()
            vim.g.gutentags_plus_nomap = 1
        end,
        config = function()
            -- " and define your new maps:
            -- " 0 or s: Find this symbol
            -- " 1 or g: Find this definition
            -- " 2 or d: Find functions called by this function
            -- " 3 or c: Find functions calling this function
            -- " 4 or t: Find this text string
            -- " 6 or e: Find this egrep pattern
            -- " 7 or f: Find this file
            -- " 8 or i: Find files #including this file
            -- " 9 or a: Find places where this symbol is assigned a value
            -- " z: Find current word in ctags database
            -- " You can disable the default keymaps by:
            set({ 'n', 'v' }, '<Leader>hs', ':GscopeFind s <C-R><C-W><CR>', { desc = 'Find this symbol' })
            set({ 'n', 'v' }, '<Leader>hg', ':GscopeFind g <C-R><C-W><CR>', { desc = 'Find this definition' })
            set({ 'n', 'v' }, '<Leader>hc', ':GscopeFind c <C-R><C-W><CR>', { desc = 'Find functions calling this function' })
            set({ 'n', 'v' }, '<Leader>ht', ':GscopeFind t <C-R><C-W><CR>', { desc = 'Find this text string' })
            set({ 'n', 'v' }, '<Leader>he', ':GscopeFind e <C-R><C-W><CR>', { desc = 'Find this egrep pattern' })
            set({ 'n', 'v' }, '<Leader>hf', ':GscopeFind f <C-R>=expand("<cfile>")<CR><CR>', { desc = 'Find this file' })
            set({ 'n', 'v' }, '<Leader>hi', ':GscopeFind i <C-R>=expand("<cfile>")<CR><CR>', { desc = 'Find files #including this file' })
            set({ 'n', 'v' }, '<Leader>hd', ':GscopeFind d <C-R><C-W><CR>', { desc = 'Find functions called by this function' })
            set({ 'n', 'v' }, '<Leader>ha', ':GscopeFind a <C-R><C-W><CR>', { desc = 'Find places where this symbol is assigned a value' })
            set({ 'n', 'v' }, '<Leader>hz', ':GscopeFind z <C-R><C-W><CR>', { desc = 'Find current word in ctags database' })
        end
    },
}
