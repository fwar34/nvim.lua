return {
  {
    'iamcco/markdown-preview.nvim',
    enabled = require('global').is_windows,
    -- 在 windows 上面可能安装失败，需要手动去目录里面安装
    build = 'cd app && yarn install',
    ft = 'markdown',
  },
  {
    'toppair/peek.nvim',
    enabled = not require('global').is_windows,
    build = 'deno task --quiet build:fast',
    ft = 'markdown',
    config = function()
      -- require('peek').setup({
      --     app = 'browser'
      -- })
      vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
      vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
    end
  }
}
