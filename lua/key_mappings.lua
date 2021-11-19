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
            noremap = false,
            silent = false
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
    keymap.rhs = value[1]
    keymap.options.noremap = value[2] and true or false
    keymap.options.silent = value[3] and true or false

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
        ['n|<Leader>zz'] = {'<CMD>w<CR>', true, true},
        ['n|<Leader>fd'] = {'<CMD>echo expand("%:p")<CR>', true, true},
        ['n|<Leader>a'] = {'^', true, true},
        ['n|<Leader>e'] = {'$', true, true},
        ['n|<Leader>xx'] = {'<CMD>nohl<CR>', true, true},
        ['n|<Leader><TAB>'] = {'<C-w><C-w>', true, true},
        ['n|<Leader>do'] = {'<CMD>on<CR>', true, true},
        ['n|<Leader>dm'] = {'<CMD>delmarks!<CR>', true, true},
        ['n|<Leader>db'] = {'<CMD>bdel<CR>', true, true},
        ['n|<Space><Space>'] = {':', true},
        ['n|<Leader>bb'] = {'<C-^>', true, true},
        ['n|<Leader>lm'] = {'<CMD>lua require("futil").toggle_line_number()<CR>', true, true},
        ['n|<LocalLeader>qq'] = {'<CMD>q<CR>', true, true},
        ['n|Y'] = {'y$', true, true},
        ['n|<F12>'] = {'<CMD>lua require("futil").toggle_mouse()<CR>', true, true},
        ['n|<Leader>ia'] = {'m`A;<Esc>``', true, true},
        ['n|<Leader>yy'] = {"m`y'a``", true, true},
        ['n|<Leader>dd'] = {"d'a", true, true},
        ['n|<Leader>qf'] = {'<CMD>copen<CR>', true, true},
        ['n|<Leader>mf'] = {'<CMD>lua require("futil").make_fennel()<CR>', true, true},
        -- ['n|<Leader>cs'] = {'<CMD>lua require("mylib").coc_status()<CR>', true, true},
        ['n|<Leader>fn'] = {'<CMD>lua require("futil").display_function()<CR>', true, true},
        ['n|<C-g>'] = {'<C-c>', true, true},
        -- help motion.txt
        -- If your '{' or '}' are not in the first column, and you would like to use "[["
        -- and "]]" anyway, try these mappings: >
        -- ['n|[['] = {'?{<CR>w99[{'},
        -- ['n|]['] = {'/}<CR>b99]}'},
        -- ['n|]]'] = {'j0[[%/{<CR>'},
        -- ['n|[]'] = {'k$][%?}<CR>'},
    }

    self.visual = {
        ['v|<Leader>g'] = {'<C-c>', true, true},
        ['v|<C-g>'] = {'<C-c>', true, true},
    }

    self.insert = {
        ['i|<Leader>g'] = {'<C-c>', true, true},
        ['i|<Leader>O'] = {'<C-o>O', true, true},
        ['i|<Leader>o'] = {'<C-o>o', true, true},
        ['i|<Leader>zz'] = {'<Esc><CMD>w<CR>a', true, true},
        ['i|<C-b>'] = {'<Left>', true, true},
        ['i|<C-f>'] = {'<Right>', true, true},
        ['i|<C-a>'] = {'<Esc>I', true, true},
        ['i|<C-e>'] = {'<End>', true, true},
        ['i|<C-g>'] = {'<C-c>', true, true},
        ['i|<C-j>'] = {'<Down>', true, true},
        ['i|<C-k>'] = {'<Up>', true, true},
        ['i|<C-d>'] = {'<Del>', ture, true},
    }

    self.terminal = {
        ['t|<F12>'] = {'<CMD>lua require("futil").toggle_mouse()<CR>', true, true},
    }

    self.command = {
        ['c|<C-g>'] = {'<C-c>', true, true},
    }

    -- coc
    -- self.coc = {
    --     ['n|<Leader>tl'] = {'<CMD>CocCommand explorer<CR>', true, true},
    --     ['n|<Leader>tt'] = {'<CMD>CocCommand explorer --position floating<CR>', true, true},
    -- }

    -- coc-fzf key mappings
    -- self.cocfzf = {
    --     ['n|<LocalLeader>fl'] = {':<C-u>CocFzfList<CR>', true, true},
    --     ['n|<LocalLeader>da'] = {':<C-u>CocFzfList diagnostics<CR>', true, true},
    --     ['n|<LocalLeader>db'] = {':<C-u>CocFzfList diagnostics --current-buf<CR>', true, true},
    --     ['n|<LocalLeader>cc'] = {':<C-u>CocFzfList commands<CR>', true, true},
    --     ['n|<LocalLeader>ex'] = {':<C-u>CocFzfList extensions<CR>', true, true},
    --     ['n|<LocalLeader>co'] = {':<C-u>CocFzfList location<CR>', true, true},
    --     ['n|<LocalLeader>ol'] = {':<C-u>CocFzfList outline<CR>', true, true},
    --     ['n|<LocalLeader>sy'] = {':<C-u>CocFzfList symbols<CR>', true, true},
    --     -- ['n|<LocalLeader>re'] = {':<C-u>CocFzfListResume<CR>', true, true},
    --     ['n|<LocalLeader>re'] = {':<C-u>CocListResume<CR>', true, true},
    -- }

    -- fzf.vim key mappings
    -- self.fzfvim = {
    --     ['n|<Leader>fa'] = {'<CMD>Ag<CR>', true},
    --     ['n|<Leader>fw'] = {':Ag <C-R>=expand("<cword>")<CR><CR>', true, true},
    --     ['n|<Leader>fs'] = {'<CMD>lua require("mylib")["search_word"]()<CR>', true, true},
    --     -- ['n|<Leader>fs'] = {'<CMD>lua require("futil").search_word()<CR>', true, true},
    --     ['n|<Leader>fg'] = {'<CMD>Rg<CR>', true},
    --     ['n|<Leader>rm'] = {'<CMD>History<CR>', true},
    --     ['n|<Leader>ch'] = {'<CMD>History:<CR>', true},
    --     ['n|<Leader>sh'] = {'<CMD>History/<CR>', true},
    --     ['n|<Leader>li'] = {'<CMD>BLines<CR>', true},
    --     ['n|<Leader>bs'] = {'<CMD>Buffers<CR>', true, true},
    --     ['n|<Leader>gf'] = {'<CMD>GFiles<CR>', true, true},
    --     ['n|<Leader>ma'] = {'<CMD>Marks<CR>', true, true},
    --     ['n|<Leader>cc'] = {'<CMD>Commands<CR>', true, true},
    --     ['n|<Leader>mp'] = {'<CMD>Maps<CR>', true, true},
    --     ['n|<Leader>hl'] = {'<CMD>Helptags<CR>', true, true},
    --     ['n|<Leader>tg'] = {'<CMD>Tags<CR>', true, true},
    --     ['n|<Leader>ii'] = {'<CMD>BTags<CR>', true, true},
    -- }

    -- Leaderf key mappings
    -- self.Leaderf = {
    --     ['n|<Leader>ff'] = {'<CMD>Leaderf file<CR>', true},
    --     ['n|<Leader>fa'] = {'<CMD>Leaderf rg<CR>', true},
    --     ['n|<Leader>fw'] = {':Leaderf rg <C-R>=expand("<cword>")<CR><CR>', true, true},
    --     ['n|<Leader>fs'] = {'<CMD>lua require("mylib")["search_word"]()<CR>', true, true},
    --     -- ['n|<Leader>fs'] = {'<CMD>lua require("futil").search_word()<CR>', true, true},
    --     ['n|<Leader>rm'] = {'<CMD>Leaderf mru<CR>', true},
    --     ['n|<Leader>ch'] = {'<CMD>Leaderf cmdHistory<CR>', true},
    --     ['n|<Leader>sh'] = {'<CMD>Leaderf searchHistory<CR>', true},
    --     ['n|<Leader>li'] = {'<CMD>Leaderf line<CR>', true},
    --     ['n|<Leader>bs'] = {'<CMD>Leaderf buffer<CR>', true, true},
    --     -- ['n|<Leader>gf'] = {'<CMD>GFiles<CR>', true, true},
    --     -- ['n|<Leader>ma'] = {'<CMD>Marks<CR>', true, true},
    --     ['n|<Leader>cc'] = {'<CMD>Leaderf command<CR>', true, true},
    --     -- ['n|<Leader>mp'] = {'<CMD>Maps<CR>', true, true},
    --     ['n|<Leader>hp'] = {'<CMD>Leaderf help<CR>', true, true},
    --     ['n|<Leader>tg'] = {'<CMD>Leaderf tag<CR>', true, true},
    --     ['n|<Leader>bg'] = {'<CMD>Leaderf bufTag<CR>', true, true},
    --     ['n|<Leader>ii'] = {'<CMD>Leaderf function<CR>', true, true},
    --     ['n|<Leader>qf'] = {'<CMD>Leaderf quickfix<CR>', true, true},
    --     ['n|<Leader>ll'] = {'<CMD>Leaderf loclist<CR>', true, true},
    -- }

    -- Clap
    self.clap = {
        ['n|<Leader>cl'] = {'<CMD>Clap<CR>', true, true},
        ['n|<Leader>li'] = {'<CMD>Clap blines<CR>', true},
        ['n|<Leader>bs'] = {'<CMD>Clap buffer<CR>', true, true},
        ['n|<Leader>co'] = {'<CMD>Clap colors<CR>', true, true},
        ['n|<Leader>cc'] = {'<CMD>Clap command<CR>', true, true},
        ['n|<Leader>ch'] = {'<CMD>Clap command_history<CR>', true},
        ['n|<Leader>sh'] = {'<CMD>Clap search_history<CR>', true},
        ['n|<Leader>ff'] = {'<CMD>Clap files<CR>', true},
        -- ['n|<Leader>fw'] = {'<CMD>Leaderf rg <C-R>=expand("<cword>")<CR><CR>', true, true},
        -- ['n|<Leader>fs'] = {'<CMD>lua require("mylib")["search_word"]()<CR>', true, true},
        -- ['n|<Leader>ii'] = {'<CMD>Clap function<CR>', true, true},
        ['n|<Leader>gf'] = {'<CMD>Clap git_files<CR>', true, true},
        ['n|<Leader>rm'] = {'<CMD>Clap history<CR>', true, true},
        ['n|<Leader>hp'] = {'<CMD>Clap help_tags<CR>', true, true},
        ['n|<Leader>jj'] = {'<CMD>Clap jumps<CR>', true, true},
        ['n|<Leader>ma'] = {'<CMD>Clap marks<CR>', true, true},
        ['n|<Leader>mp'] = {'<CMD>Clap maps<CR>', true, true},
        ['n|<Leader>qf'] = {'<CMD>Clap quickfix<CR>', true, true},
        ['n|<Leader>ll'] = {'<CMD>Clap loclist<CR>', true, true},
        ['n|<Leader>fa'] = {'<CMD>Clap grep<CR>', true, true},
        ['n|<Leader>fm'] = {'<CMD>Clap grep2<CR>', true},
        ['n|<Leader>ra'] = {'<CMD>Clap registers<CR>', true},
        ['n|<Leader>bg'] = {'<CMD>Clap tags<CR>', true, true},
        ['n|<Leader>pg'] = {'<CMD>Clap proj_tags<CR>', true, true},
        ['n|<Leader>yk'] = {'<CMD>Clap yanks<CR>', true, true},
        ['n|<Leader>fl'] = {'<CMD>Clap filer<CR>', true, true},
        ['n|<Leader>pr'] = {'<CMD>Clap providers<CR>', true, true},
        ['n|<Leader>do'] = {'<CMD>Clap dot<CR>', true, true},
    }

    self.Commentary = { ['n|<Leader>ci'] = {'<CMD>Commentary<CR>', true, true} }

    -- Vista
    self.vista = {
        ['n|<Leader>bt'] = {'<CMD>Vista<CR>', true, true},
    }

    -- rnvimr
    self.rnvimr = {
        ['n|<Leader>rn'] = {'<CMD>RnvimrToggle<CR>', true, true},
    }

    -- undotree
    self.undotree = {
        ['n|<LocalLeader>ud'] = {'<CMD>GundoToggle<CR>', true, true},
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
        ['n|<Leader>gt'] = {'<CMD>Git<CR>', true, true},
        ['n|<Leader>gd'] = {'<CMD>Git diff<CR>', true, true},
        ['n|<Leader>gs'] = {'<CMD>Gvdiffsplit<CR>', true, true},
        ['n|<Leader>gp'] = {'<CMD>Git push<CR>', true, true},
        ['n|<Leader>gl'] = {'<CMD>Git pull<CR>', true, true},
    }

    -- vim-better-whitespace
    self.vim_better_whitespace = {
        ['n|]w'] = {'<CMD>NextTrailingWhitespace<CR>', true, true},
        ['n|[w'] = {'<CMD>PrevTrailingWhitespace<CR>', true, true},
    }

    -- nnn.vim
    self.nnn_vim = {
        ['n|<Leader>nn'] = {'<CMD>NnnPicker<CR>', true, true},
    }

    -- floaterm
    -- self.floaterm = {
    --     ['n|<Leader>ff'] = {'<CMD>FloatermNew lf<CR>', true, true},
    -- }

    -- vim-signify
    self.vim_signify = {
        ['n|<LocalLeader>du'] = {'<CMD>SignifyHunkDiff<CR>', true, true},
        ['n|<LocalLeader>dr'] = {'<CMD>SignifyHunkUndo<CR>', true, true},
    }

    -- vim-youdao-translater
    self.vim_youdao_translater = {
        ['v|<C-y>'] = {'<CMD>Ydv<CR>'},
        ['n|<C-y>'] = {'<CMD>Ydc<CR>'},
        ['|<Leader>yd'] = {':<C-u>Yde<CR>'},
    }

    -- tagbar
    self.tagbar = {
        ['n|<Leader>tb'] = {'<CMD>TagbarToggle<CR>'},
    }

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
