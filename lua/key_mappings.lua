-- key_mappings
local global = require('global')

local key_mappings = {}
local key_map = {}

function key_map:new()
    local instance = {
        mode = '',
        lhs = '',
        rhs = '',
        options = {
            noremap = true,
            silent = true
        }
    }
    setmetatable(instance, self)
    self.__index = self
    return instance
end

function key_map:process()
    vim.api.nvim_set_keymap(self.mode, self.lhs, self.rhs, self.options)
end

local function create_keymap(key, value)
    local keymap = key_map:new()
    keymap.mode, keymap.lhs = key:match('([^|]*)|?(.*)')
    if (type(value) == 'table') then
        keymap.rhs = value[1]
        if value[2] ~= nil then
            keymap.options.noremap = value[2]
        end
        if value[3] ~= nil then
            keymap.options.silent = value[3]
        end
    else
        keymap.rhs = value
    end

    return keymap
end

function key_mappings:process_keys()
    for _, v in pairs(self) do
        if (type(v) == 'table') then
            for ki, vi in pairs(v) do
                local keymap = create_keymap(ki, vi)
                keymap:process()
            end
        end
    end
end

function rg_options()
    -- return { "--glob !tags", "--glob !nvim/snippets/**", }
    return {
        "--iglob",
        "!tags",
        "--iglob",
        "!*.lo",
        "--iglob",
        "!*.makefile",
        "--iglob",
        "!*.html",
        "--iglob",
        "!*.svn/*",
        "--iglob",
        "!*.git/*",
    }
end

function _G.search_word2()
    vim.cmd('normal ye')
    return vim.fn.getreg('0')
end

function _G.move_cursor(direction)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local col
    if direction == 'left' then
        col = cursor[2] == 0 and 0 or cursor[2] - 1
    else
        col = cursor[2] + 1
    end
    vim.api.nvim_win_set_cursor(0, {cursor[1], col})
end

find_files_args = {
    "rg", "--ignore", "--hidden", "--files","--iglob","!*.svn","--iglob","!*.git","--iglob","!*.deps","--iglob","!*.o","--iglob","!*.a",
    "--iglob","!*.pyc",
}

