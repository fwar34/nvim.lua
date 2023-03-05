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
    print('---------------------')
    local tb = {a = {'1.cpp', '2.cpp'}}
    print(vim.tbl_contains(tb['a'], '1.cpp'))
    tb['a'] = {}
    vim.pretty_print(tb)
    print('---------------------')
    print(tb[nil])
end

local function test_autocmd()
    vim.api.nvim_create_autocmd('BufEnter',
    {
        pattern = '*',
        callback = function (arg)
            if vim.fs.basename(arg.file) == 'basic.lua' then
                vim.pretty_print(arg)
            end
        end
    })
end

local function test_insert()
    print('test_insert:')
    local tb = {4, 3}
    table.insert(tb, 1, 5)
    vim.pretty_print(tb)
end

test_tbl_contains()
test_autocmd()
test_insert()

for _, v in pairs({'2.cpp', '1.lua'}) do
    print(v)
end
