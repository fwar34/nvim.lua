local M = {}

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
                vim.cmd [[AsyncRun go mod tidy && go run %]]
            else
                vim.cmd [[AsyncRun go run %]]
            end
        end,
        cpp = function()
            vim.cmd [[AsyncRun g++ -std=c++11 -lpthread % && ./a.out]]
        end,
        lua = function()
            vim.cmd [[AsyncRun lua %]]
        end,
        c = function()
            vim.cmd [[AsyncRun gcc % && ./a.out]]
        end,
        python = function()
            vim.cmd [[AsyncRun python3 %]]
        end,
        rust = function()
            vim.cmd [[AsyncRun cargo run]]
        end,
    }

    local func = switch[vim.bo.filetype]
    if func ~= nil then
        func()
    end
end

return M
