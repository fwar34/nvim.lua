local cmd = vim.cmd

return {
  {
    "folke/which-key.nvim",
    -- enabled = false,
    event = 'VeryLazy',
    -- version = 'v1.1.1',
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      local wk = require('which-key')
      wk.setup({
        show_help = false,
        show_keys = false,
      })
      -------------------------------------------------------------------------------------
      wk.register({
        ['<leader>lz'] = { '<CMD>Lazy<CR>', 'Lazy' },
        ['<leader>tz'] = { '<CMD>Telescope lazy<CR>', 'Telescope lazy' },
        ['<leader>tm'] = {
          function()
            -- if string.len(vim.api.nvim_buf_get_name(0)) ~= 0 then
            --   vim.g.cwd = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
            -- else
            --   vim.g.cwd = vim.fn.cwd()
            -- end

            cmd('ToggleTerm')
          end, 'ToggleTerm' },
        ['<leader>t'] = { m = { '<CMD>ToggleTerm<CR>', 'ToggleTerm', mode = 't' } },
        ['<C-j>'] = {
          function()
            local c_j = vim.g.last_c_j
            if c_j and c_j.file and string.len(c_j.file) ~= 0 and c_j.buflisted then
              vim.api.nvim_input('cd ' .. vim.fs.dirname(c_j.file) .. '<CR>')
            else
              print('vim.g.last_c_j is nil')
            end
          end,
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
          s = { function ()
            if vim.w.HiJump then
              vim.cmd('Hi save')
            end
          end, 'Hi save' },
          l = { '<CMD>Hi load<CR>', 'Hi load' },
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
