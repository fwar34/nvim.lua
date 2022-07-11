-- :h lua-vim-options
local opt = vim.opt

-- dirvish 不能设置 autochdir
opt.autochdir = true
-- 可以在normal,visual模式使用鼠标
vim.opt.mouse = 'a'
opt.splitright = true
-- 相对行号
opt.relativenumber = true
opt.cursorline = true
-- vim 自身命令行模式智能补全
opt.wildmenu = true
-- 高亮dos的特殊符号,如^M
opt.fileformats = 'unix,dos,mac'
opt.wildignorecase = true
opt.pastetoggle = '<F9>'
-- 禁止光标闪烁
-- vim.cmd('set gcr=a:block-blinkon0')
opt.hidden = true
-- 打开这个在非 tmux 中背景是蓝色的，所以只在 tmux 中设置
if vim.env.TMUX ~= nil or vim.env.ALACRITTY_LOG ~= nil then
    -- vim.cmd('set termguicolors')
    opt.termguicolors = true
end
opt.shortmess = 'atcI'

-- 输入的命令显示出来，看的清楚些
-- vim.cmd('set showcmd')
-- 内部工作编码
opt.encoding = 'utf-8'
-- 文件默认编码
opt.fileencoding = 'utf-8'
-- 打开文件时自动尝试下面顺序的编码
-- vim.cmd('set fileencodings=utf-8,chinese,latin-1')
vim.cmd('set fileencodings=ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1')
-- 设置当文件被改动时自动载入
vim.cmd('set autoread')
vim.cmd('set completeopt=menu,menuone,noselect,noinsert,preview')
-- 终端下可以和windows共享clipboard
-- 可以看 h: provide-clipboard，里面有详细说明，以及不同工具下的共享 clipboard，比如 lemonade 和 doitclient
-- https://www.zhihu.com/question/51838774/answer/128467453
vim.cmd('set clipboard+=unnamedplus')
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
-- 设置这个选项与 neovim-session-manager 冲突
-- vim.cmd('set sessionoptions=blank,globals,localoptions,tabpages,folds,help,options,resize,winpos,winsize,unix,slash') 
vim.cmd('set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal')
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
-- Windows 禁用 ALT 操作菜单（使得 ALT 可以用到 Vim里）
vim.cmd("set winaltkeys=no")
-- 关闭自动换行
vim.cmd('set nowrap')
-- 打开功能键超时检测（终端下功能键为一串 ESC 开头的字符串）
vim.cmd('set ttimeout')
-- 功能键超时检测 50 毫秒
vim.cmd('set ttimeoutlen=50')
-- 允许 Vim 自带脚本根据文件类型自动设置缩进等
vim.cmd('filetype plugin indent on')
-- 语法高亮设置
vim.cmd('syntax enable')
vim.cmd('syntax on')
-- 显示最后一行
vim.cmd('set display=lastline')
-- 延迟绘制（提升性能）
vim.cmd('set lazyredraw')
-- 错误格式
vim.cmd('set errorformat+=[%f:%l]\\ ->\\ %m,[%f:%l]:%m')
-- 设置分隔符可视
vim.cmd('set listchars=tab:\\|\\ ,trail:.,extends:>,precedes:<')
-- 设置 tags：当前文件所在目录往上向根目录搜索直到碰到 .tags 文件
-- 或者 Vim 当前目录包含 .tags 文件
vim.cmd('set tags=./.tags;,.tags')
-- 如遇Unicode值大于255的文本，不必等到空格再折行
vim.cmd('set formatoptions+=m')
-- 合并两行中文时，不在中间加空格
vim.cmd('set formatoptions+=B')
-- 允许代码折叠
vim.cmd('set foldenable')
-- 代码折叠默认使用缩进
vim.cmd('set fdm=indent')
-- 默认打开所有缩进
vim.cmd('set foldlevel=99')

-- vim.cmd('set wildignore=*.so,*.swp,*.zip,*.exe,.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**,**/debian/**')
-- 文件搜索和补全时忽略下面扩展名
vim.cmd('set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class')
vim.cmd('set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib') -- stuff to ignore when tab completing
vim.cmd('set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex')
vim.cmd('set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz') -- MacOSX/Linux
vim.cmd('set wildignore+=*DS_Store*,*.ipch')
vim.cmd('set wildignore+=*.gem')
vim.cmd('set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso')
vim.cmd('set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**')
vim.cmd('set wildignore+=*/.nx/**,*.app,*.git,.git')
vim.cmd('set wildignore+=*.wav,*.mp3,*.ogg,*.pcm')
vim.cmd('set wildignore+=*.mht,*.suo,*.sdf,*.jnlp')
vim.cmd('set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf')
vim.cmd('set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc')
vim.cmd('set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps')
vim.cmd('set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu')
vim.cmd('set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc')
vim.cmd('set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android')
-- 设置显示制表符等隐藏字符
vim.cmd('set list')
