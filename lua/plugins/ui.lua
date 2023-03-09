-- https://github.com/akinsho/dotfiles/blob/5bff061ba44082af40045fcbc3e4d0597fe4f1d9/.config/nvim/lua/as/plugins/noice.lua
return {
  {
    'rcarriga/nvim-notify',
    enabled = vim.g.neovide,
    config = function()
      vim.notify = require('notify')
    end
  },
  {
    'folke/noice.nvim',
    enabled = not vim.g.neovide,
    -- enabled = false,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
    opts = {
      lsp = {
        -- override markdown rendering so that cmp and other plugins use Treesitter
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
      views = {
        cmdline_popup = {
          position = {
            row = 10,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 13,
            col = "50%",
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
          },
        },
      },
      routes = {
        {
          opts = { skip = true },
          filter = {
            any = {
              { event = 'msg_show', find = 'written' },
              { event = 'msg_show', find = '%d+ lines, %d+ bytes' },
              { event = 'msg_show', kind = 'search_count' },
              { event = 'msg_show', find = '%d+L, %d+B' },
              { event = 'msg_show', find = '^Hunk %d+ of %d' },
              -- TODO: investigate the source of this LSP message and disable it happens in typescript files
              { event = 'notify',   find = 'No information available' },
            },
          },
        },
      },
    },
    config = function(_, opts)
      require("noice").setup(opts)
      require("telescope").load_extension("noice")
    end
  }
}
