local cmd = vim.cmd

return {
    {
        "folke/which-key.nvim",
        event = 'VeryLazy',
        -- version = 'v1.1.1',
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            local wk = require('which-key')
            wk.setup()
            -------------------------------------------------------------------------------------
            wk.register({
                ['<leader>lz'] = { '<CMD>Lazy<CR>', 'Lazy' },
                ['<leader>tz'] = { '<CMD>Telescope lazy<CR>', 'Telescope lazy' },
                ['<leader>tm'] = { function()
                    vim.g.cwd = vim.fn.getcwd()
                    cmd('ToggleTerm')
                end, 'ToggleTerm' },
                ['<leader>t'] = { m = { '<CMD>ToggleTerm<CR>', 'ToggleTerm', mode = 't' } },
                ['<C-j>'] = { function() vim.api.nvim_input('cd ' .. vim.g.cwd .. '<CR>') end,
                    'jump to directory of buffer', mode = 't' },
                ['<leader>rc'] = { '<CMD>RunCode<CR>', 'code_runner.nvim' },
                ['<leader>mt'] = { function()
                    if require('global').is_windows then
                        cmd('MarkdownPreviewToggle')
                    else
                        local peek = require('peek')
                        if peek.is_open() then
                            peek.close()
                        else
                            peek.open()
                        end
                    end
                end, 'markdown preview toggle' },
                ['<leader>s'] = {
                    s = { '<CMD>Hi save save.hl<CR>', 'Hi save save.hl' },
                    l = { '<CMD>Hi load save.hl<CR>', 'Hi load save.hl' },
                },
                ['<F10>'] = {
                    function()
                        if require('global').is_windows then
                            if vim.g.IsWin32yankActive then
                                vim.opt.clipboard:remove('unnamedplus')
                            else
                                vim.opt.clipboard:append('unnamedplus')
                            end
                            vim.g.IsWin32yankActive = not vim.g.IsWin32yankActive
                        end
                    end,
                    'toggle win32yank',
                    mode = { 'n', 'v', 'i' }
                }
            }, { mode = { 'n', 'v' } })
        end
    },
}