function key_mappings:start()
    self.normal = {
        ['n|<Leader>zz'] = '<CMD>w<CR>',
        ['n|<Leader>fd'] = '<CMD>echo expand("%:p")<CR>',
        ['n|<Leader>a'] = '^',
        ['n|<Leader>e'] = '$',
        ['n|<Leader>xx'] = '<CMD>nohl<CR><CMD>Hi //<CR><CMD>Hi :clear<CR>',
        ['n|<Leader><TAB>'] = '<C-w><C-w>',
        ['n|<Leader>do'] = '<CMD>on<CR>',
        ['n|<Leader>dm'] = '<CMD>delmarks!<CR>',
        ['n|<Leader>kb'] = '<CMD>bdel<CR>',
        ['n|<Space><Space>'] = {':', true},
        ['n|<Leader>bb'] = '<C-^>',
        ['n|<LocalLeader>lm'] = '<CMD>lua require("futil").toggle_line_number()<CR>',
        ['n|<LocalLeader>qq'] = '<CMD>q<CR>',
        ['n|<LocalLeader>qa'] = '<CMD>qa<CR>',
        ['n|Y'] = 'y$',
        ['n|<F12>'] = '<CMD>lua require("futil").toggle_mouse()<CR>',
        ['n|<Leader>ia'] = 'm`A;<Esc>``',
        ['n|<Leader>yy'] = "m`y'a``",
        ['n|<Leader>dd'] = "d'a",
        ['n|<Leader>qf'] = '<CMD>copen<CR>',
        ['n|<Leader>mf'] = '<CMD>lua require("futil").make_fennel()<CR>',
        -- ['n|<Leader>cs'] = '<CMD>lua require("mylib").coc_status()<CR>',
        ['n|<LocalLeader>fn'] = '<CMD>lua require("futil").display_function()<CR>',
        ['n|<LocalLeader>do'] = '<CMD>lua require("futil").delete_other_buffers()<CR>',
        ['n|<C-g>'] = '<C-c>',
        ['n|<Leader>md'] = '<CMD>m .+1<CR>',
        ['n|<Leader>mu'] = '<CMD>m .-2<CR>',
        ['n|<Leader>mm'] = '%',
        ['n|ge'] = 'G',
        -- help motion.txt
        -- If your '{' or '}' are not in the first column, and you would like to use "[["
        -- and "]]" anyway, try these mappings: >
        -- ['n|[['] = {'?{<CR>w99[{'},
        -- ['n|]['] = {'/}<CR>b99]}'},
        -- ['n|]]'] = {'j0[[%/{<CR>'},
        -- ['n|[]'] = {'k$][%?}<CR>'},
        -- ['n|<Leader>cs'] = '<CMD>lua require("mylib").
    }

    self.visual = {
        ['v|<Leader>g'] = '<C-c>',
        ['v|<C-g>'] = '<C-c>',
        ["v|>"] = ">gv",
        ["v|<"] = "<gv",
        -- Move selected line / block of text in visual mode
        ["v|K"] = "<CMD>move '<-2<CR>gv-gv",
        ["v|J"] = "<CMD>move '>+1<CR>gv-gv",
        ['v|<Leader>mm'] = '%',
    }

    self.insert = {
        ['i|<Leader>g'] = '<C-c>',
        ['i|<Leader>O'] = '<C-o>O',
        ['i|<Leader>o'] = '<C-o>o',
        ['i|<Leader>zz'] = '<Esc><CMD>w<CR>a',
        -- ['i|<C-b>'] = '<Left>',
        -- ['i|<C-f>'] = '<Right>',
        ['i|<C-b>'] = '<CMD>lua _G.move_cursor("left")<CR>',
        ['i|<C-f>'] = '<CMD>lua _G.move_cursor("right")<CR>',
        ['i|<C-a>'] = '<Esc>I',
        ['i|<C-e>'] = '<End>',
        -- ['i|<C-g>'] = '<C-c>',
        ['i|<C-j>'] = '<Down>',
        ['i|<C-k>'] = '<Up>',
        ['i|<C-d>'] = '<Del>',
    }

    self.terminal = {
        ['t|<F12>'] = '<CMD>lua require("futil").toggle_mouse()<CR>',
    }

    self.command = {
        ['c|<C-g>'] = '<C-c>',
        -- 下面的四个必须有 silent，不能在echo中显示东西
        ['c|<C-a>'] = {'<Home>', true, false},
        ['c|<C-e>'] = {'<End>', true, false},
        ['c|<C-b>'] = {'<Left>', true, false},
        ['c|<C-f>'] = {'<Right>', true, false},
    }

    -- fzf.vim key mappings
    self.fzfvim = {
        -- ['n|<Leader>fa'] = {'<CMD>Ag<CR>', true},
        -- ['n|<Leader>fw'] = ':Ag <C-R>=expand("<cword>")<CR><CR>',
        -- ['n|<Leader>fs'] = '<CMD>lua require("mylib")["search_word"]()<CR>',
        -- ['n|<Leader>fs'] = '<CMD>lua require("futil").search_word()<CR>',
        -- ['n|<Leader>fg'] = '<CMD>Rg<CR>',
        ['n|<LocalLeader>ff'] = '<CMD>FZF ~<CR>',
        -- ['n|<Leader>rm'] = '<CMD>History<CR>',
        -- ['n|<Leader>ch'] = '<CMD>History:<CR>',
        -- ['n|<Leader>sh'] = '<CMD>History/<CR>',
        -- ['n|<Leader>li'] = '<CMD>BLines<CR>',
        -- ['n|<Leader>bs'] = '<CMD>Buffers<CR>',
        -- ['n|<Leader>gf'] = '<CMD>GFiles<CR>',
        -- ['n|<Leader>ma'] = '<CMD>Marks<CR>',
        -- ['n|<Leader>cc'] = '<CMD>Commands<CR>',
        -- ['n|<Leader>mp'] = '<CMD>Maps<CR>',
        -- ['n|<Leader>hl'] = '<CMD>Helptags<CR>',
        -- ['n|<Leader>tg'] = '<CMD>Tags<CR>',
        -- ['n|<Leader>ii'] = '<CMD>BTags<CR>',
    }

    -- Leaderf key mappings
    -- self.Leaderf = {
    --     ['n|<LocalLeader>ff'] = '<CMD>Leaderf file<CR>',
    --     ['n|<LocalLeader>fa'] = '<CMD>Leaderf rg<CR>',
    --     ['n|<LocalLeader>fw'] = ':Leaderf rg <C-R>=expand("<cword>")<CR><CR>',
    --     ['n|<LocalLeader>fs'] = '<CMD>lua require("mylib")["search_word"]()<CR>',
    --     -- ['n|<LocalLeader>fs'] = '<CMD>lua require("futil").search_word()<CR>',
    --     ['n|<LocalLeader>rm'] = '<CMD>Leaderf mru<CR>',
    --     ['n|<LocalLeader>ch'] = '<CMD>Leaderf cmdHistory<CR>',
    --     ['n|<LocalLeader>sh'] = '<CMD>Leaderf searchHistory<CR>',
    --     ['n|<LocalLeader>li'] = '<CMD>Leaderf line<CR>',
    --     ['n|<LocalLeader>bs'] = '<CMD>Leaderf buffer<CR>',
    --     -- ['n|<LocalLeader>gf'] = '<CMD>GFiles<CR>',
    --     -- ['n|<LocalLeader>ma'] = '<CMD>Marks<CR>',
    --     ['n|<LocalLeader>cc'] = '<CMD>Leaderf command<CR>',
    --     -- ['n|<LocalLeader>mp'] = '<CMD>Maps<CR>',
    --     ['n|<LocalLeader>hp'] = '<CMD>Leaderf help<CR>',
    --     ['n|<LocalLeader>tg'] = '<CMD>Leaderf tag<CR>',
    --     ['n|<LocalLeader>bg'] = '<CMD>Leaderf bufTag<CR>',
    --     ['n|<LocalLeader>ii'] = '<CMD>Leaderf function<CR>',
    --     ['n|<LocalLeader>qf'] = '<CMD>Leaderf quickfix<CR>',
    --     ['n|<LocalLeader>ll'] = '<CMD>Leaderf loclist<CR>',
    --     ['n|<LocalLeader>gt'] = '<CMD>Leaderf gtags<CR>',
    -- }

    -- Clap
    -- self.clap = {
    --     ['n|<Leader>cl'] = '<CMD>Clap<CR>',
    --     ['n|<Leader>li'] = '<CMD>Clap blines<CR>',
    --     ['n|<Leader>bs'] = '<CMD>Clap buffers<CR>',
    --     ['n|<Leader>co'] = '<CMD>Clap colors<CR>',
    --     ['n|<Leader>cm'] = '<CMD>Clap command<CR>',
    --     ['n|<Leader>ch'] = '<CMD>Clap command_history<CR>',
    --     ['n|<Leader>sh'] = '<CMD>Clap search_history<CR>',
    --     ['n|<Leader>ff'] = '<CMD>Clap files<CR>',
    --     -- ['n|<Leader>fw'] = '<CMD>Leaderf rg <C-R>=expand("<cword>")<CR><CR>',
    --     -- ['n|<Leader>fs'] = '<CMD>lua require("mylib")["search_word"]()<CR>',
    --     -- ['n|<Leader>ii'] = '<CMD>Clap function<CR>',
    --     ['n|<Leader>gf'] = '<CMD>Clap git_files<CR>',
    --     ['n|<Leader>rm'] = '<CMD>Clap history<CR>',
    --     ['n|<Leader>hp'] = '<CMD>Clap help_tags<CR>',
    --     ['n|<Leader>jj'] = '<CMD>Clap jumps<CR>',
    --     ['n|<Leader>ma'] = '<CMD>Clap marks<CR>',
    --     ['n|<Leader>mp'] = '<CMD>Clap maps<CR>',
    --     ['n|<Leader>qf'] = '<CMD>Clap quickfix<CR>',
    --     ['n|<Leader>ll'] = '<CMD>Clap loclist<CR>',
    --     ['n|<Leader>fa'] = '<CMD>Clap grep2<CR>',
    --     ['n|<Leader>fm'] = '<CMD>Clap grep<CR>',
    --     ['n|<Leader>ra'] = '<CMD>Clap registers<CR>',
    --     ['n|<Leader>bt'] = '<CMD>Clap tags<CR>',
    --     ['n|<Leader>pt'] = '<CMD>Clap proj_tags<CR>',
    --     ['n|<Leader>yk'] = '<CMD>Clap yanks<CR>',
    --     ['n|<Leader>fl'] = '<CMD>Clap filer<CR>',
    --     ['n|<Leader>pr'] = '<CMD>Clap providers<CR>',
    --     ['n|<Leader>df'] = '<CMD>Clap dot<CR>',
    -- }

    self.telescope = {
        ['n|<Leader>li'] = '<cmd>Telescope current_buffer_fuzzy_find<CR>',
        ['n|<Leader>bs'] = '<CMD>Telescope buffers<CR>',
        ['n|<Leader>co'] = '<CMD>Telescope colorscheme<CR>',
        ['n|<Leader>cm'] = '<CMD>Telescope commands<CR>',
        ['n|<Leader>ch'] = '<CMD>Telescope command_history<CR>',
        ['n|<Leader>sh'] = '<CMD>Telescope search_history<CR>',
        ['n|<Leader>fr'] = '<CMD>lua require("telescope.builtin").live_grep({additional_args = _G.rg_options})<CR>',
        ['n|<Leader>fa'] = '<CMD>lua require("telescope").extensions.live_grep_raw.live_grep_raw({additional_args = _G.rg_options})<CR>',
        -- ['n|<Leader>fa'] = '<CMD>Telescope live_grep_raw<CR>',
        ['n|<Leader>ff'] = '<CMD>lua require("telescope.builtin").find_files({find_command = find_files_args,})<CR>',
        ['n|<Leader>fw'] = '<cmd>lua require("telescope.builtin").grep_string({additional_args = _G.rg_options})<CR>',
        ['n|<Leader>fs'] = '<cmd>lua require("telescope.builtin").grep_string({search = _G.search_word2()})<CR>',
        -- ['n|<Leader>fp'] = "<CMD>lua require'telescope'.extensions.project.project{}<CR>",
        ['n|<Leader>fp'] = "<CMD>Telescope projects<CR>",
        ['n|<Leader>pc'] = "<CMD>lua require('telescope').extensions.packer.plugins(opts)<CR>",
        -- ['n|<Leader>fs'] = '<CMD>lua require("mylib")["search_word"]()<CR>',
        -- ['n|<Leader>ii'] = '<CMD>Clap function<CR>',
        ['n|<Leader>gf'] = '<CMD>Telescope git_files<CR>',
        -- ['n|<Leader>rm'] = '<CMD>Telescope oldfiles<CR>',
        ['n|<Leader>rm'] = '<CMD>Telescope frecency<CR>',
        ['n|<Leader>hp'] = '<CMD>Telescope help_tags<CR>',
        ['n|<Leader>jj'] = '<CMD>Telescope jumplist<CR>',
        ['n|<Leader>ma'] = '<CMD>Telescope marks<CR>',
        ['n|<Leader>mn'] = '<CMD>Telescope man_pages<CR>',
        ['n|<Leader>mp'] = '<CMD>Telescope keymaps<CR>',
        ['n|<Leader>qf'] = '<CMD>Telescope quickfix<CR>',
        ['n|<Leader>ll'] = '<CMD>Telescope loclist<CR>',
        ['n|<Leader>re'] = '<CMD>Telescope registers<CR>',
        ['n|<Leader>bt'] = '<cmd>Telescope current_buffer_tags<CR>',
        ['n|<Leader>op'] = '<cmd>Telescope vim_options<CR>',
        ['n|<LocalLeader>ir'] = '<cmd>Telescope resume<CR>',
        -- ['n|<Leader>yk'] = '<CMD>Clap yanks<CR>',
        -- ['n|<Leader>fl'] = '<CMD>Clap filer<CR>',
        ['n|<Leader>tl'] = '<CMD>Telescope<CR>',
        -- ['n|<Leader>df'] = '<CMD>Clap dot<CR>',
        -- ['n|<Leader>dj'] = '<CMD>Telescope file_browser<CR>',
    }

    self.Commentary = {
        ['n|<Leader>ci'] = '<CMD>Commentary<CR>',
    }

    -- Vista
    self.vista = {
        ['n|<Leader>ii'] = '<CMD>Vista finder<CR>',
        ['n|<Leader>it'] = '<CMD>Vista finder!<CR>',
        ['n|<Leader>vs'] = '<CMD>Vista!!<CR>',
    }

    -- rnvimr
    self.rnvimr = {
        ['n|<Leader>rn'] = '<CMD>RnvimrToggle<CR>',
        ['t|<M-i>'] = '<C-\\><C-n>:RnvimrResize<CR>',
    }

    -- undotree
    self.undotree = {
        ['n|<LocalLeader>ud'] = '<CMD>GundoToggle<CR>',
    }

    -- vim-fugitive
    self.vim_fugitive = {
        ['n|<LocalLeader>ma'] = '<CMD>Git<CR>',
        ['n|<LocalLeader>gd'] = '<CMD>Git diff<CR>',
        ['n|<LocalLeader>gs'] = '<CMD>Gvdiffsplit<CR>',
        ['n|<LocalLeader>gp'] = '<CMD>Git push<CR>',
        ['n|<LocalLeader>gl'] = '<CMD>Git pull<CR>',
    }

    -- vim-better-whitespace
    self.vim_better_whitespace = {
        ['n|]w'] = '<CMD>NextTrailingWhitespace<CR>',
        ['n|[w'] = '<CMD>PrevTrailingWhitespace<CR>',
    }

    -- nnn.vim
    self.nnn_vim = {
        ['n|<Leader>nn'] = '<CMD>NnnPicker<CR>',
    }

    -- floaterm
    -- self.floaterm = {
    --     ['n|<Leader>ff'] = '<CMD>FloatermNew lf<CR>',
    -- }

    -- vim-signify
    self.vim_signify = {
        ['n|<LocalLeader>df'] = '<CMD>SignifyDiff<CR>',
        ['n|<LocalLeader>du'] = '<CMD>SignifyHunkDiff<CR>',
        ['n|<LocalLeader>dr'] = '<CMD>SignifyHunkUndo<CR>',
        ['n|<LocalLeader>dn'] = {'<plug>(signify-next-hunk)', false}, -- must noremap = false
        ['n|<LocalLeader>dp'] = {'<plug>(signify-prev-hunk)', false}, -- must noremap = false
    }

    -- vim-youdao-translater
    self.vim_youdao_translater = {
        ['v|<C-y>'] = '<CMD>Ydv<CR>',
        ['n|<C-y>'] = '<CMD>Ydc<CR>',
        ['|<Leader>yd'] = ':<C-u>Yde<CR>',
    }

    -- tagbar
    -- self.tagbar = {
    --     ['n|<Leader>tb'] = '<CMD>TagbarToggle<CR>',
    -- }

    -- barbar.nvim
    self.barbar = {
        ["n|<S-l>"] = "<CMD>BufferNext<CR>",
        ["n|<S-h>"] = "<CMD>BufferPrevious<CR>",
    }

    -- vim-easymotion
    self.easy_motion = {
        ['n|<Leader>ms'] = {"<Plug>(easymotion-s2)", false},
        ['n|<Leader>mr'] = {"<Plug>(easymotion-repeat)", false},
    }

    -- vim-fswitch
    self.switch = {
        ['n|<Leader>fo'] = '<cmd>FSHere<CR>',
    }

    -- neovim-session-manager
    self.session_manager = {
        ['n|<LocalLeader>ww'] = '<CMD>Telescope sessions save_current=true<CR>',
        -- ['n|<LocalLeader>ww'] = '<CMD>Telescope sessions<CR>',
        ['n|<LocalLeader>ws'] = '<CMD>SaveSession<CR>',
        ['n|<LocalLeader>wl'] = '<CMD>LoadLastSession<CR>',
    }

    -- nerdtree
    -- self.nerdtree = {
    --     ['n|<Leader>tt'] = '<CMD>NERDTreeToggle<CR>',
    --     ['n|<C-n>'] = '<CMD>NERDTree<CR>',
    --     -- ['n|<C-t>'] = '<CMD>NERDTreeFocus<CR>',
    --     ['n|<C-f>'] = '<CMD>NERDTreeFind<CR>',
    -- }

    -- defx
    self.defx = {
        ['n|<Leader>dj'] = '<CMD>Defx<CR>',
        ['n|<Leader>df'] = "<CMD>Defx `escape(expand('%:p:h'), ' :')` -search=`expand('%:p')`<CR>",
    }

    -- vim-highlighter
    self.vim_highlighter = {
        -- :nn <silent>-  :<C-U> Hi/next<CR>
        -- :nn <silent>_  :<C-U> Hi/previous<CR>
        -- :nn f<Left>    :<C-U> Hi/older<CR>
        -- :nn f<Right>   :<C-U> Hi/newer<CR>
        ['n|-'] = ':<C-U> Hi/next<CR>',
        ['n|_'] = ':<C-U> Hi/previous<CR>',
        ['n|f<Left>'] = ':<C-U> Hi/older<CR>',
        ['n|f<Right>'] = ':<C-U> Hi/newer<CR>',
        ['n|<Leader>so'] = '<CMD>Hi +<CR>',
    }

    self:process_keys()
end

local function auto_cmd()
    vim.cmd [[autocmd FileType find nnoremap <buffer> q <CMD>Hi /close<CR>]]
    vim.cmd [[autocmd FileType gitcommit nnoremap <buffer> q <CMD>wq<CR>]]
end

local function set_leader()
    vim.g.mapleader = ";"
    vim.g.maplocalleader = " "
    vim.api.nvim_set_keymap('n', ' ', '', {noremap = true})
    vim.api.nvim_set_keymap('x', ' ', '', {noremap = true})
end

function key_mappings.setup()
    set_leader()
    key_mappings:start()
    auto_cmd()
end

key_mappings.setup()
