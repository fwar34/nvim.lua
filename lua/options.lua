-- :h lua-vim-options
local global = require('global')
local opt = vim.opt
local cmd = vim.cmd

-- dirvish 不能设置 autochdir
opt.autochdir = true
-- 可以在normal,visual模式使用鼠标
opt.mouse:append('a')
-- vim.opt.mouse = 'a'
opt.splitright = true
-- 相对行号
-- opt.relativenumber = true
opt.number = true
opt.cursorline = true
-- tab设置
-- Tab键的宽度
opt.tabstop = 4
-- 统一缩进为4
opt.softtabstop = 4
opt.shiftwidth = 4
-- tab使用空格代替
opt.expandtab = true
-- 自动缩进
opt.autoindent = true
-- 关闭自动换行
opt.wrap = false
if not global.is_windows or global.hostname ~= 'A120325' then
  -- 非 Windows 上面才打开系统剪贴板，F10 是触发快捷键
  opt.clipboard:append('unnamedplus')
  vim.g.IsWin32yankActive = true
end

if global.is_windows then
  -- Windows 上面设置 win32yank
  vim.g.clipboard = {
    name = 'win32yank',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = 0
  }

  if global.hostname == 'A120325' then
    vim.g.IsWin32yankActive = false
  end
end
opt.ignorecase = true
opt.smartcase = true
-- vim 自身命令行模式智能补全
opt.wildmenu = true
-- 高亮dos的特殊符号,如^M
opt.fileformats = 'unix,dos,mac'
opt.wildignorecase = true
opt.pastetoggle = '<F9>'
-- 禁止光标闪烁
-- cmd('set gcr=a:block-blinkon0')
opt.hidden = true
-- 打开这个在非 tmux 中背景是蓝色的，所以只在 tmux 中设置
if vim.env.TMUX ~= nil or vim.env.ALACRITTY_LOG ~= nil then
  -- cmd('set termguicolors')
  opt.termguicolors = true
end
opt.signcolumn = 'yes'
-- opt.shortmess = 'atcI'
opt.shortmess = 'IfilnxtToOF'
-- opt.shortmess:append('I')

-- 输入的命令显示出来，看的清楚些
-- cmd('set showcmd')
-- 内部工作编码
opt.encoding = 'utf-8'
-- 文件默认编码
opt.fileencoding = 'utf-8'
-- 打开文件时自动尝试下面顺序的编码
-- cmd('set fileencodings=utf-8,chinese,latin-1')
cmd('set fileencodings=ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1')
-- 设置当文件被改动时自动载入
cmd('set autoread')
cmd('set completeopt=menu,menuone,noselect,noinsert,preview')
-- 终端下可以和windows共享clipboard
-- 可以看 h: provide-clipboard，里面有详细说明，以及不同工具下的共享 clipboard，比如 lemonade 和 doitclient
-- https://www.zhihu.com/question/51838774/answer/128467453
-- cmd('set clipboard+=unnamedplus')
cmd('set nobackup')
cmd('set nowritebackup')
cmd('set autowrite')
-- 不显示模式N/I/V
cmd('set noshowmode')
-- 打开状态栏标尺
cmd('set ruler')
-- 在处理未保存或只读文件的时候，弹出确认
cmd('set confirm')
-- 自动缩进
-- cmd('set autoindent')
-- 智能的选择对起方式
cmd('set smartindent')
-- C的对齐
cmd('set cindent')
cmd('set cinoptions=g0,(0,W4,l1,N-s,E-s,t0,j1,J1')
-- tab使用空格代替
-- cmd('set expandtab')
-- 在行和段开始处使用制表符
cmd('set smarttab')
cmd('set noswapfile')
-- 保存 undo 历史。必须先行创建 .undo_history/
-- cmd('set undodir=~/.undo_history/')
cmd('set undofile')
cmd('set hlsearch')
cmd('set incsearch')
-- 行内替换
cmd('set gdefault')
-- 字符间插入的像素行数目
cmd('set linespace=1')
-- 使回格键（backspace）正常处理indent, eol, start等
cmd('set backspace=indent,eol,start')
-- 允许backspace和光标键跨越行边界
cmd('set whichwrap+=,h,l,<,>,[,],~')
cmd('set selection=exclusive')
cmd('set selectmode=mouse,key')
-- 通过使用: commands命令，告诉我们文件的哪一行被改变过
cmd('set report=0')
-- 光标移动到buffer的顶部和底部时保持1行距离
cmd('set scrolloff=1')
cmd('set sidescrolloff=5')
-- 设置环境保存项
-- cmd('set sessionoptions=blank,buffers,curdir,folds,globals,help,localoptions,options,resize,tabpages,winpos,winsize')
-- cmd('set number')
-- Tab键的宽度
-- cmd('set tabstop=4')
-- 统一缩进为4
-- cmd('set softtabstop=4')
-- cmd('set shiftwidth=4')
-- cmd('set cmdheight=2')

cmd('set updatetime=300')

-- cmd('set ignorecase')
-- cmd('set smartcase')
-- Windows 禁用 ALT 操作菜单（使得 ALT 可以用到 Vim里）
cmd("set winaltkeys=no")
-- 关闭自动换行
-- cmd('set nowrap')
-- 打开功能键超时检测（终端下功能键为一串 ESC 开头的字符串）
cmd('set ttimeout')
-- 功能键超时检测 50 毫秒
-- cmd('set ttimeoutlen=50')
-- 允许 Vim 自带脚本根据文件类型自动设置缩进等
cmd('filetype plugin indent on')
-- 语法高亮设置
cmd('syntax enable')
cmd('syntax on')
-- 显示最后一行
cmd('set display=lastline')
-- 延迟绘制（提升性能）
-- cmd('set lazyredraw')
-- 错误格式
cmd('set errorformat+=[%f:%l]\\ ->\\ %m,[%f:%l]:%m')
-- 设置分隔符可视
cmd('set listchars=tab:\\|\\ ,trail:.,extends:>,precedes:<')
-- 设置 tags：当前文件所在目录往上向根目录搜索直到碰到 .tags 文件
-- 或者 Vim 当前目录包含 .tags 文件
cmd('set tags=./.tags;,.tags')
-- 如遇Unicode值大于255的文本，不必等到空格再折行
cmd('set formatoptions+=m')
-- 合并两行中文时，不在中间加空格
cmd('set formatoptions+=B')
-- 允许代码折叠
cmd('set foldenable')
-- 代码折叠默认使用缩进
cmd('set foldmethod=indent')
-- 默认打开所有缩进
cmd('set foldlevel=99')

-- cmd('set wildignore=*.so,*.swp,*.zip,*.exe,.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**,**/debian/**')
-- 文件搜索和补全时忽略下面扩展名
cmd('set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class')
cmd('set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib') -- stuff to ignore when tab completing
cmd('set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex')
cmd('set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz') -- MacOSX/Linux
cmd('set wildignore+=*DS_Store*,*.ipch')
cmd('set wildignore+=*.gem')
cmd('set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso')
cmd('set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**')
cmd('set wildignore+=*/.nx/**,*.app,*.git,.git')
cmd('set wildignore+=*.wav,*.mp3,*.ogg,*.pcm')
cmd('set wildignore+=*.mht,*.suo,*.sdf,*.jnlp')
cmd('set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf')
cmd('set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc')
cmd('set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps')
cmd('set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu')
cmd('set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc')
cmd('set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android')
-- 设置显示制表符等隐藏字符
cmd('set list')
