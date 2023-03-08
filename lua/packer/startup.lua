vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
  use {
    'wbthomason/packer.nvim', opt = true,
  }

  use({
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
        -- add any options here
      })
    end,
    requires = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  })
end) -- Packer
