-- https://teukka.tech/posts/2020-01-07-vimloop/
local loop = vim.loop
local api = vim.api
local M = {}
local results = {}

local function onread(err, data)
    if err then
        return
    end
    if data then
        table.insert(results, data)
    end
end

function M.asyncGrep(term)
    local stdout = loop.new_pipe(false)
    local stderr = loop.new_pipe(false)
    local function setQF()
        vim.fn.setqflist({}, 'r', {title = 'Search Results', lines = results})
        api.nvim_command('cwindow')
        local count = #results
        for i = 0, count do -- clear the table for next search
            results[i] = nil
        end
    end

    Handle = loop.spawn('rg', {
        args = {term, '--vimgrep', '--smart-case'},
        stdio = {nil, stdout, stderr}
    },
    vim.schedule_wrap(function ()
        stdout:read_stop()
        stderr:read_stop()
        stdout:close()
        stderr:close()
        Handle:close()
        setQF()
    end))
    loop.read_start(stdout, onread)
    loop.read_start(stderr, onread)
end

return M
