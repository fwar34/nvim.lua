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
  LeaderF = {
    config = { "\27LJ\2\2Ñ\1\0\0\2\0\t\0\0176\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0006\0\0\0009\0\5\0'\1\6\0B\0\2\0016\0\0\0009\0\1\0'\1\b\0=\1\a\0K\0\1\0\n<C-V>\17Lf_ShortcutFClet g:Lf_CommandMap = {'<C-P>': ['<Up>'], '<C-N>': ['<Down>']}\bcmd\22Lf_PreviewInPopup\npopup\22Lf_WindowPosition\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/LeaderF",
    url = "https://github.com/Yggdroot/LeaderF"
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
    config = { "\27LJ\2\2¥\1\0\0\2\0\3\0\0056\0\0\0009\0\1\0'\1\2\0B\0\2\1K\0\1\0…\1 au FileType lisp,clojure,lisp let b:AutoPairs = {'```': '```', '`': '`', '\"': '\"', '[': ']', '(': ')', '{': '}', '\"\"\"': '\"\"\"'} \bcmd\bvim\0" },
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
  ["colorbuddy.nvim"] = {
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/colorbuddy.nvim",
    url = "https://github.com/tjdevries/colorbuddy.nvim"
  },
  conjure = {
    config = { "\27LJ\2\2«\1\0\0\2\0\5\0\r6\0\0\0009\0\1\0'\1\2\0B\0\2\0016\0\0\0009\0\1\0'\1\3\0B\0\2\0016\0\0\0009\0\1\0'\1\4\0B\0\2\1K\0\1\0'let g:conjure#log#hud#height = 0.5&let g:conjure#log#hud#width = 0.8'let g:conjure#mapping#prefix = \",\"\bcmd\bvim\0" },
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
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\0027\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/feng/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-whichkey-setup.lua"] = {
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/nvim-whichkey-setup.lua",
    url = "https://github.com/AckslD/nvim-whichkey-setup.lua"
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
    config = { "\27LJ\2\2¸\2\0\0\2\0\t\0\0216\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0006\0\0\0009\0\5\0'\1\6\0B\0\2\0016\0\0\0009\0\1\0005\1\b\0=\1\a\0K\0\1\0\1\0\5\ayw\18EmitRangerCwd\agw\16JumpNvimCwd\n<C-v>\20NvimEdit vsplit\n<C-t>\21NvimEdit tabedit\n<C-x>\19NvimEdit split\18rnvimr_action- highlight link RnvimrNormal CursorLine \bcmd\21rnvimr_enable_bw\25rnvimr_enable_picker\21rnvimr_enable_ex\6g\bvim\0" },
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
    config = { "\27LJ\2\2‘\2\0\0\2\0\t\0\0176\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0006\0\0\0009\0\1\0005\1\6\0=\1\5\0006\0\0\0009\0\a\0'\1\b\0B\0\2\1K\0\1\0. let g:show_spaces_that_precede_tabs = 1 \bcmd\1\a\0\0\14gitcommit\nunite\aqf\thelp\rmarkdown\vpacker*better_whitespace_filetypes_blacklist\30better_whitespace_enabled\15<leader>ss\31better_whitespace_operator\6g\bvim\0" },
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/vim-better-whitespace",
    url = "https://github.com/ntpeters/vim-better-whitespace"
  },
  ["vim-clap"] = {
    config = { "\27LJ\2\2Ê\4\0\0\4\0\14\0\0236\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0005\1\5\0=\1\4\0006\0\0\0009\0\6\0009\0\a\0'\1\b\0B\0\2\2'\1\t\0&\0\1\0006\1\0\0009\1\1\0015\2\f\0005\3\v\0>\0\n\3=\3\r\2=\2\n\1K\0\1\0\vsource\1\0\1\tsink\6e\1\n\0\0!~/.config/nvim/lua/start.lua#~/.config/nvim/lua/plugins.lua(~/.config/nvim/lua/key_mappings.lua#~/.config/nvim/lua/autocmd.lua\28~/.config/nvim/init.vim,~/.config/nvim/plugin/which-vim-key.vim\"~/.config/nvim/cheatsheets.md\r~/.zshrc\17~/.tmux.conf\22clap_provider_dot8/site/pack/packer/opt/awesome-cheatsheets/README.md\tdata\fstdpath\afn\1\0\3\vtexthl\29ClapCurrentSelectionSign\ttext\a->\vlinehl\25ClapCurrentSelection clap_current_selection_sign\25material_design_dark\15clap_theme\6g\bvim\0" },
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
    config = { "\27LJ\2\2‰\1\0\0\2\0\a\0\r6\0\0\0009\0\1\0)\1\f\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0006\0\0\0009\0\1\0'\1\6\0=\1\5\0K\0\1\0\6#\28scrollstatus_symbol_bar\6-\30scrollstatus_symbol_track\22scrollstatus_size\6g\bvim\0" },
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
    loaded = true,
    path = "/home/feng/.local/share/nvim/site/pack/packer/start/vim-which-key",
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
-- Config for: oceanic-material
time([[Config for oceanic-material]], true)
try_loadstring("\27LJ\2\2B\0\0\2\0\3\0\0056\0\0\0009\0\1\0'\1\2\0B\0\2\1K\0\1\0# colorscheme oceanic_material \bcmd\bvim\0", "config", "oceanic-material")
time([[Config for oceanic-material]], false)
-- Config for: vim-better-whitespace
time([[Config for vim-better-whitespace]], true)
try_loadstring("\27LJ\2\2‘\2\0\0\2\0\t\0\0176\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0006\0\0\0009\0\1\0005\1\6\0=\1\5\0006\0\0\0009\0\a\0'\1\b\0B\0\2\1K\0\1\0. let g:show_spaces_that_precede_tabs = 1 \bcmd\1\a\0\0\14gitcommit\nunite\aqf\thelp\rmarkdown\vpacker*better_whitespace_filetypes_blacklist\30better_whitespace_enabled\15<leader>ss\31better_whitespace_operator\6g\bvim\0", "config", "vim-better-whitespace")
time([[Config for vim-better-whitespace]], false)
-- Config for: onebuddy
time([[Config for onebuddy]], true)
try_loadstring("\27LJ\2\2\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "onebuddy")
time([[Config for onebuddy]], false)
-- Config for: vim-multiple-cursors
time([[Config for vim-multiple-cursors]], true)
try_loadstring("\27LJ\2\2;\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\0\0=\1\2\0K\0\1\0\30multi_cursor_support_imap\6g\bvim\0", "config", "vim-multiple-cursors")
time([[Config for vim-multiple-cursors]], false)
-- Config for: vim-signify
time([[Config for vim-signify]], true)
try_loadstring("\27LJ\2\2\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "vim-signify")
time([[Config for vim-signify]], false)
-- Config for: vim-scrollstatus
time([[Config for vim-scrollstatus]], true)
try_loadstring("\27LJ\2\2‰\1\0\0\2\0\a\0\r6\0\0\0009\0\1\0)\1\f\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0006\0\0\0009\0\1\0'\1\6\0=\1\5\0K\0\1\0\6#\28scrollstatus_symbol_bar\6-\30scrollstatus_symbol_track\22scrollstatus_size\6g\bvim\0", "config", "vim-scrollstatus")
time([[Config for vim-scrollstatus]], false)
-- Config for: auto-pairs
time([[Config for auto-pairs]], true)
try_loadstring("\27LJ\2\2¥\1\0\0\2\0\3\0\0056\0\0\0009\0\1\0'\1\2\0B\0\2\1K\0\1\0…\1 au FileType lisp,clojure,lisp let b:AutoPairs = {'```': '```', '`': '`', '\"': '\"', '[': ']', '(': ')', '{': '}', '\"\"\"': '\"\"\"'} \bcmd\bvim\0", "config", "auto-pairs")
time([[Config for auto-pairs]], false)
-- Config for: rainbow
time([[Config for rainbow]], true)
vim.g.rainbow_active = 1
time([[Config for rainbow]], false)
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
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Clj lua require("packer.load")({'vim-jack-in'}, { cmd = "Clj", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Lein lua require("packer.load")({'vim-jack-in'}, { cmd = "Lein", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file GitMessenger lua require("packer.load")({'git-messenger.vim'}, { cmd = "GitMessenger", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file GundoToggle lua require("packer.load")({'gundo.vim'}, { cmd = "GundoToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Boot lua require("packer.load")({'vim-jack-in'}, { cmd = "Boot", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType lua ++once lua require("packer.load")({'BetterLua.vim', 'vim-lua'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType lisp ++once lua require("packer.load")({'vim-sexp', 'vim-sexp-mappings-for-regular-people'}, { ft = "lisp" }, _G.packer_plugins)]]
vim.cmd [[au FileType fennel ++once lua require("packer.load")({'vim-sexp', 'vim-sexp-mappings-for-regular-people', 'conjure'}, { ft = "fennel" }, _G.packer_plugins)]]
vim.cmd [[au FileType c ++once lua require("packer.load")({'vim-fswitch'}, { ft = "c" }, _G.packer_plugins)]]
vim.cmd [[au FileType python ++once lua require("packer.load")({'python-syntax'}, { ft = "python" }, _G.packer_plugins)]]
vim.cmd [[au FileType clojure ++once lua require("packer.load")({'vim-sexp', 'vim-sexp-mappings-for-regular-people', 'conjure'}, { ft = "clojure" }, _G.packer_plugins)]]
vim.cmd [[au FileType asm ++once lua require("packer.load")({'vim-gas'}, { ft = "asm" }, _G.packer_plugins)]]
vim.cmd [[au FileType cpp ++once lua require("packer.load")({'vim-fswitch'}, { ft = "cpp" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdownd ++once lua require("packer.load")({'vim-markdown'}, { ft = "markdownd" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'vim-clap', 'vim-floaterm', 'gutentags_plus', 'fennel.vim', 'LeaderF', 'vim-fugitive', 'vim-surround', 'vim-cpp-enhanced-highlight', 'vim-unimpaired', 'vim-terminal-help', 'vim-highlightedyank', 'vim-commentary', 'vim-swap', 'vim-gutentags', 'nvim-colorizer.lua', 'vim-win', 'vista.vim', 'targets.vim', 'vim-dispatch', 'awesome-cheatsheets', 'vim-youdao-translater'}, { event = "VimEnter *" }, _G.packer_plugins)]]
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
