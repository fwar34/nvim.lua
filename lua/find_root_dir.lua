local M = {}

local function is_root_directory(dir)
  local dest = { '.svn', '.git', '.root', '.bzr', '_darcs', 'build.xml', 'pom.xml' }
  for _, f in ipairs(dest) do
    if vim.fn.isdirectory(dir .. "/" .. f) == 1 then
      return true
    end
  end
  return false
end
function M.find_root_dir()
  for dir in vim.fs.parents(vim.api.nvim_buf_get_name(0)) do
    if is_root_directory(dir) then
      return dir
    end
  end
end

-- 使用 finddir
function M.find_root_dir2()
  local names = { '.svn', '.git', '.root', '.bzr', '_darcs', 'build.xml', 'pom.xml' }
  for _, name in ipairs(names) do
    if vim.fn.finddir(name, '.;') then
      return vim.fn.fnamemodify(name, ':h')
    end
  end
end

return M
