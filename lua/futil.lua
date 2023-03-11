local global = require('global')
local futil = { mouse_help = '', mouse_g = '' }
local vim = vim
local api = vim.api
local cmd = vim.cmd

function futil.toggle_line_number()
  if vim.wo.number then
    cmd('set nonumber')
    -- cmd('set norelativenumber')
  else
    cmd('set number')
    -- cmd('set relativenumber')
    global.dump(vim.bo.filetype)
  end
end

function futil:set_mouse()
  if vim.bo.filetype == 'help' then
    self.mouse_help = vim.o.mouse
    vim.o.mouse = 'n'
  end
end

function futil:restore_mouse()
  if vim.bo.filetype == 'help' then
    vim.o.mouse = self.mouse_help
  end
end

function futil.toggle_mouse()
  if vim.o.mouse == 'a' then
    vim.o.mouse = ''
    print('set mouse=')
  else
    vim.o.mouse = 'a'
    print('set mouse = a')
  end
end

function futil.make_fennel()
  local cur_pwd = vim.fn.getcwd()
  cmd('tcd ~/.config/nvim/lua/')
  vim.fn.execute('!make', '')
  cmd('tcd ' .. cur_pwd)
end

function futil.search_word()
  cmd('normal ye')
  cmd('Ag ' .. vim.fn.getreg('0'))
end

function futil.coc_status()
  print(vim.fn['coc#status']())
end

-- reference from help : restore-position
function futil.display_function()
  -- get mark s info
  local mark_s = vim.fn.getpos("'X")
  local mark_t = vim.fn.getpos("'Y")
  -- get cursor info
  local cur_pos = vim.fn.getcurpos()
  if mark_s[2] ~= cur_pos[2] then
    vim.fn.setpos("'X", cur_pos)
  end
  -- cmd('normal H')
  -- get cursor info
  cur_pos = vim.fn.getcurpos()
  if mark_t[2] ~= cur_pos[2] then
    vim.fn.setpos("'Y", cur_pos)
  end
  cmd('normal `X[[k')
  local func_name = vim.fn.getline('.')
  cmd("normal 'Yzt`X")
  print(func_name)
end

function futil.find_previous_brace_in_first_column()
  local current = vim.fn.getpos('.')
  local line_num = current[2]
  repeat
    local current_line_array = api.nvim_buf_get_lines(0, line_num, line_num + 1, false) -- nvim_buf_get_lines 行数从0开始，左闭右开
    local current_line = current_line_array[1]
    if current_line ~= nil and string.sub(current_line, 1, 1) == '{' and line_num - 1 >= 0 then
      local ret_line = api.nvim_buf_get_lines(0, line_num - 1, line_num, false)
      -- print(ret_line[1])
      vim.cmd('echohl String| echo "' .. ret_line[1] .. '" | echohl None')
      return
    end
    line_num = line_num - 1
  until line_num < 0
  print('not found { in first column!')
end

function futil.delete_buffers(exclude_current)
  local buffers = api.nvim_list_bufs()
  local current = api.nvim_get_current_buf()
  -- print("list:", vim.inspect(buffers), "current:", current)

  for _, buf in ipairs(buffers) do
    if api.nvim_buf_is_valid(buf) and api.nvim_buf_get_option(buf, 'buflisted') then
      -- vim.pretty_print('buf:' .. api.nvim_buf_get_name(buf) .. ' is load:' .. (vim.api.nvim_buf_is_loaded(buf) and 1 or 0) .. ' ft:' .. api.nvim_buf_get_option(buf, 'filetype'))
      local ft = api.nvim_buf_get_option(buf, 'filetype')
      -- local buf_name_len = string.len(api.nvim_buf_get_name(buf))
      if ft ~= 'floaterm' and ft ~= 'rnvimr' and ft ~= 'toggleterm' then
        if exclude_current then
          if buf ~= current then
            api.nvim_buf_delete(buf, {})
          end
        else
          api.nvim_buf_delete(buf, {})
        end
      end
    end
  end
end

