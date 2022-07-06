local autocmd = {}
local vim = vim
local api = vim.api

-- local function goto_last_position()
    -- vim.cmd [[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]
-- end

local function goto_last_position()
    api.nvim_create_autocmd('BufReadPost', {
        pattern = '*',
        callback = function()
            if vim.bo.filetype == 'gitcommit' then -- 在 gitcommit 中不跳转
                return
            end
            local position = api.nvim_buf_get_mark(0, '"')
            -- vim.pretty_print(position)
            if position ~= nil and position[1] >= 1 and position[1] <= api.nvim_buf_line_count(0) then
                -- api.nvim_win_set_cursor(0, position)
                -- 每次 '"' mark 都减少了一个位置
                api.nvim_win_set_cursor(0, {position[1], position[2] + 1})
                -- require('global').dump(position)
                -- require('global').put(position)
            end
        end
    })
end

local function cmd_for_packer()
    -- vim.cmd [[ autocmd! BufWritePost plugins.lua PackerCompile ]]
    vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
    ]])
end

local function map_q_to_quit()
    api.nvim_create_autocmd("FileType", {
        pattern = {'help', 'qf', 'netrw', 'startuptime', 'git'},
        callback = function()
            -- api.nvim_buf_set_keymap(0, 'n', 'q', '<CMD>q<CR>', {noremap = true})
            vim.keymap.set('n', 'q', '<CMD>q<CR>', {buffer = true})
        end
    })
end

local function map_fugitiv_q_2_quit()
    api.nvim_create_autocmd("FileType", {
        pattern = 'fugitive',
        callback = function()
            -- api.nvim_buf_set_keymap(0, 'n', 'q', 'gq', {})
            vim.keymap.set('n', 'q', 'gq', {buffer = true, remap = true})
        end
    })
end

local function help_mouse()
    vim.cmd [[ autocmd! BufEnter *.txt lua require('futil'):set_mouse() ]]
    vim.cmd [[ autocmd! BufLeave *.txt lua require('futil'):restore_mouse() ]]
end

-- local function map_wq_to_quit()
--     vim.cmd [[ autocmd! FileType gitcommit :nnoremap <buffer> q <CMD>wq<CR> ]]
-- end
local function map_wq_to_quit()
    api.nvim_create_autocmd("FileType", {
        pattern = "gitcommit",
        callback = function()
            -- api.nvim_buf_set_keymap(0, "n", "q", "<CMD>wq<CR>", {noremap = true})
            vim.keymap.set('n', 'q', '<CMD>wq<CR>', {buffer = true})
            -- return true -- look ':help nvim_create_autocmd' return true to delete this autocmd
        end
    })
end

local function map_find_q_quit()
    api.nvim_create_autocmd("FileType", {
        pattern = "find",
        callback = function()
            api.nvim_buf_set_keymap(0, 'n', 'q', '<CMD>Hi /close<CR>', {noremap = true})
        end
    })
end

local function disable_auto_comment()
    -- "禁止vim换行后自动添加的注释符号
    vim.cmd [[ augroup Format-Options ]]
    vim.cmd [[ autocmd! ]]
    -- https://superuser.com/questions/271023/can-i-disable-continuation-of-comments-to-the-next-line-in-vim
    -- "autocmd BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    -- " This can be done as well instead of the previous line, for setting formatoptions as you choose:
    vim.cmd [[ autocmd BufEnter * setlocal formatoptions-=cro ]]
    -- "让vim显示行尾的空格
    -- "autocmd BufEnter * highlight WhitespaceEOL ctermbg=red guibg=red
    -- "autocmd BufEnter * match WhitespaceEOL /\s\+$/
    vim.cmd [[ augroup END ]]
end

function autocmd.setup()
    goto_last_position()
    cmd_for_packer()
    map_q_to_quit()
    map_find_q_quit()
    map_wq_to_quit()
    help_mouse()
    disable_auto_comment()
    map_fugitiv_q_2_quit()
    -- golang_autocmd()
end

autocmd.setup()
