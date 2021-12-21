1. telescope grep_string 可以使用 "!" 来取反做过滤
2. 临时禁用鼠标可以按住 shift 键，参考 `:h mouse`
3. <C-r><C-w>可以读取光标下面的word（cword）
4. insert 搜索模式 命令模式 <C-r> 可以读取 registers 中的内容
5. <C-a> 数字自增 <C-x> 数字自减
6. 调用 vimL 函数
```lua
lua vim.api.nvim_call_function('ExecuteFile', {})
```
