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
        ['n|<leader>zz'] = {'<CMD>w<CR>', true, true},
        ['n|<leader>fd'] = {'<CMD>echo expand("%:p")<CR>', true, true},
        ['n|<leader>a'] = {'^', true, true},
        ['n|<leader>e'] = {'$', true, true},
        ['n|<leader>xx'] = {'<CMD>nohl<CR>', true, true},
        ['n|<leader><TAB>'] = {'<C-w><C-w>', true, true},
        ['n|<leader>do'] = {'<CMD>on<CR>', true, true},
        ['n|<leader>dm'] = {'<CMD>delmarks!<CR>', true, true},
        ['n|<leader>db'] = {'<CMD>bdel<CR>', true, true},
        ['n|<Space><Space>'] = {':', true},
        ['n|<leader>bb'] = {'<C-^>', true, true},
        ['n|<localleader>lm'] = {'<CMD>lua require("futil").toggle_line_number()<CR>', true, true},
        ['n|<localleader>qq'] = {'<CMD>q<CR>', true, true},
        ['n|Y'] = {'y$', true, true},
        ['n|<F12>'] = {'<CMD>lua require("futil").toggle_mouse()<CR>', true, true},
        ['n|<leader>ia'] = {'mgA;<Esc>`gmg', true, true},
        ['n|<leader>yy'] = {"mgy'a`g", true, true},
        ['n|<leader>dd'] = {"d'a", true, true},
        ['n|<leader>qf'] = {'<CMD>copen<CR>', true, true},
        ['n|<leader>mf'] = {'<CMD>lua require("futil").make_fennel()<CR>', true, true},
    }

    self.visual = {
        ['v|<leader>g'] = {'<Esc>', true, true},
        ['v|<C-g>'] = {'<Esc>', true, true},
    }

    self.insert = {
        ['i|<leader>g'] = {'<C-c>', true, true},
        ['i|<leader>a'] = {'<Esc>I', true, true},
        ['i|<leader>e'] = {'<End>', true, true},
        ['i|<leader>O'] = {'<C-o>O', true, true},
        ['i|<leader>o'] = {'<C-o>o', true, true},
        ['i|<leader>zz'] = {'<Esc><CMD>w<CR>a', true, true},
    }

    self.terminal = {
        ['t|<F12>'] = {'<CMD>lua require("futil").toggle_mouse()<CR>', true, true},
    }

    -- coc
    self.coc = {
        ['n|<leader>tl'] = {'<CMD>CocCommand explorer<CR>', true, true},
        ['n|<leader>tt'] = {'<CMD>CocCommand explorer --position floating<CR>', true, true},
    }

    -- coc-fzf key mappings
    self.cocfzf = {
        ['n|<localleader>fl'] = {':<C-u>CocFzfList<CR>', true, true},
    }

    -- fzf.vim key mappings
    self.fzfvim = {
        ['n|<leader>fa'] = {'<CMD>Ag<CR>', true},
        ['n|<leader>fw'] = {':Ag <C-R>=expand("<cword>")<CR><CR>', true, true},
        ['n|<leader>fs'] = {'<CMD>lua require("mylib")["search_word"]()<CR>', true, true},
        -- ['n|<leader>fs'] = {'<CMD>lua require("futil").search_word()<CR>', true, true},
        ['n|<leader>fg'] = {'<CMD>Rg<CR>', true},
        ['n|<leader>rm'] = {'<CMD>History<CR>', true},
        ['n|<leader>ch'] = {'<CMD>History:<CR>', true},
        ['n|<leader>sh'] = {'<CMD>History/<CR>', true},
        ['n|<leader>li'] = {'<CMD>BLines<CR>', true},
        ['n|<leader>bs'] = {'<CMD>Buffers<CR>', true, true},
        ['n|<leader>gf'] = {'<CMD>GFiles<CR>', true, true},
        ['n|<leader>ma'] = {'<CMD>Marks<CR>', true, true},
        ['n|<leader>cc'] = {'<CMD>Commands<CR>', true, true},
        ['n|<leader>mp'] = {'<CMD>Maps<CR>', true, true},
        ['n|<leader>hl'] = {'<CMD>Helptags<CR>', true, true},
        ['n|<leader>tg'] = {'<CMD>Tags<CR>', true, true},
        ['n|<leader>bt'] = {'<CMD>BTags<CR>', true, true},
    }

    -- Clap
    self.clap = {
        ['n|<leader>cl'] = {'<CMD>Clap<CR>', true, true},
        ['n|<localleader>rm'] = {'<CMD>Clap history<CR>', true, true},
        ['n|<localleader>fs'] = {'<CMD>Clap search_history<CR>', true, true},
        ['n|<localleader>fd'] = {'<CMD>Clap git_diff_files<CR>', true, true},
        ['n|<localleader>fh'] = {'<CMD>Clap help_tags<CR>', true, true},
        ['n|<localleader>fa'] = {'<CMD>Clap grep<CR>', true, true},
        ['n|<localleader>do'] = {'<CMD>Clap dot<CR>', true, true},
    }

    -- Vista
    self.vista = {
        ['n|<leader>ii'] = {'<CMD>Vista<CR>', true, true},
    }

    -- rnvimr
    self.rnvimr = {
        ['n|<localleader>rn'] = {'<CMD>RnvimrToggle<CR>', true, true},
    }

    -- undotree
    self.undotree = {
        ['n|<localleader>ud'] = {'<CMD>GundoToggle<CR>', true, true},
    }

    -- coc.translator
    self.coc_translator = {
        -- " NOTE: do NOT use `nore` mappings
        ['n|<leader>tu'] = {'<Plug>(coc-translator-p)',},
        ['v|<leader>tu'] = {'<Plug>(coc-translator-pv)',},
        ['n|<leader>te'] = {'<Plug>(coc-translator-e)',},
        ['v|<leader>te'] = {'<Plug>(coc-translator-ev)',},
        ['n|<leader>tr'] = {'<Plug>(coc-translator-r)',},
        ['v|<leader>tr'] = {'<Plug>(coc-translator-rv)',},
    }

    -- vim-fugitive
    self.vim_fugitive = {
        ['n|<leader>gt'] = {'<CMD>Git<CR>', true, true},
        ['n|<leader>gd'] = {'<CMD>Git diff<CR>', true, true},
        ['n|<leader>gs'] = {'<CMD>Gvdiffsplit<CR>', true, true},
        ['n|<leader>gp'] = {'<CMD>Git push<CR>', true, true},
    }

    -- vim-better-whitespace
    self.vim_better_whitespace = {
        ['n|]w'] = {'<CMD>NextTrailingWhitespace<CR>', true, true},
        ['n|[w'] = {'<CMD>PrevTrailingWhitespace<CR>', true, true},
    }

    -- nnn.vim
    self.nnn_vim = {
        ['n|<leader>nn'] = {'<CMD>NnnPicker<CR>', true, true},
    }

    -- floaterm
    self.floaterm = {
        ['n|<leader>ff'] = {'<CMD>FloatermNew lf<CR>', true, true},
    }

    -- vim-signify
    self.vim_signify = {
        ['n|<leader>df'] = {'<CMD>SignifyHunkDiff<CR>', true, true},
        ['n|<leader>du'] = {'<CMD>SignifyHunkUndo<CR>', true, true},
    }

    -- vim-youdao-translater
    self.vim_youdao_translater = {
        ['v|<C-y>'] = {'<CMD>Ydv<CR>'},
        ['n|<C-y>'] = {'<CMD>Ydc<CR>'},
        ['|<leader>yd'] = {':<C-u>Yde<CR>'},
    }

    -- tagbar
    self.tagbar = {
        ['n|<leader>tb'] = {'<CMD>TagbarToggle<CR>'},
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
