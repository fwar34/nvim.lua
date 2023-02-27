local M = {}

function M.config_whichkey()
    local cmd = vim.cmd
    local wk = require('which-key')
    wk.register({
        ['<leader>lz'] = { '<CMD>Lazy<CR>', 'Lazy' },
        ['<leader>tz'] = { '<CMD>Telescope lazy<CR>', 'Telescope lazy' },
        ['<leader>tm'] = { function()
            vim.g.cwd = vim.fn.getcwd()
            cmd('ToggleTerm')
        end, 'ToggleTerm' },
        ['<leader>t'] = { m = { '<CMD>ToggleTerm<CR>', 'ToggleTerm', mode = 't' } },
        ['<C-j>'] = { function() vim.api.nvim_input('cd ' .. vim.g.cwd .. '<CR>') end, 'jump to directory of buffer', mode = 't' },
        ['<leader>rc'] = { '<CMD>RunCode<CR>', 'code_runner.nvim' },
        ['<leader>mt'] = { '<CMD>MarkdownPreviewToggle<CR>', 'markdown preview toggle' },
        ['<leader>s'] = {
            s = { '<CMD>Hi save save.hl<CR>', 'Hi save save.hl' },
            l = { '<CMD>Hi load save.hl<CR>', 'Hi load save.hl' },
        },
        ['<F10>'] = {
            function ()
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
            mode = {'n', 'v', 'i'}
        }
    }, { mode = { 'n', 'v' } })
end

return M
