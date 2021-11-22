-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/feng/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/feng/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/feng/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/feng/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/feng/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["BetterLua.vim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/BetterLua.vim",
    url = "https://github.com/euclidianAce/BetterLua.vim"
  },
  LuaSnip = {
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["asyncrun.vim"] = {
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/asyncrun.vim",
    url = "https://github.com/skywind3000/asyncrun.vim"
  },
  ["asynctasks.vim"] = {
    config = { "\27LJ\2\2/\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\6\0=\1\2\0K\0\1\0\18asyncrun_open\6g\bvim\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/asynctasks.vim",
    url = "https://github.com/skywind3000/asynctasks.vim"
  },
  ["auto-pairs"] = {
    config = { "\27LJ\2\2�\1\0\0\2\0\3\0\0056\0\0\0009\0\1\0'\1\2\0B\0\2\1K\0\1\0�\1 au FileType lisp,clojure,lisp let b:AutoPairs = {'```': '```', '`': '`', '\"': '\"', '[': ']', '(': ')', '{': '}', '\"\"\"': '\"\"\"'} \bcmd\bvim\0" },
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/auto-pairs",
    url = "https://github.com/jiangmiao/auto-pairs"
  },
  ["awesome-cheatsheets"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/awesome-cheatsheets",
    url = "https://github.com/skywind3000/awesome-cheatsheets"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["colorbuddy.nvim"] = {
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/colorbuddy.nvim",
    url = "https://github.com/tjdevries/colorbuddy.nvim"
  },
  conjure = {
    config = { "\27LJ\2\2�\1\0\0\2\0\5\0\r6\0\0\0009\0\1\0'\1\2\0B\0\2\0016\0\0\0009\0\1\0'\1\3\0B\0\2\0016\0\0\0009\0\1\0'\1\4\0B\0\2\1K\0\1\0'let g:conjure#log#hud#height = 0.5&let g:conjure#log#hud#width = 0.8'let g:conjure#mapping#prefix = \",\"\bcmd\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/conjure",
    url = "https://github.com/Olical/conjure"
  },
  ["defx.nvim"] = {
    commands = { "Defx" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/defx.nvim",
    url = "https://github.com/Shougo/defx.nvim"
  },
  dracula = {
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/dracula",
    url = "https://github.com/dracula/vim"
  },
  ["fennel.vim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/fennel.vim",
    url = "https://github.com/bakpakin/fennel.vim"
  },
  fzf = {
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["git-messenger.vim"] = {
    commands = { "GitMessenger" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/git-messenger.vim",
    url = "https://github.com/rhysd/git-messenger.vim"
  },
  ["gruvbuddy.nvim"] = {
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/gruvbuddy.nvim",
    url = "https://github.com/tjdevries/gruvbuddy.nvim"
  },
  ["gundo.vim"] = {
    commands = { "GundoToggle" },
    config = { "vim.g.gundo_prefer_python3 = 1" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/gundo.vim",
    url = "https://github.com/sjl/gundo.vim"
  },
  gutentags_plus = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/gutentags_plus",
    url = "https://github.com/skywind3000/gutentags_plus"
  },
  ["iron.nvim"] = {
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/iron.nvim",
    url = "https://github.com/hkupty/iron.nvim"
  },
  ["lightline.vim"] = {
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/lightline.vim",
    url = "https://github.com/itchyny/lightline.vim"
  },
  ["markdown-preview.nvim"] = {
    commands = { "MarkdownPreview" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\2�\1\0\0\a\0\b\2!6\0\0\0006\1\1\0009\1\2\0019\1\3\1)\2\0\0B\1\2\0A\0\0\3\b\1\0\0X\2\20�6\2\1\0009\2\2\0029\2\4\2)\3\0\0\23\4\1\0\18\5\0\0+\6\2\0B\2\5\2:\2\1\2\18\3\2\0009\2\5\2\18\4\1\0\18\5\1\0B\2\4\2\18\3\2\0009\2\6\2'\4\a\0B\2\3\2\n\2\0\0X\2\2�+\2\1\0X\3\1�+\2\2\0L\2\2\0\a%s\nmatch\bsub\23nvim_buf_get_lines\24nvim_win_get_cursor\bapi\bvim\vunpack\0\2C\0\1\3\0\4\0\a6\1\0\0'\2\1\0B\1\2\0029\1\2\0019\2\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequire�\1\0\1\2\3\5\0\29-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4�-\1\0\0009\1\1\1B\1\1\1X\1\19�-\1\1\0009\1\2\1B\1\1\2\15\0\1\0X\2\4�-\1\1\0009\1\3\1B\1\1\1X\1\n�-\1\2\0B\1\1\2\15\0\1\0X\2\4�-\1\0\0009\1\4\1B\1\1\1X\1\2�\18\1\0\0B\1\1\1K\0\1\0\2�\1�\0�\rcomplete\19expand_or_jump\23expand_or_jumpable\21select_next_item\fvisible�\1\0\1\3\2\4\0\23-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4�-\1\0\0009\1\1\1B\1\1\1X\1\r�-\1\1\0009\1\2\1)\2��B\1\2\2\15\0\1\0X\2\5�-\1\1\0009\1\3\1)\2��B\1\2\1X\1\2�\18\1\0\0B\1\1\1K\0\1\0\2�\1�\tjump\rjumpable\21select_prev_item\fvisible�\5\1\0\n\0001\0i3\0\0\0006\1\1\0'\2\2\0B\1\2\0026\2\1\0'\3\3\0B\2\2\0029\3\4\0025\4\b\0005\5\6\0003\6\5\0=\6\a\5=\5\t\0045\5\r\0009\6\n\0023\a\v\0005\b\f\0B\6\3\2=\6\14\0059\6\n\0023\a\15\0005\b\16\0B\6\3\2=\6\17\0059\6\n\0029\a\n\0029\a\18\a)\b��B\a\2\0025\b\19\0B\6\3\2=\6\20\0059\6\n\0029\a\n\0029\a\18\a)\b\4\0B\a\2\0025\b\21\0B\6\3\2=\6\22\0059\6\n\0029\a\n\0029\a\23\aB\a\1\0025\b\24\0B\6\3\2=\6\25\0059\6\26\0029\6\27\6=\6\28\0059\6\n\0025\a\30\0009\b\n\0029\b\29\bB\b\1\2=\b\31\a9\b\n\0029\b \bB\b\1\2=\b!\aB\6\2\2=\6\"\0059\6\n\0029\6#\0065\a$\0B\6\2\2=\6%\5=\5\n\0049\5\26\0029\5&\0054\6\3\0005\a'\0>\a\1\0064\a\3\0005\b(\0>\b\1\aB\5\3\2=\5&\4B\3\2\0019\3\4\0029\3)\3'\4*\0005\5,\0004\6\3\0005\a+\0>\a\1\6=\6&\5B\3\3\0019\3\4\0029\3)\3'\4-\0005\0050\0009\6\26\0029\6&\0064\a\3\0005\b.\0>\b\1\a4\b\3\0005\t/\0>\t\1\bB\6\3\2=\6&\5B\3\3\0012\0\0�K\0\1\0\1\0\0\1\0\1\tname\fcmdline\1\0\1\tname\tpath\6:\1\0\0\1\0\1\tname\vbuffer\6/\fcmdline\1\0\1\tname\vbuffer\1\0\1\tname\fluasnip\fsources\t<CR>\1\0\1\vselect\2\fconfirm\n<C-g>\6c\nclose\6i\1\0\0\nabort\n<C-y>\fdisable\vconfig\14<C-Space>\1\3\0\0\6i\6c\rcomplete\n<C-f>\1\3\0\0\6i\6c\n<C-b>\1\3\0\0\6i\6c\16scroll_docs\f<S-Tab>\1\3\0\0\6i\6s\0\n<Tab>\1\0\0\1\3\0\0\6i\6s\0\fmapping\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\bcmp\fluasnip\frequire\0\0" },
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\0027\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["oceanic-material"] = {
    config = { "\27LJ\2\2B\0\0\2\0\3\0\0056\0\0\0009\0\1\0'\1\2\0B\0\2\1K\0\1\0# colorscheme oceanic_material \bcmd\bvim\0" },
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/oceanic-material",
    url = "https://github.com/glepnir/oceanic-material"
  },
  onebuddy = {
    config = { "\27LJ\2\2\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/onebuddy",
    url = "https://github.com/Th3Whit3Wolf/onebuddy"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["python-syntax"] = {
    config = { "\27LJ\2\0026\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\25python_highlight_all\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/python-syntax",
    url = "https://github.com/vim-python/python-syntax"
  },
  rainbow = {
    config = { "vim.g.rainbow_active = 1" },
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/rainbow",
    url = "https://github.com/luochen1990/rainbow"
  },
  rnvimr = {
    commands = { "RnvimrToggle" },
    config = { "\27LJ\2\2�\2\0\0\2\0\n\0\0256\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0006\0\0\0009\0\5\0'\1\6\0B\0\2\0016\0\0\0009\0\1\0)\1d\0=\1\a\0006\0\0\0009\0\1\0005\1\t\0=\1\b\0K\0\1\0\1\0\5\ayw\18EmitRangerCwd\agw\16JumpNvimCwd\n<C-v>\20NvimEdit vsplit\n<C-t>\21NvimEdit tabedit\n<C-x>\19NvimEdit split\18rnvimr_action\27rnvimr_shadow_winblend- highlight link RnvimrNormal CursorLine \bcmd\21rnvimr_enable_bw\25rnvimr_enable_picker\21rnvimr_enable_ex\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/rnvimr",
    url = "https://github.com/kevinhwang91/rnvimr"
  },
  ["suda.vim"] = {
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/suda.vim",
    url = "https://github.com/lambdalisue/suda.vim"
  },
  tabular = {
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/tabular",
    url = "https://github.com/godlygeek/tabular"
  },
  ["targets.vim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/targets.vim",
    url = "https://github.com/wellle/targets.vim"
  },
  ["vim-better-whitespace"] = {
    config = { "\27LJ\2\2�\2\0\0\2\0\t\0\0176\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0006\0\0\0009\0\1\0005\1\6\0=\1\5\0006\0\0\0009\0\a\0'\1\b\0B\0\2\1K\0\1\0. let g:show_spaces_that_precede_tabs = 1 \bcmd\1\a\0\0\14gitcommit\nunite\aqf\thelp\rmarkdown\vpacker*better_whitespace_filetypes_blacklist\30better_whitespace_enabled\15<leader>ss\31better_whitespace_operator\6g\bvim\0" },
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/vim-better-whitespace",
    url = "https://github.com/ntpeters/vim-better-whitespace"
  },
  ["vim-clap"] = {
    config = { "\27LJ\2\2�\4\0\0\4\0\16\0\0256\0\0\0009\0\1\0005\1\3\0=\1\2\0006\0\0\0009\0\1\0005\1\6\0005\2\5\0=\2\a\1=\1\4\0006\0\0\0009\0\b\0009\0\t\0'\1\n\0B\0\2\2'\1\v\0&\0\1\0006\1\0\0009\1\1\0015\2\14\0005\3\r\0>\0\n\3=\3\15\2=\2\f\1K\0\1\0\vsource\1\0\1\tsink\6e\1\n\0\0!~/.config/nvim/lua/start.lua#~/.config/nvim/lua/plugins.lua(~/.config/nvim/lua/key_mappings.lua#~/.config/nvim/lua/autocmd.lua\28~/.config/nvim/init.vim,~/.config/nvim/plugin/which-vim-key.vim\"~/.config/nvim/cheatsheets.md\r~/.zshrc\17~/.tmux.conf\22clap_provider_dot8/site/pack/packer/opt/awesome-cheatsheets/README.md\tdata\fstdpath\afn\14ClapInput\1\0\0\1\0\2\fctermfg\bred\nguifg\bred\15clap_theme\1\0\3\vtexthl\29ClapCurrentSelectionSign\ttext\a->\vlinehl\25ClapCurrentSelection clap_current_selection_sign\6g\bvim\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/vim-clap",
    url = "https://github.com/liuchengxu/vim-clap"
  },
  ["vim-colorschemes"] = {
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/vim-colorschemes",
    url = "https://github.com/flazz/vim-colorschemes"
  },
  ["vim-commentary"] = {
    config = { "\27LJ\2\2\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-cpp-enhanced-highlight"] = {
    config = { "\27LJ\2\2d\0\0\2\0\4\0\t6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0K\0\1\0\29cpp_class_decl_highlight\30cpp_class_scope_highlight\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/vim-cpp-enhanced-highlight",
    url = "https://github.com/octol/vim-cpp-enhanced-highlight"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/vim-devicons",
    url = "https://github.com/ryanoasis/vim-devicons"
  },
  ["vim-dispatch"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/vim-dispatch",
    url = "https://github.com/tpope/vim-dispatch"
  },
  ["vim-easymotion"] = {
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/vim-easymotion",
    url = "https://github.com/easymotion/vim-easymotion"
  },
  ["vim-floaterm"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/vim-floaterm",
    url = "https://github.com/voldikss/vim-floaterm"
  },
  ["vim-fswitch"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/vim-fswitch",
    url = "https://github.com/derekwyatt/vim-fswitch"
  },
  ["vim-fugitive"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-gas"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/vim-gas",
    url = "https://github.com/Shirk/vim-gas"
  },
  ["vim-gutentags"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/vim-gutentags",
    url = "https://github.com/ludovicchabant/vim-gutentags"
  },
  ["vim-highlightedyank"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/vim-highlightedyank",
    url = "https://github.com/machakann/vim-highlightedyank"
  },
  ["vim-jack-in"] = {
    commands = { "Clj", "Lein", "Boot" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/vim-jack-in",
    url = "https://github.com/clojure-vim/vim-jack-in"
  },
  ["vim-lua"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/vim-lua",
    url = "https://github.com/tbastos/vim-lua"
  },
  ["vim-markdown"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/vim-markdown",
    url = "https://github.com/plasticboy/vim-markdown"
  },
  ["vim-multiple-cursors"] = {
    config = { "\27LJ\2\2;\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\0\0=\1\2\0K\0\1\0\30multi_cursor_support_imap\6g\bvim\0" },
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/vim-multiple-cursors",
    url = "https://github.com/terryma/vim-multiple-cursors"
  },
  ["vim-peekaboo"] = {
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/vim-peekaboo",
    url = "https://github.com/junegunn/vim-peekaboo"
  },
  ["vim-scrollstatus"] = {
    config = { "\27LJ\2\2�\1\0\0\2\0\a\0\r6\0\0\0009\0\1\0)\1\f\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0006\0\0\0009\0\1\0'\1\6\0=\1\5\0K\0\1\0\6#\28scrollstatus_symbol_bar\6-\30scrollstatus_symbol_track\22scrollstatus_size\6g\bvim\0" },
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/vim-scrollstatus",
    url = "https://github.com/ojroques/vim-scrollstatus"
  },
  ["vim-sexp"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/vim-sexp",
    url = "https://github.com/guns/vim-sexp"
  },
  ["vim-sexp-mappings-for-regular-people"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/vim-sexp-mappings-for-regular-people",
    url = "https://github.com/tpope/vim-sexp-mappings-for-regular-people"
  },
  ["vim-signature"] = {
    config = { "\27LJ\2\2i\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0006abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVW\26SignatureIncludeMarks\6g\bvim\0" },
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/vim-signature",
    url = "https://github.com/kshenoy/vim-signature"
  },
  ["vim-signify"] = {
    config = { "\27LJ\2\2\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/vim-signify",
    url = "https://github.com/mhinz/vim-signify"
  },
  ["vim-startuptime"] = {
    commands = { "StartupTime" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/vim-startuptime",
    url = "https://github.com/dstein64/vim-startuptime"
  },
  ["vim-surround"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-swap"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/vim-swap",
    url = "https://github.com/machakann/vim-swap"
  },
  ["vim-terminal-help"] = {
    config = { "\27LJ\2\2O\0\0\2\0\4\0\t6\0\0\0009\0\1\0)\1\20\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\3\0K\0\1\0\18terminal_list\20terminal_height\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/vim-terminal-help",
    url = "https://github.com/skywind3000/vim-terminal-help"
  },
  ["vim-unimpaired"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/vim-unimpaired",
    url = "https://github.com/tpope/vim-unimpaired"
  },
  ["vim-which-key"] = {
    commands = { "WhichKey", "WhichKey!" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/vim-which-key",
    url = "https://github.com/liuchengxu/vim-which-key"
  },
  ["vim-win"] = {
    config = { "\27LJ\2\2\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/vim-win",
    url = "https://github.com/dstein64/vim-win"
  },
  ["vim-youdao-translater"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/vim-youdao-translater",
    url = "https://github.com/ianva/vim-youdao-translater"
  },
  ["vista.vim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/vista.vim",
    url = "https://github.com/liuchengxu/vista.vim"
  },
  ["xterm-color-table.vim"] = {
    commands = { "XtermColorTable" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/xterm-color-table.vim",
    url = "https://github.com/guns/xterm-color-table.vim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: vim-floaterm
time([[Setup for vim-floaterm]], true)
try_loadstring("\27LJ\2\2e\0\0\2\0\5\0\t6\0\0\0009\0\1\0)\1\b\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0K\0\1\0\15<leader>tm\27floaterm_keymap_toggle\22floaterm_winblend\6g\bvim\0", "setup", "vim-floaterm")
time([[Setup for vim-floaterm]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\2�\1\0\0\a\0\b\2!6\0\0\0006\1\1\0009\1\2\0019\1\3\1)\2\0\0B\1\2\0A\0\0\3\b\1\0\0X\2\20�6\2\1\0009\2\2\0029\2\4\2)\3\0\0\23\4\1\0\18\5\0\0+\6\2\0B\2\5\2:\2\1\2\18\3\2\0009\2\5\2\18\4\1\0\18\5\1\0B\2\4\2\18\3\2\0009\2\6\2'\4\a\0B\2\3\2\n\2\0\0X\2\2�+\2\1\0X\3\1�+\2\2\0L\2\2\0\a%s\nmatch\bsub\23nvim_buf_get_lines\24nvim_win_get_cursor\bapi\bvim\vunpack\0\2C\0\1\3\0\4\0\a6\1\0\0'\2\1\0B\1\2\0029\1\2\0019\2\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequire�\1\0\1\2\3\5\0\29-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4�-\1\0\0009\1\1\1B\1\1\1X\1\19�-\1\1\0009\1\2\1B\1\1\2\15\0\1\0X\2\4�-\1\1\0009\1\3\1B\1\1\1X\1\n�-\1\2\0B\1\1\2\15\0\1\0X\2\4�-\1\0\0009\1\4\1B\1\1\1X\1\2�\18\1\0\0B\1\1\1K\0\1\0\2�\1�\0�\rcomplete\19expand_or_jump\23expand_or_jumpable\21select_next_item\fvisible�\1\0\1\3\2\4\0\23-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4�-\1\0\0009\1\1\1B\1\1\1X\1\r�-\1\1\0009\1\2\1)\2��B\1\2\2\15\0\1\0X\2\5�-\1\1\0009\1\3\1)\2��B\1\2\1X\1\2�\18\1\0\0B\1\1\1K\0\1\0\2�\1�\tjump\rjumpable\21select_prev_item\fvisible�\5\1\0\n\0001\0i3\0\0\0006\1\1\0'\2\2\0B\1\2\0026\2\1\0'\3\3\0B\2\2\0029\3\4\0025\4\b\0005\5\6\0003\6\5\0=\6\a\5=\5\t\0045\5\r\0009\6\n\0023\a\v\0005\b\f\0B\6\3\2=\6\14\0059\6\n\0023\a\15\0005\b\16\0B\6\3\2=\6\17\0059\6\n\0029\a\n\0029\a\18\a)\b��B\a\2\0025\b\19\0B\6\3\2=\6\20\0059\6\n\0029\a\n\0029\a\18\a)\b\4\0B\a\2\0025\b\21\0B\6\3\2=\6\22\0059\6\n\0029\a\n\0029\a\23\aB\a\1\0025\b\24\0B\6\3\2=\6\25\0059\6\26\0029\6\27\6=\6\28\0059\6\n\0025\a\30\0009\b\n\0029\b\29\bB\b\1\2=\b\31\a9\b\n\0029\b \bB\b\1\2=\b!\aB\6\2\2=\6\"\0059\6\n\0029\6#\0065\a$\0B\6\2\2=\6%\5=\5\n\0049\5\26\0029\5&\0054\6\3\0005\a'\0>\a\1\0064\a\3\0005\b(\0>\b\1\aB\5\3\2=\5&\4B\3\2\0019\3\4\0029\3)\3'\4*\0005\5,\0004\6\3\0005\a+\0>\a\1\6=\6&\5B\3\3\0019\3\4\0029\3)\3'\4-\0005\0050\0009\6\26\0029\6&\0064\a\3\0005\b.\0>\b\1\a4\b\3\0005\t/\0>\t\1\bB\6\3\2=\6&\5B\3\3\0012\0\0�K\0\1\0\1\0\0\1\0\1\tname\fcmdline\1\0\1\tname\tpath\6:\1\0\0\1\0\1\tname\vbuffer\6/\fcmdline\1\0\1\tname\vbuffer\1\0\1\tname\fluasnip\fsources\t<CR>\1\0\1\vselect\2\fconfirm\n<C-g>\6c\nclose\6i\1\0\0\nabort\n<C-y>\fdisable\vconfig\14<C-Space>\1\3\0\0\6i\6c\rcomplete\n<C-f>\1\3\0\0\6i\6c\n<C-b>\1\3\0\0\6i\6c\16scroll_docs\f<S-Tab>\1\3\0\0\6i\6s\0\n<Tab>\1\0\0\1\3\0\0\6i\6s\0\fmapping\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\bcmp\fluasnip\frequire\0\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: vim-better-whitespace
time([[Config for vim-better-whitespace]], true)
try_loadstring("\27LJ\2\2�\2\0\0\2\0\t\0\0176\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0006\0\0\0009\0\1\0005\1\6\0=\1\5\0006\0\0\0009\0\a\0'\1\b\0B\0\2\1K\0\1\0. let g:show_spaces_that_precede_tabs = 1 \bcmd\1\a\0\0\14gitcommit\nunite\aqf\thelp\rmarkdown\vpacker*better_whitespace_filetypes_blacklist\30better_whitespace_enabled\15<leader>ss\31better_whitespace_operator\6g\bvim\0", "config", "vim-better-whitespace")
time([[Config for vim-better-whitespace]], false)
-- Config for: vim-multiple-cursors
time([[Config for vim-multiple-cursors]], true)
try_loadstring("\27LJ\2\2;\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\0\0=\1\2\0K\0\1\0\30multi_cursor_support_imap\6g\bvim\0", "config", "vim-multiple-cursors")
time([[Config for vim-multiple-cursors]], false)
-- Config for: onebuddy
time([[Config for onebuddy]], true)
try_loadstring("\27LJ\2\2\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "onebuddy")
time([[Config for onebuddy]], false)
-- Config for: vim-signify
time([[Config for vim-signify]], true)
try_loadstring("\27LJ\2\2\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "vim-signify")
time([[Config for vim-signify]], false)
-- Config for: rainbow
time([[Config for rainbow]], true)
vim.g.rainbow_active = 1
time([[Config for rainbow]], false)
-- Config for: vim-scrollstatus
time([[Config for vim-scrollstatus]], true)
try_loadstring("\27LJ\2\2�\1\0\0\2\0\a\0\r6\0\0\0009\0\1\0)\1\f\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0006\0\0\0009\0\1\0'\1\6\0=\1\5\0K\0\1\0\6#\28scrollstatus_symbol_bar\6-\30scrollstatus_symbol_track\22scrollstatus_size\6g\bvim\0", "config", "vim-scrollstatus")
time([[Config for vim-scrollstatus]], false)
-- Config for: auto-pairs
time([[Config for auto-pairs]], true)
try_loadstring("\27LJ\2\2�\1\0\0\2\0\3\0\0056\0\0\0009\0\1\0'\1\2\0B\0\2\1K\0\1\0�\1 au FileType lisp,clojure,lisp let b:AutoPairs = {'```': '```', '`': '`', '\"': '\"', '[': ']', '(': ')', '{': '}', '\"\"\"': '\"\"\"'} \bcmd\bvim\0", "config", "auto-pairs")
time([[Config for auto-pairs]], false)
-- Config for: oceanic-material
time([[Config for oceanic-material]], true)
try_loadstring("\27LJ\2\2B\0\0\2\0\3\0\0056\0\0\0009\0\1\0'\1\2\0B\0\2\1K\0\1\0# colorscheme oceanic_material \bcmd\bvim\0", "config", "oceanic-material")
time([[Config for oceanic-material]], false)
-- Config for: vim-signature
time([[Config for vim-signature]], true)
try_loadstring("\27LJ\2\2i\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0006abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVW\26SignatureIncludeMarks\6g\bvim\0", "config", "vim-signature")
time([[Config for vim-signature]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file MarkdownPreview lua require("packer.load")({'markdown-preview.nvim'}, { cmd = "MarkdownPreview", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file RnvimrToggle lua require("packer.load")({'rnvimr'}, { cmd = "RnvimrToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file XtermColorTable lua require("packer.load")({'xterm-color-table.vim'}, { cmd = "XtermColorTable", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Defx lua require("packer.load")({'defx.nvim'}, { cmd = "Defx", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file WhichKey lua require("packer.load")({'vim-which-key'}, { cmd = "WhichKey", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Clj lua require("packer.load")({'vim-jack-in'}, { cmd = "Clj", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Lein lua require("packer.load")({'vim-jack-in'}, { cmd = "Lein", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file GundoToggle lua require("packer.load")({'gundo.vim'}, { cmd = "GundoToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file GitMessenger lua require("packer.load")({'git-messenger.vim'}, { cmd = "GitMessenger", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Boot lua require("packer.load")({'vim-jack-in'}, { cmd = "Boot", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[au CmdUndefined WhichKey! ++once lua require"packer.load"({'vim-which-key'}, {}, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType lua ++once lua require("packer.load")({'BetterLua.vim', 'vim-lua'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType lisp ++once lua require("packer.load")({'vim-sexp-mappings-for-regular-people', 'vim-sexp'}, { ft = "lisp" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdownd ++once lua require("packer.load")({'vim-markdown'}, { ft = "markdownd" }, _G.packer_plugins)]]
vim.cmd [[au FileType c ++once lua require("packer.load")({'vim-fswitch'}, { ft = "c" }, _G.packer_plugins)]]
vim.cmd [[au FileType python ++once lua require("packer.load")({'python-syntax'}, { ft = "python" }, _G.packer_plugins)]]
vim.cmd [[au FileType clojure ++once lua require("packer.load")({'vim-sexp-mappings-for-regular-people', 'vim-sexp', 'conjure'}, { ft = "clojure" }, _G.packer_plugins)]]
vim.cmd [[au FileType asm ++once lua require("packer.load")({'vim-gas'}, { ft = "asm" }, _G.packer_plugins)]]
vim.cmd [[au FileType cpp ++once lua require("packer.load")({'vim-fswitch'}, { ft = "cpp" }, _G.packer_plugins)]]
vim.cmd [[au FileType fennel ++once lua require("packer.load")({'vim-sexp-mappings-for-regular-people', 'vim-sexp', 'conjure'}, { ft = "fennel" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'vim-clap', 'vim-floaterm', 'vim-cpp-enhanced-highlight', 'targets.vim', 'gutentags_plus', 'fennel.vim', 'vim-dispatch', 'vim-terminal-help', 'vista.vim', 'vim-win', 'nvim-colorizer.lua', 'vim-fugitive', 'awesome-cheatsheets', 'vim-youdao-translater', 'vim-surround', 'vim-gutentags', 'vim-unimpaired', 'vim-highlightedyank', 'vim-swap', 'vim-commentary'}, { event = "VimEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/feng/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], true)
vim.cmd [[source /home/feng/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]]
time([[Sourcing ftdetect script at: /home/feng/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
