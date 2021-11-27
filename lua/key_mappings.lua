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
        keymap.options.noremap = value[2] and value[2] or keymap.options.noremap
        keymap.options.silent = value[3] and value[3] or keymap.options.silent
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

function key_mappings:start()
    self.normal = {
        ['n|<Leader>zz'] = '<CMD>w<CR>',
        ['n|<Leader>fd'] = '<CMD>echo expand("%:p")<CR>',
        ['n|<Leader>a'] = '^',
        ['n|<Leader>e'] = '$',
        ['n|<Leader>xx'] = '<CMD>nohl<CR>',
        ['n|<Leader><TAB>'] = '<C-w><C-w>',
        ['n|<Leader>do'] = '<CMD>on<CR>',
        ['n|<Leader>dm'] = '<CMD>delmarks!<CR>',
        ['n|<Leader>kb'] = '<CMD>bdel<CR>',
        ['n|<Space><Space>'] = {':', true},
        ['n|<Leader>bb'] = '<C-^>',
        ['n|<Leader>lm'] = '<CMD>lua require("futil").toggle_line_number()<CR>',
        ['n|<LocalLeader>qq'] = '<CMD>q<CR>',
        ['n|Y'] = 'y$',
        ['n|<F12>'] = '<CMD>lua require("futil").toggle_mouse()<CR>',
        ['n|<Leader>ia'] = 'm`A;<Esc>``',
        ['n|<Leader>yy'] = "m`y'a``",
        ['n|<Leader>dd'] = "d'a",
        ['n|<Leader>qf'] = '<CMD>copen<CR>',
        ['n|<Leader>mf'] = '<CMD>lua require("futil").make_fennel()<CR>',
        -- ['n|<Leader>cs'] = '<CMD>lua require("mylib").coc_status()<CR>',
        ['n|<Leader>fn'] = '<CMD>lua require("futil").display_function()<CR>',
        ['n|<C-g>'] = '<C-c>',
        -- help motion.txt
        -- If your '{' or '}' are not in the first column, and you would like to use "[["
        -- and "]]" anyway, try these mappings: >
        -- ['n|[['] = {'?{<CR>w99[{'},
        -- ['n|]['] = {'/}<CR>b99]}'},
        -- ['n|]]'] = {'j0[[%/{<CR>'},
        -- ['n|[]'] = {'k$][%?}<CR>'},
    }

    self.visual = {
        ['v|<Leader>g'] = '<C-c>',
        ['v|<C-g>'] = '<C-c>',
    }

    self.insert = {
        ['i|<Leader>g'] = '<C-c>',
        ['i|<Leader>O'] = '<C-o>O',
        ['i|<Leader>o'] = '<C-o>o',
        ['i|<Leader>zz'] = '<Esc><CMD>w<CR>a',
        ['i|<C-b>'] = '<Left>',
        ['i|<C-f>'] = '<Right>',
        ['i|<C-a>'] = '<Esc>I',
        ['i|<C-e>'] = '<End>',
        ['i|<C-g>'] = '<C-c>',
        ['i|<C-j>'] = '<Down>',
        ['i|<C-k>'] = '<Up>',
        ['i|<C-d>'] = '<Del>',
    }

    self.terminal = {
        ['t|<F12>'] = '<CMD>lua require("futil").toggle_mouse()<CR>',
    }

    self.command = {
        ['c|<C-g>'] = '<C-c>',
    }

    -- coc
    -- self.coc = {
    --     ['n|<Leader>tl'] = '<CMD>CocCommand explorer<CR>',
    --     ['n|<Leader>tt'] = '<CMD>CocCommand explorer --position floating<CR>',
    -- }

    -- coc-fzf key mappings
    -- self.cocfzf = {
    --     ['n|<LocalLeader>fl'] = ':<C-u>CocFzfList<CR>',
    --     ['n|<LocalLeader>da'] = ':<C-u>CocFzfList diagnostics<CR>',
    --     ['n|<LocalLeader>db'] = ':<C-u>CocFzfList diagnostics --current-buf<CR>',
    --     ['n|<LocalLeader>cc'] = ':<C-u>CocFzfList commands<CR>',
    --     ['n|<LocalLeader>ex'] = ':<C-u>CocFzfList extensions<CR>',
    --     ['n|<LocalLeader>co'] = ':<C-u>CocFzfList location<CR>',
    --     ['n|<LocalLeader>ol'] = ':<C-u>CocFzfList outline<CR>',
    --     ['n|<LocalLeader>sy'] = ':<C-u>CocFzfList symbols<CR>',
    --     -- ['n|<LocalLeader>re'] = ':<C-u>CocFzfListResume<CR>',
    --     ['n|<LocalLeader>re'] = ':<C-u>CocListResume<CR>',
    -- }

    -- fzf.vim key mappings
    -- self.fzfvim = {
    --     ['n|<Leader>fa'] = {'<CMD>Ag<CR>', true},
    --     ['n|<Leader>fw'] = ':Ag <C-R>=expand("<cword>")<CR><CR>',
    --     ['n|<Leader>fs'] = '<CMD>lua require("mylib")["search_word"]()<CR>',
    --     -- ['n|<Leader>fs'] = '<CMD>lua require("futil").search_word()<CR>',
    --     ['n|<Leader>fg'] = '<CMD>Rg<CR>',
    --     ['n|<Leader>rm'] = '<CMD>History<CR>',
    --     ['n|<Leader>ch'] = '<CMD>History:<CR>',
    --     ['n|<Leader>sh'] = '<CMD>History/<CR>',
    --     ['n|<Leader>li'] = '<CMD>BLines<CR>',
    --     ['n|<Leader>bs'] = '<CMD>Buffers<CR>',
    --     ['n|<Leader>gf'] = '<CMD>GFiles<CR>',
    --     ['n|<Leader>ma'] = '<CMD>Marks<CR>',
    --     ['n|<Leader>cc'] = '<CMD>Commands<CR>',
    --     ['n|<Leader>mp'] = '<CMD>Maps<CR>',
    --     ['n|<Leader>hl'] = '<CMD>Helptags<CR>',
    --     ['n|<Leader>tg'] = '<CMD>Tags<CR>',
    --     ['n|<Leader>ii'] = '<CMD>BTags<CR>',
    -- }

    -- Leaderf key mappings
    self.Leaderf = {
        ['n|<LocalLeader>ff'] = '<CMD>Leaderf file<CR>',
        ['n|<LocalLeader>fa'] = '<CMD>Leaderf rg<CR>',
        ['n|<LocalLeader>fw'] = ':Leaderf rg <C-R>=expand("<cword>")<CR><CR>',
        ['n|<LocalLeader>fs'] = '<CMD>lua require("mylib")["search_word"]()<CR>',
        -- ['n|<LocalLeader>fs'] = '<CMD>lua require("futil").search_word()<CR>',
        ['n|<LocalLeader>rm'] = '<CMD>Leaderf mru<CR>',
        ['n|<LocalLeader>ch'] = '<CMD>Leaderf cmdHistory<CR>',
        ['n|<LocalLeader>sh'] = '<CMD>Leaderf searchHistory<CR>',
        ['n|<LocalLeader>li'] = '<CMD>Leaderf line<CR>',
        ['n|<LocalLeader>bs'] = '<CMD>Leaderf buffer<CR>',
        -- ['n|<LocalLeader>gf'] = '<CMD>GFiles<CR>',
        -- ['n|<LocalLeader>ma'] = '<CMD>Marks<CR>',
        ['n|<LocalLeader>cc'] = '<CMD>Leaderf command<CR>',
        -- ['n|<LocalLeader>mp'] = '<CMD>Maps<CR>',
        ['n|<LocalLeader>hp'] = '<CMD>Leaderf help<CR>',
        ['n|<LocalLeader>tg'] = '<CMD>Leaderf tag<CR>',
        ['n|<LocalLeader>bg'] = '<CMD>Leaderf bufTag<CR>',
        ['n|<LocalLeader>ii'] = '<CMD>Leaderf function<CR>',
        ['n|<LocalLeader>qf'] = '<CMD>Leaderf quickfix<CR>',
        ['n|<LocalLeader>ll'] = '<CMD>Leaderf loclist<CR>',
        ['n|<LocalLeader>gt'] = '<CMD>Leaderf gtags<CR>',
    }

    -- Clap
    self.clap = {
        ['n|<Leader>cl'] = '<CMD>Clap<CR>',
        ['n|<Leader>li'] = '<CMD>Clap blines<CR>',
        ['n|<Leader>bs'] = '<CMD>Clap buffer<CR>',
        ['n|<Leader>co'] = '<CMD>Clap colors<CR>',
        ['n|<Leader>cm'] = '<CMD>Clap command<CR>',
        ['n|<Leader>ch'] = '<CMD>Clap command_history<CR>',
        ['n|<Leader>sh'] = '<CMD>Clap search_history<CR>',
        ['n|<Leader>ff'] = '<CMD>Clap files<CR>',
        -- ['n|<Leader>fw'] = '<CMD>Leaderf rg <C-R>=expand("<cword>")<CR><CR>',
        -- ['n|<Leader>fs'] = '<CMD>lua require("mylib")["search_word"]()<CR>',
        -- ['n|<Leader>ii'] = '<CMD>Clap function<CR>',
        ['n|<Leader>gf'] = '<CMD>Clap git_files<CR>',
        ['n|<Leader>rm'] = '<CMD>Clap history<CR>',
        ['n|<Leader>hp'] = '<CMD>Clap help_tags<CR>',
        ['n|<Leader>jj'] = '<CMD>Clap jumps<CR>',
        ['n|<Leader>ma'] = '<CMD>Clap marks<CR>',
        ['n|<Leader>mp'] = '<CMD>Clap maps<CR>',
        ['n|<Leader>qf'] = '<CMD>Clap quickfix<CR>',
        ['n|<Leader>ll'] = '<CMD>Clap loclist<CR>',
        ['n|<Leader>fa'] = '<CMD>Clap grep<CR>',
        ['n|<Leader>fm'] = '<CMD>Clap grep2<CR>',
        ['n|<Leader>ra'] = '<CMD>Clap registers<CR>',
        ['n|<Leader>bt'] = '<CMD>Clap tags<CR>',
        ['n|<Leader>pt'] = '<CMD>Clap proj_tags<CR>',
        ['n|<Leader>yk'] = '<CMD>Clap yanks<CR>',
        ['n|<Leader>fl'] = '<CMD>Clap filer<CR>',
        ['n|<Leader>pr'] = '<CMD>Clap providers<CR>',
        ['n|<Leader>df'] = '<CMD>Clap dot<CR>',
    }

    self.Commentary = {
        ['n|<Leader>ci'] = '<CMD>Commentary<CR>',
    }

    -- Vista
    self.vista = {
        ['n|<Leader>ii'] = '<CMD>Vista<CR>',
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

    -- coc.translator
    -- self.coc_translator = {
    --     -- " NOTE: do NOT use `nore` mappings
    --     ['n|<Leader>tu'] = {'<Plug>(coc-translator-p)',},
    --     ['v|<Leader>tu'] = {'<Plug>(coc-translator-pv)',},
    --     ['n|<Leader>te'] = {'<Plug>(coc-translator-e)',},
    --     ['v|<Leader>te'] = {'<Plug>(coc-translator-ev)',},
    --     ['n|<Leader>tr'] = {'<Plug>(coc-translator-r)',},
    --     ['v|<Leader>tr'] = {'<Plug>(coc-translator-rv)',},
    -- }

    -- vim-fugitive
    self.vim_fugitive = {
        ['n|<Leader>gt'] = '<CMD>Git<CR>',
        ['n|<Leader>gd'] = '<CMD>Git diff<CR>',
        ['n|<Leader>gs'] = '<CMD>Gvdiffsplit<CR>',
        ['n|<Leader>gp'] = '<CMD>Git push<CR>',
        ['n|<Leader>gl'] = '<CMD>Git pull<CR>',
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
        ['n|<LocalLeader>du'] = '<CMD>SignifyHunkDiff<CR>',
        ['n|<LocalLeader>dr'] = '<CMD>SignifyHunkUndo<CR>',
        ['n|<LocalLeader>dn'] = {'<plug>(signify-next-hunk)', false},
        ['n|<LocalLeader>dp'] = {'<plug>(signify-prev-hunk)', false},
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

    self:process_keys()
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
end

return key_mappings
