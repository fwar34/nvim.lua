local global = require('global')
-- local options = {global_options = {}, window_options = {}, buffer_options = {}}
local options = setmetatable({}, {__index = {global_options = {}, window_options = {}, buffer_options = {}}})

function options:load_options()
	self.global_options = {
		autochdir = true,
		-- 可以在normal,visual模式使用鼠标
		-- mouse = 'nv'
		-- vim 自身命令行模式智能补全
		wildmenu = true,
		-- 高亮dos的特殊符号,如^M     
		fileformats = 'unix,dos,mac',
		wildignorecase = true,
		wildignore = '*.so,*.swp,*.zip,*.exe,.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**',
		pastetoggle = '<F9>',
		-- 禁止光标闪烁
		gcr = 'a:block-blinkon0',
		termguicolors = true,
		shortmess = 'atI',
		--linebreak = true,
		--breakat = [[\ \      ;:,!?]],
		-- 输入的命令显示出来，看的清楚些
		showcmd = true,
		-- 允许折叠
		-- foldenable = true,
		-- 手动折叠
		-- foldmethod = 'manual',
		-- fileencodings = 'utf-8,ucs-bom,cp936'
		-- 设置当文件被改动时自动载入
		autoread = true,
		completeopt = 'menu,menuone,noselect,noinsert,preview',
		-- clipboard = 'unnamedplus'
		backup = false,
		writebackup = false,
		showmode = true,
		autowrite = true,
		-- 打开状态栏标尺
		ruler = true,
		-- 突出显示当前行
		-- cursorline = true
		magic = true,
		-- 在处理未保存或只读文件的时候，弹出确认
		confirm = true,
		-- 自动缩进
		autoindent = true,
		-- 智能的选择对起方式
		smartindent = true,
		-- C的对齐
		cindent = true,
		cinoptions = 'g0,(0,W4,l1,N-s,E-s,t0,j1,J1',
		-- tab使用空格代替
		expandtab = true,
		-- 在行和段开始处使用制表符
		smarttab = true,
		swapfile = false,
		-- 保存 undo 历史。必须先行创建 .undo_history/
		undodir = vim.fn.expand('~/.undo_history/'),
		undofile = true,
		hlsearch = true,
		incsearch = true,
		-- 行内替换
		gdefault = true,
		-- 字符间插入的像素行数目
		linespace = 1,
		-- 使回格键（backspace）正常处理indent, eol, start等
		backspace = 'indent,eol,start',
		-- 允许backspace和光标键跨越行边界
		whichwrap = vim.o.whichwrap .. ',h,l,<,>,[,],~',
		selection = 'exclusive',
		selectmode = 'mouse,key',
		-- 通过使用: commands命令，告诉我们文件的哪一行被改变过
		report = 0,
		-- 光标移动到buffer的顶部和底部时保持3行距离
		scrolloff = 3,
		sidescrolloff = 5,
		-- 设置环境保存项
		sessionoptions = 'blank,globals,localoptions,tabpages,sesdir,folds,help,options,resize,winpos,winsize,unix,slash',
	}

	self.window_options = {
		number = true,
		-- vim.cmd('set number')
	}

	self.buffer_options = {
		-- Tab键的宽度
		tabstop = 4,
		-- 统一缩进为4
		softtabstop = 4,
		shiftwidth = 4,
	}

	for k, v in pairs(self.global_options) do
		-- global.dump(vim.o[k])
		vim.o[k] = v
	end

	for k, v in pairs(self.window_options) do
		vim.wo[k] = v
	end

	for k, v in pairs(self.buffer_options) do
		vim.bo[k] = v
	end
end

return options