function futil.dump_all_buffers()
  local total_len = 0
  local listed_len = 0
  local buffers = api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    vim.pretty_print('buf num:' .. buf ..
    ' name:' .. api.nvim_buf_get_name(buf) ..
    ' is load:' .. (api.nvim_buf_is_loaded(buf) and 1 or 0) ..
    ' buflisted:' .. (api.nvim_buf_get_option(buf, 'buflisted') and 1 or 0) ..
    ' ft:' .. api.nvim_buf_get_option(buf, 'filetype') ..
    ' valid:' .. (api.nvim_buf_is_valid(buf) and 1 or 0))
    if api.nvim_buf_get_option(buf, 'buflisted') then
      listed_len = listed_len + 1
    end
    total_len = total_len + 1
  end
  vim.notify(string.format('total buffers len(%u) listed buffers len(%u)', total_len, listed_len))
end

function futil.is_filetype_buffer_listed(filetype)
  for _, bufnr in ipairs(api.nvim_list_bufs()) do
    if api.nvim_buf_get_option(bufnr, 'filetype') == filetype and api.nvim_buf_get_option(bufnr, 'buflisted') then
      return true
    end
  end
  return false
end

api.nvim_create_user_command('DumpBuffers', futil.dump_all_buffers, {})
cmd('ca db DumpBuffers')

function futil.info(opts, ...)
  if type(opts) == "table" then
    vim.notify(string.format(...), vim.log.levels.INFO, opts)
  else
    vim.notify(string.format(opts, ...), vim.log.levels.INFO)
  end
end

function futil.warn(opts, ...)
  if type(opts) == "table" then
    vim.notify(string.format(...), vim.log.levels.WARN, opts)
  else
    vim.notify(string.format(opts, ...), vim.log.levels.WARN)
  end
end

function futil.err(opts, ...)
  if type(opts) == "table" then
    vim.notify(string.format(...), vim.log.levels.ERROR, opts)
  else
    vim.notify(string.format(opts, ...), vim.log.levels.ERROR)
  end
end

function futil.debug(opts, ...)
  if type(opts) == "table" then
    vim.notify(string.format(...), vim.log.levels.DEBUG, opts)
  else
    vim.notify(string.format(opts, ...), vim.log.levels.DEBUG)
  end
end

function futil.put(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, '\n'))
  return ...
end

function futil.delete_other_window(excludes, includes)
  for _, winnr in ipairs(api.nvim_list_wins()) do
    if winnr ~= api.nvim_get_current_win() then
      local bufnr = api.nvim_win_get_buf(winnr)
      if string.len(api.nvim_buf_get_name(bufnr)) ~= 0 then
        if not excludes then
          api.nvim_win_close(winnr, false)
        else
          if not vim.tbl_contains(excludes, api.nvim_buf_get_option(bufnr, 'filetype')) then
            api.nvim_win_close(winnr, false)
          end
        end
      else
        if includes and vim.tbl_contains(includes, api.nvim_buf_get_option(bufnr, 'filetype')) then
          api.nvim_win_close(winnr, false)
        end
      end
    end
  end
end

local function dump_win_bufs()
  local winnrs = vim.api.nvim_list_wins()
  for _, winnr in ipairs(winnrs) do
    local bufnr = vim.api.nvim_win_get_buf(winnr)
    vim.pretty_print('winnr num:' .. winnr ..
    ' bufnr num:' .. bufnr ..
    ' name:' .. api.nvim_buf_get_name(bufnr) ..
    ' is load:' .. (api.nvim_buf_is_loaded(bufnr) and 1 or 0) ..
    ' buflisted:' .. (api.nvim_buf_get_option(bufnr, 'buflisted') and 1 or 0) ..
    ' ft:' .. api.nvim_buf_get_option(bufnr, 'filetype') ..
    ' valid:' .. (api.nvim_buf_is_valid(bufnr) and 1 or 0))
  end
end
api.nvim_create_user_command('DumpWins', dump_win_bufs, {})

local function dump_parents_dir()
  for dir in vim.fs.parents(vim.api.nvim_buf_get_name(0)) do
    print(dir)
  end
end
api.nvim_create_user_command('DumpParents', dump_parents_dir, {})

return futil
