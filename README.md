# nvim.lua

## windows
```ps1
scoop install ag bat diffutils fd fzf gcc less lua-language-server(lua_ls) \
    neovide neovim python ripgrep universal-ctags win32yank unxutils yarn lua rust-analyzer
pip3 install neovim
```

## linux
+ `lua-language-server` 安装
去 `https://github.com/LuaLS/lua-language-server/releases` 下载 linux64 的包，解压到 `~/bin/lua-language-server` 下面(添加 `~/bin/lua-language-server/bin` 到 PATH，zshenv.sh 中已经添加)
