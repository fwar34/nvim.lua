-- key_mappings
local global = require('global')

local key_mappings = {normal = {}, visual = {}, insert = {}, }
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

local function create_keymap(mode, key, value)
    local keymap = key_map:new()
    keymap.mode = mode
    keymap.lhs = key
    keymap.rhs = value[1]
    keymap.options.noremap = value[2] and true or false
    keymap.options.silent = value[3] and true or false

    return keymap
end

local function create_keymap_for_plugin(key, value)
    local keymap = key_map:new()
    keymap.mode, keymap.lhs = key:match('([^|]*)|?(.*)')
    keymap.rhs = value[1]
    keymap.options.noremap = value[2] and true or false
    keymap.options.silent = value[3] and true or false

    return keymap
end

function key_mappings:process_keys()
    for k, v in pairs(self.normal) do
        local keymap = create_keymap('n', k, v)
        keymap:process()
    end

    for k, v in pairs(self.insert) do
        local keymap = create_keymap('i', k, v)
        keymap:process()
    end

    for k, v in pairs(self.normal) do
        local keymap = create_keymap('v', k, v)
        keymap:process()
    end

    for k, v in pairs(self.cocfzf) do
        local keymap = create_keymap_for_plugin(k, v)
        keymap:process()
    end

    for k, v in pairs(self.fzfvim) do
        local keymap = create_keymap_for_plugin(k, v)
        keymap:process()
    end

    for k, v in pairs(self.clap) do
        local keymap = create_keymap_for_plugin(k, v)
        keymap:process()
    end

    for k, v in pairs(self.vista) do
        local keymap = create_keymap_for_plugin(k, v)
        keymap:process()
    end

    for k, v in pairs(self.coc) do
        local keymap = create_keymap_for_plugin(k, v)
        keymap:process()
    end

    for k, v in pairs(self.rnvimr) do
        local keymap = create_keymap_for_plugin(k, v)
        keymap:process()
    end

    for k, v in pairs(self.undotree) do
        local keymap = create_keymap_for_plugin(k, v)
        keymap:process()
    end

    for k, v in pairs(self.coc_translator) do
        local keymap = create_keymap_for_plugin(k, v)
        keymap:process()
    end

    for k, v in pairs(self.vim_fugitive) do
        local keymap = create_keymap_for_plugin(k, v)
        keymap:process()
    end
end

function key_mappings:start()
    self.normal = {
        ['<leader>zz'] = {'<CMD>w<CR>', true, true},
        ['<leader>fd'] = {'<CMD>echo expand("%:p")<CR>', true, true},
        ['<leader>a'] = {'^', true, true},
        ['<leader>e'] = {'$', true, true},
        ['<leader>xx'] = {'<CMD>nohl<CR>', true, true},
        ['<leader><TAB>'] = {'<C-w><C-w>', true, true},
        ['<leader>do'] = {'<CMD>on<CR>', true, true},
        ['<Space><Space>'] = {':', true},
        ['<leader>bb'] = {'<C-^>', true, true},
        ['<localleader>lm'] = {'<CMD>lua require("futil").toggle_line_number()<CR>', true, true},
        ['<localleader>qq'] = {'<CMD>q<CR>', true, true},
        ['Y'] = {'y$', true, true},
    }

    self.visual = {
        ['<leader>g'] = {'<Esc>', true, true},
        ['<C-g>'] = {'<Esc>', true, true},
    }

    self.insert = {
        ['<leader>g'] = {'<C-c>', true, true},
        ['<leader>a'] = {'<Esc>I', true, true},
        ['<leader>e'] = {'<End>', true, true},
        ['<leader>O'] = {'<C-o>O', true, true},
        ['<leader>o'] = {'<C-o>o', true, true},
        ['<leader>zz'] = {'<Esc><CMD>w<CR>a', true, true},
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
        ['n|<leader>ht'] = {'<CMD>Helptags<CR>', true, true},
        ['n|<leader>tg'] = {'<CMD>Tags<CR>', true, true},
        ['n|<leader>bt'] = {'<CMD>BTags<CR>', true, true},
    }

    -- Clap
    self.clap = {
        ['n|<localleader>rm'] = {'<CMD>Clap history<CR>', true, true},
        ['n|<localleader>fs'] = {'<CMD>Clap search_history<CR>', true, true},
        ['n|<localleader>fd'] = {'<CMD>Clap git_diff_files<CR>', true, true},
        ['n|<localleader>fh'] = {'<CMD>Clap help_tags<CR>', true, true},
        ['n|<localleader>fa'] = {'<CMD>Clap grep<CR>', true, true},
    }

    -- Vista
    self.vista = {
        ['n|<leader>ii'] = {'<CMD>Vista<CR>', true, true},
    }

    -- rnvimr
    self.rnvimr = {
        ['n|<localleader>tt'] = {'<CMD>RnvimrToggle<CR>', true, true},
    }

    -- undotree
    self.undotree = {
        ['n|<localleader>ud'] = {'<CMD>GundoToggle<CR>', true, true},
    }

    -- coc.translator
    self.coc_translator = {
        -- " NOTE: do NOT use `nore` mappings
        ['n|<leader>tu'] = {'<Plug>(coc-translator-p)', false, true},
        ['v|<leader>tu'] = {'<Plug>(coc-translator-pv)', false, true},
        ['n|<leader>te'] = {'<Plug>(coc-translator-e)', false, true},
        ['v|<leader>te'] = {'<Plug>(coc-translator-ev)', false, true},
        ['n|<leader>tr'] = {'<Plug>(coc-translator-r)', false, true},
        ['v|<leader>tr'] = {'<Plug>(coc-translator-rv)', false, true},
    }

    -- vim-fugitive
    self.vim_fugitive = {
        ['n|<leader>gt'] = {'<CMD>Git<CR>', true, true},
        ['n|<leader>gd'] = {'<CMD>Git diff<CR>', true, true},
        ['n|<leader>gs'] = {'<CMD>Gdiffsplit<CR>', true, true},
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
    -- vim.cmd [[ nnoremap <silent> <leader> :WhichKey ';'<CR> ]]
    key_mappings:start()
end

return key_mappings
