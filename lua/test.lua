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

local function test_tabpage()
    vim.pretty_print(vim.fn.tabpagebuflist())
    -- local current_bufnr = vim.api.nvim_get_current_buf()
    -- vim.api.nvim_buf_delete(current_bufnr, {})
    vim.api.nvim_create_user_command('TK', function ()
        test_tabpage()
    end, {})
end

local function test_winbar()
    vim.wo.winbar = 'test.cpp test.lua'
    print(vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), 'filetype'))
    if vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), 'filetype') == 'toggleterm' then
        vim.wo.winbar = 'toggleterm'
        print('xxxxxxxxx')
    end
    vim.cmd('redraws')
end
vim.api.nvim_create_user_command('TW', function ()
    test_winbar()
end, {})

-- test_tbl_contains()
-- test_autocmd()
-- test_insert()

for _, v in pairs({'2.cpp', '1.lua'}) do
    print(v)
end
