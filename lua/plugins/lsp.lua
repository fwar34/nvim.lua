local cmd = vim.cmd
return {
  {
    -- lsp installer
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup()
    end
  },
  -- Lsp
  { 'neovim/nvim-lspconfig' },
  {
    'lukas-reineke/cmp-rg'
  },
  {
    'quangnguyen30192/cmp-nvim-tags',
    -- if you want the sources is available for some file types
    ft = { 'kotlin', 'java', 'cpp', 'lua', 'bash', 'c', 'rust', 'go', 'python', }
  },
  {
    'hrsh7th/nvim-cmp',
    -- event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'L3MON4D3/LuaSnip'
    },
    config = function()
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and
            vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      local luasnip = require("luasnip")

      -- Setup nvim-cmp.
      local cmp = require 'cmp'
      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-u>'] = cmp.mapping.scroll_docs( -4), -- Up
          ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable( -1) then
              luasnip.jump( -1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable( -1) then
              luasnip.jump( -1)
            else
              fallback()
            end
          end, { "i", "s" }),
          -- ... Your other mappings ...
          -- ['<C-B>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
          -- ['<C-F>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
          ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
          ['<C-g>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<C-b>'] = function(fallback)
            if cmp.visible() then
              cmp.close()
              -- cmd[[normal h]]
              local row, col = unpack(vim.api.nvim_win_get_cursor(0))
              vim.api.nvim_win_set_cursor(0, { row, col == 0 and 0 or col - 1 })
            else
              fallback()
            end
          end,
          ['<C-f>'] = function(fallback)
            if cmp.visible() then
              cmp.close()
              -- cmd[[normal l]]
              local row, col = unpack(vim.api.nvim_win_get_cursor(0))
              vim.api.nvim_win_set_cursor(0, { row, col + 1 })
            else
              fallback()
            end
          end,
          ['<C-e>'] = function(fallback)
            if cmp.visible() then
              cmp.close()
              cmd [[normal $]]
              local position = vim.api.nvim_win_get_cursor(0)
              -- local line, col = unpack(vim.api.nvim_win_get_cursor(0))
              -- print(vim.inspect(position))
              vim.api.nvim_win_set_cursor(0, { position[1], position[2] + 1 })
              -- local position = vim.api.nvim_win_get_cursor(0)
              -- print(vim.inspect(position))
            else
              -- 默认 Ctrl+e 取消本次补全
              fallback()
            end
          end,
          ['<C-a>'] = function(fallback)
            if cmp.visible() then
              cmp.close()
              cmd [[normal ^]]
            else
              fallback()
            end
          end,
        }),
        -- sources = cmp.config.sources({
        -- 	{ name = 'buffer' },
        -- { name = 'tags' },
        -- 	{ name = 'nvim_lsp' },
        -- 	-- { name = 'vsnip' }, -- For vsnip users.
        -- 	{ name = 'luasnip' }, -- For luasnip users.
        -- 	-- { name = 'ultisnips' }, -- For ultisnips users.
        -- 	-- { name = 'snippy' }, -- For snippy users.
        -- { name = 'nvim_lsp_signature_help' },
        -- { name = 'path' },
        -- }
        -- -- {
        -- 	-- { name = 'buffer' },
        -- -- }
        -- )

        sources = cmp.config.sources(
          {
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
            -- { name = 'vsnip' }, -- For vsnip users.
            { name = 'luasnip' }, -- For luasnip users.
            -- { name = 'ultisnips' }, -- For ultisnips users.
            -- { name = 'snippy' }, -- For snippy users.
            { name = 'path' },
          },
          {
            { name = 'buffer' },
            { name = 'tags' },
            { name = 'orgmode' },
            {
              name = "rg",
              -- Try it when you feel cmp performance is poor
              -- keyword_length = 3
            },
          }
        )
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      -- cmp.setup.cmdline('/', {
      -- 	sources = {
      -- 		{ name = 'buffer' }
      -- 	}
      -- })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      -- cmp.setup.cmdline(':', {
      -- 	sources = cmp.config.sources({
      -- 		{ name = 'path' }
      -- 	}, {
      -- 		{ name = 'cmdline' }
      -- 	})
      -- })
    end
  },
}
