local function test_tbl_contains()
    local buffer_contents = {[3] = {buffer_name = '~/test.lua', buffer_groups = {'dev', 'trunk'}}}
    vim.pretty_print(vim.tbl_get(buffer_contents, 3))
    buffer_contents[4] = {test = 'test'}
    vim.pretty_print(buffer_contents[4])

    buffer_contents[4] = nil

    print('---------------------')
    for k, v in pairs(buffer_contents) do
        print('k:' .. k .. ' ')
        vim.pretty_print(v)
    end
end

local function test_autocmd()
    vim.api.nvim_create_autocmd('BufEnter',
    {
        pattern = '*',
        callback = function (arg)
            vim.pretty_print(arg)
        end
    })
end

test_tbl_contains()
test_autocmd()
