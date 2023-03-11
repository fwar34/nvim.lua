local autocmd = {}
local vim = vim
local api = vim.api
local cmd = vim.cmd

-- local function goto_last_position()
-- cmd [[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]
-- end

-- 特殊的 marks 可以看 :h marks
-- . 最近编辑的位置
-- 0-9 最近使用的文件
-- ^ 最近插入的位置
-- ' 上一次跳转前的位置
-- " 上一次退出文件时的位置
-- [ 上一次修改的开始处
-- ] 上一次修改的结尾处
-- h: last-position-jump
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
        api.nvim_win_set_cursor(0, { position[1], position[2] + 1 })
        -- require('global').dump(position)
        -- require('global').put(position)
      end
    end
  })
end

local function map_q_to_quit()
  api.nvim_create_autocmd("FileType", {
    pattern = { 'help', 'qf', 'netrw', 'startuptime', 'git', 'notify' },
    callback = function()
      -- api.nvim_buf_set_keymap(0, 'n', 'q', '<CMD>q<CR>', {noremap = true})
      vim.keymap.set('n', 'q', '<CMD>q<CR>', { buffer = true, silent = true })
    end
  })
end

local function map_fugitiv_q_2_quit()
  api.nvim_create_autocmd("FileType", {
    pattern = 'fugitive',
    callback = function()
      -- api.nvim_buf_set_keymap(0, 'n', 'q', 'gq', {})
      vim.keymap.set('n', 'q', 'gq', { buffer = true, remap = true, silent = true })
    end
  })
end

local function help_mouse()
  cmd [[ autocmd! BufEnter *.txt lua require('futil'):set_mouse() ]]
  cmd [[ autocmd! BufLeave *.txt lua require('futil'):restore_mouse() ]]
end

-- local function map_wq_to_quit()
--     cmd [[ autocmd! FileType gitcommit :nnoremap <buffer> q <CMD>wq<CR> ]]
-- end
local function map_wq_to_quit()
  api.nvim_create_autocmd("FileType", {
    pattern = "gitcommit",
    callback = function()
      -- api.nvim_buf_set_keymap(0, "n", "q", "<CMD>wq<CR>", {noremap = true})
      vim.keymap.set('n', 'q', '<CMD>wq<CR>', { buffer = true })
      -- return true -- look ':help nvim_create_autocmd' return true to delete this autocmd
    end
  })
end

local function map_find_q_quit()
  api.nvim_create_autocmd("FileType", {
    pattern = "find",
    callback = function()
      api.nvim_buf_set_keymap(0, 'n', 'q', '<CMD>Hi /close<CR>', { noremap = true })
    end
  })
end

local function map_quit_code_runner()
  api.nvim_create_autocmd('WinEnter', {
    pattern = '*',
    callback = function(arg)
      -- vim.pretty_print(arg)
      if string.match(arg.file, 'crunner_') and not api.nvim_buf_get_option(arg.buf, 'buflisted') then
        vim.keymap.set('n', 'q', ':q<CR>', { noremap = true, silent = true, buffer = true })
      end
    end
  })
end

local function disable_auto_comment()
  -- "禁止vim换行后自动添加的注释符号
  cmd [[ augroup Format-Options ]]
  cmd [[ autocmd! ]]
  -- https://superuser.com/questions/271023/can-i-disable-continuation-of-comments-to-the-next-line-in-vim
  -- "autocmd BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  -- " This can be done as well instead of the previous line, for setting formatoptions as you choose:
  cmd [[ autocmd BufEnter * setlocal formatoptions-=cro ]]
  -- "让vim显示行尾的空格
  -- "autocmd BufEnter * highlight WhitespaceEOL ctermbg=red guibg=red
  -- "autocmd BufEnter * match WhitespaceEOL /\s\+$/
  cmd [[ augroup END ]]
end

local function highlight_yank()
  cmd [[ au TextYankPost * silent! lua vim.highlight.on_yank({timeout = 1000}) ]]
end

local function skip_nvimtree()
  local includes = { 'qf', 'fugitive', 'help', 'noice' }

  api.nvim_create_autocmd('WinEnter', {
    pattern = '*',
    callback = function(arg)
      local last_win_buf = vim.g.last_win_buf
      if api.nvim_buf_get_option(arg.buf, 'filetype') == 'NvimTree' and last_win_buf then
        if vim.tbl_contains(includes, last_win_buf.filetype) or
            (last_win_buf.file and string.match(last_win_buf.file, 'crunner_') and last_win_buf.filetype == '') then
          local winnrs = api.nvim_list_wins()
          for _, winnr in ipairs(winnrs) do
            local bufnr = api.nvim_win_get_buf(winnr)
            if string.len(api.nvim_buf_get_name(bufnr)) ~= 0 and api.nvim_buf_get_option(bufnr, 'buflisted') then
              api.nvim_set_current_win(winnr)
            end
          end
        end
      end
      vim.g.last_win_buf = nil
    end
  })

  vim.api.nvim_create_autocmd('WinLeave', {
    pattern = '*',
    callback = function(arg)
      vim.g.last_win_buf = {
        bufnr = arg.buf,
        file = arg.file,
        filetype = vim.bo.filetype,
      }
    end
  })
end

-- 终端中 <C-j> 来跳转到 buffer 所在目录来使用
local function terminal_c_j()
  vim.api.nvim_create_autocmd('WinLeave', {
    pattern = '*',
    callback = function(arg)
      vim.g.last_c_j = {
        file = arg.file,
        buflisted = vim.api.nvim_buf_get_option(0, 'buflisted')
      }
    end
  })
end

function autocmd.setup()
  goto_last_position()
  map_q_to_quit()
  map_find_q_quit()
  map_wq_to_quit()
  help_mouse()
  disable_auto_comment()
  map_fugitiv_q_2_quit()
  highlight_yank()
  -- golang_autocmd()
  map_quit_code_runner()
  skip_nvimtree()
  terminal_c_j()
end

autocmd.setup()
