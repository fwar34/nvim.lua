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

return M
