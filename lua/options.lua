local options = {}
local vim = vim

function options.load_options()
    vim.cmd('set autochdir')
    -- 可以在normal,visual模式使用鼠标
    vim.cmd('set mouse=')
    vim.cmd('set splitright')
    -- 相对行号
    -- vim.cmd('set relativenumber')
    -- vim.cmd('set cursorline')
    -- vim 自身命令行模式智能补全
    vim.cmd('set wildmenu')
    -- 高亮dos的特殊符号,如^M
    vim.cmd('set fileformats=unix,dos,mac')
    vim.cmd('set wildignorecase')
    vim.cmd('set wildignore=*.so,*.swp,*.zip,*.exe,.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**,**/debian/**')
    vim.cmd('set pastetoggle=<F9>')
    -- 禁止光标闪烁
    vim.cmd('set gcr=a:block-blinkon0')
    vim.cmd('set hidden')
    vim.cmd('set termguicolors')
    vim.cmd('set shortmess=atcI')
    -- 输入的命令显示出来，看的清楚些
    -- vim.cmd('set showcmd')
    vim.cmd('set encoding=utf-8')
    vim.cmd('set fileencodings=utf-8,chinese,latin-1')
    vim.cmd('set fileencoding=utf-8')
    -- 设置当文件被改动时自动载入
    vim.cmd('set autoread')
    vim.cmd('set completeopt=menu,menuone,noselect,noinsert,preview')
    -- 终端下可以和windows共享clipboard
    -- vim.cmd('set clipboard=unnamedplus')
    vim.cmd('set nobackup')
    vim.cmd('set nowritebackup')
    vim.cmd('set autowrite')
    -- 不显示模式N/I/V
    vim.cmd('set noshowmode')
    -- 打开状态栏标尺
    vim.cmd('set ruler')
    -- 在处理未保存或只读文件的时候，弹出确认
    vim.cmd('set confirm')
    -- 自动缩进
    vim.cmd('set autoindent')
    -- 智能的选择对起方式
    vim.cmd('set smartindent')
    -- C的对齐
    vim.cmd('set cindent')
    vim.cmd('set cinoptions=g0,(0,W4,l1,N-s,E-s,t0,j1,J1')
    -- tab使用空格代替
    vim.cmd('set expandtab')
    -- 在行和段开始处使用制表符
    vim.cmd('set smarttab')
    vim.cmd('set noswapfile')
    -- 保存 undo 历史。必须先行创建 .undo_history/
    vim.cmd('set undodir=~/.undo_history/')
    vim.cmd('set undofile')
    vim.cmd('set hlsearch')
    vim.cmd('set incsearch')
    -- 行内替换
    vim.cmd('set gdefault')
    -- 字符间插入的像素行数目
    vim.cmd('set linespace=1')
    -- 使回格键（backspace）正常处理indent, eol, start等
    vim.cmd('set backspace=indent,eol,start')
    -- 允许backspace和光标键跨越行边界
    vim.cmd('set whichwrap+=,h,l,<,>,[,],~')
    vim.cmd('set selection=exclusive')
    vim.cmd('set selectmode=mouse,key')
    -- 通过使用: commands命令，告诉我们文件的哪一行被改变过
    vim.cmd('set report=0')
    -- 光标移动到buffer的顶部和底部时保持3行距离
    vim.cmd('set scrolloff=1')
    vim.cmd('set sidescrolloff=5')
    -- 设置环境保存项
    vim.cmd('set sessionoptions=blank,globals,localoptions,tabpages,sesdir,folds,help,options,resize,winpos,winsize,unix,slash')
    vim.cmd('set number')
    -- 允许折叠
    vim.cmd('set foldenable')
    -- 手动折叠
    vim.cmd('set foldmethod=manual')
    -- Tab键的宽度
    vim.cmd('set tabstop=4')
    -- 统一缩进为4
    vim.cmd('set softtabstop=4')
    vim.cmd('set shiftwidth=4')
    -- vim.cmd('set cmdheight=2')

    vim.cmd('set updatetime=300')

    vim.cmd('set ignorecase')
    vim.cmd('set smartcase')
end

return options
