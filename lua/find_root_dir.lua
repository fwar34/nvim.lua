local M = {}
local function find_in_table(data)
    local dest = {'.svn', '.git', '.root', '.bzr', '_darcs', 'build.xml', 'pom.xml'}
    for _, v in ipairs(dest) do
        if v .. '\n' == data then
            return true
        end
    end
    return false
end

function M.find_root_dir()
    local org_pwd = vim.fn.getcwd()
    local dir = org_pwd

    while (dir ~= vim.env.HOME) do
        local output = vim.fn.execute('!ls -a ' .. dir)
        -- print("output->", output)
        for line in string.gmatch(output, "[%.%a/]*\n") do
            if find_in_table(line) then
                -- print("begin ---")
                -- print(line)
                -- print("end ---")
                -- ['n|<Leader>ff'] = '<CMD>lua require("telescope.builtin").find_files({find_command = find_files_args,})<CR>',
                -- require("telescope.builtin").find_files({cwd = dir, find_command = find_files_args,})
                if dir ~= org_pwd then
                    vim.cmd('cd ' .. org_pwd)
                end
                return dir
            end
        end

        vim.cmd('cd ..')
        dir = vim.fn.getcwd()
    end

    vim.cmd('cd ' .. org_pwd)
    return dir
end

return M
