local M = {}
local cmd = vim.cmd

local function find_go_mod()
  local output = vim.fn.execute('!ls')
  for line in string.gmatch(output, '[%a%./]*\n') do
    if line == 'go.mod\n' then
      return true
    end
  end
  return false
end

function M.run()
  local switch = {
    go = function()
      if find_go_mod() then
        -- cmd [[AsyncRun go mod tidy && go run %]]
        cmd('AsyncRun go mod tidy && go run %')
      else
        cmd [[AsyncRun go run %]]
      end
    end,
    cpp = function()
      cmd [[AsyncRun g++ -std=c++11 -lpthread % && ./a.out]]
    end,
    lua = function()
      cmd [[AsyncRun lua %]]
    end,
    c = function()
      cmd [[AsyncRun gcc % && ./a.out]]
    end,
    python = function()
      cmd [[AsyncRun python3 %]]
    end,
    rust = function()
      cmd [[AsyncRun cargo run]]
    end,
  }

  local func = switch[vim.bo.filetype]
  if func ~= nil then
    func()
  end
end

return M
