-- key_mappings
local global = require('global')

local key_mappings = {normal = {}, visual = {}, insert = {}}
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
    -- keymap.leader, keymap.lhs = key:match('([^|]*)|?(.*)')
    keymap.lhs = key
    keymap.rhs = value[1]
    keymap.options.noremap = value[2] and value[2] or false
    keymap.options.silent = value[3] and value[3] or false

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
end

function key_mappings:start()
    toggle_line_number()
    self.normal = {
        ['<leader>zz'] = {'<CMD>w<CR>', true, true},
        ['<leader>fd'] = {'<CMD>echo expand("%:p")<CR>', true, true},
        ['<leader>a'] = {'^', true, true},
        ['<leader>e'] = {'$', true, true},
        ['<leader>xx'] = {'<CMD>nohl<CR>', true, true},
        ['<Space><Space>'] = {':', true},
        ['<leader>bb'] = {'<C-^>', true, true}
        ['<localleader>lm'] = {'<CMD>lua require("futil").toggle_line_number()<CR>', true, true}
    }

    self.visual = {
        ['<leader>g'] = {'<Esc>', true, true},
    }

    self.insert = {
        ['<leader>g'] = {'<C-c>', true, true},
        ['<leader>a'] = {'<Esc>I', true, true},
        ['<leader>e'] = {'<End>', true, true},
        ['<leader>O'] = {'<C-o>O', true, true},
        ['<leader>o'] = {'<C-o>o', true, true},
        ['<leader>zz'] = {'<Esc><CMD>w<CR>a', true, true},
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
