-- local is_windows = require('global').is_windows
return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        --[[ Mappings	Action
                <C-o>   Open selected plugin repository in browser
                <M-b>   Open selected plugin with file-browser
                <C-f>   Open selected plugin with find files
                <C-g>   Open selected plugin with live grep
                <C-b>   Open lazy plugins picker, works only after having called first another action
                <C-r>f  Open lazy root with find files
                <C-r>g  Open lazy root with live grep ]]
        'tsakirist/telescope-lazy.nvim',
        config = function()
          require("telescope").load_extension "lazy"
        end
      },

      {
        -- native telescope bindings to zf for sorting results
        "natecraddock/telescope-zf-native.nvim",
        config = function()
          require("telescope").load_extension("zf-native")
        end
      },
      {
        'nvim-telescope/telescope-live-grep-args.nvim',
        config = function()
          require("telescope").load_extension("live_grep_args")
        end,
      },
      {
        'debugloop/telescope-undo.nvim',
        config = function()
          require("telescope").load_extension("undo")
        end
      },
    },
    config = function()
      local use_devicons = function()
        if require('global').hostname == 'ubuntu-work' then
          return false
        else
          return true
        end
      end

      -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#pickers
      local telescopeConfig = require("telescope.config")
      -- Clone the default Telescope configuration
      local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

      -- I want to search in hidden/dot files.
      table.insert(vimgrep_arguments, "--hidden")
      -- I don't want to search in the `.git` directory.
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.git/*")
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/debian/*")
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.svn/*")
      table.insert(vimgrep_arguments, "--iglob")
      table.insert(vimgrep_arguments, "!makefile")
      table.insert(vimgrep_arguments, "--iglob")
      table.insert(vimgrep_arguments, "!*.log")
      table.insert(vimgrep_arguments, "--iglob")
      table.insert(vimgrep_arguments, "!tags")
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!INSTALL")
      table.insert(vimgrep_arguments, "--iglob")
      table.insert(vimgrep_arguments, "!*.lo")
      table.insert(vimgrep_arguments, "--iglob")
      table.insert(vimgrep_arguments, "!*.diff")
      table.insert(vimgrep_arguments, "--iglob")
      table.insert(vimgrep_arguments, "!*.makefile")
      table.insert(vimgrep_arguments, "--iglob")
      table.insert(vimgrep_arguments, "!*.tag")
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/doxygen-doc/*")
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!*.vcxproj")
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!*.vcxproj.filters")
      table.insert(vimgrep_arguments, "--iglob")
      table.insert(vimgrep_arguments, "!makefile.am")
      table.insert(vimgrep_arguments, "--iglob")
      table.insert(vimgrep_arguments, "!makefile.in")
      table.insert(vimgrep_arguments, "--iglob")
      table.insert(vimgrep_arguments, "!libtool")
      table.insert(vimgrep_arguments, "--iglob")
      table.insert(vimgrep_arguments, "!config.status")

      -- You dont need to set any of these options. These are the default ones. Only
      -- the loading is important
      require('telescope').setup {
        defaults = {
          -- Default configuration for telescope goes here:
          -- config_key = value,
          -- `hidden = true` is not supported in text grep commands.
          vimgrep_arguments = vimgrep_arguments,
          mappings = {
            i = {
              -- map actions.which_key to <C-h> (default: <C-/>)
              -- actions.which_key shows the mappings for your picker,
              -- e.g. git_{create, delete, ...}_branch for the git_branches picker
              ["<C-h>"] = "which_key",
              -- ["<C-g>"] = "close",
              ["<C-g>"] = require('telescope.actions').close,
            },
            n = {
              -- ["<C-g>"] = "close",
              ["<C-g>"] = require('telescope.actions').close,
            }
          },

          -- layout_strategy = 'vertical',
          -- layout_config = { height = 0.95 },
          color_devicons = use_devicons(),
        },
        -- vimgrep_arguments = {
        --   "rg",
        --   "--color=never",
        --   "--no-heading",
        --   "--with-filename",
        --   "--line-number",
        --   "--column",
        --   "--smart-case",
        --   "--trim",
        --   -- "--hidden",
        -- },
        -- file_ignore_patterns = {},
        -- pickers = {
        --   find_files = {
        --     -- find_command = { "fd", "--type=file", "--hidden", "--smart-case" },
        --     theme = 'ivy',
        --   },
        --   live_grep = {
        --     --@usage don't include the filename in the search results
        --     -- only_sort_text = true,
        --     theme = 'ivy',
        --   },
        --   grep_string = {
        --     theme = 'ivy'
        --   }
        -- },
        extensions = {
          -- fzf = {
          --     fuzzy = true,                    -- false will only do exact matching
          --     override_generic_sorter = true,  -- override the generic sorter
          --     override_file_sorter = true,     -- override the file sorter
          --     case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
          --     -- the default case_mode is "smart_case"
          -- },
          -- undo = {
          --     side_by_side = true,
          --     layout_strategy = "horizontal",
          --     -- layout_config = {
          --     --     preview_height = 0.4,
          --     -- },
          -- },
          ["zf-native"] = {
            -- options for sorting file-like items
            file = {
              -- override default telescope file sorter
              enable = true,
              -- highlight matching text in results
              highlight_results = true,
              -- enable zf filename match priority
              match_filename = true,
            },
            -- options for sorting all other items
            generic = {
              -- override default telescope generic item sorter
              enable = true,
              -- highlight matching text in results
              highlight_results = true,
              -- disable zf filename match priority
              match_filename = false,
            },
          }
        }
      }
    end,
  },
}
