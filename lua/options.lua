local global = require('global')

local function load_option()
    -- 可以在normal,visual模式使用鼠标
    -- vim.o.mouse = 'nv'
    vim.o.autochdir = true
    -- vim 自身命令行模式智能补全
    vim.o.wildmenu = true
    -- 高亮dos的特殊符号,如^M     
    vim.o.fileformats = 'unix,dos,mac'
    vim.o.wildignorecase = true
    vim.o.wildignore = '*.so,*.swp,*.zip,*.exe,.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**'
    vim.o.pastetoggle = '<F9>'
    -- 禁止光标闪烁
    vim.o.gcr = 'a:block-blinkon0'
    vim.o.termguicolors = true
    vim.o.shortmess = 'atI'
    vim.o.number = true
    vim.o.linebreak = true
    vim.o.breakat = [[\ \      ;:,!?]]
    -- 输入的命令显示出来，看的清楚些
    vim.o.showcmd = true
    -- 允许折叠
    vim.o.foldenable = true
    -- 手动折叠
    vim.o.foldmethod = 'manual'
    -- vim.o.fileencodings = 'utf-8,ucs-bom,cp936'
    -- 设置当文件被改动时自动载入
    vim.o.autoread = true
    vim.o.completeopt = 'menu,menuone,noselect,noinsert'
    -- vim.o.clipboard = 'unnamedplus'
    print(vim.o.clipboard)
    vim.o.backup = false
    vim.o.writebackup = false
    vim.o.showmode = true
    vim.o.autowrite = true
    -- 打开状态栏标尺
    vim.o.ruler = true
    -- 突出显示当前行
    -- vim.o.cursorline = true
    vim.o.magic = true
    -- 在处理未保存或只读文件的时候，弹出确认
    vim.o.confirm = true
    -- 自动缩进
    vim.o.autoindent = true
    -- 智能的选择对起方式
    vim.o.smartindent = true
    -- Tab键的宽度
    vim.o.tabstop = 4
    -- 统一缩进为4
    vim.o.softtabstop = 4
    vim.o.shiftwidth = 4
    -- C的对齐
    vim.o.cindent = true
    vim.o.cinoptions = 'g0,(0,W4,l1,N-s,E-s,t0,j1,J1'
    -- tab使用空格代替
    vim.o.expandtab = true
    -- 在行和段开始处使用制表符
    vim.o.smarttab = true
    vim.o.swapfile = false
    -- 保存 undo 历史。必须先行创建 .undo_history/
    vim.o.undodir = vim.fn.expand('~/.undo_history/')
    vim.o.undofile = true
    vim.o.hlsearch = true
    vim.o.incsearch = true
    -- 行内替换
    vim.o.gdefault = true
    -- 字符间插入的像素行数目
    vim.o.linespace = 1
    -- 使回格键（backspace）正常处理indent, eol, start等
    vim.o.backspace = 'indent,eol,start'
    -- 允许backspace和光标键跨越行边界
    vim.o.whichwrap = vim.o.whichwrap .. ',h,l,<,>,[,],~'
    vim.o.selection = 'exclusive'
    vim.o.selectmode = 'mouse,key'
    -- 通过使用: commands命令，告诉我们文件的哪一行被改变过
    vim.o.report = 0
    -- 光标移动到buffer的顶部和底部时保持3行距离
    vim.o.scrolloff = 3
    vim.o.sidescrolloff = 5
    -- 设置环境保存项
    vim.o.sessionoptions = 'blank,globals,localoptions,tabpages,sesdir,folds,help,options,resize,winpos,winsize,unix,slash'
end

load_option()
