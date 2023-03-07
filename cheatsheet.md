1. telescope grep_string 可以使用 "!" 来取反做过滤
2. 临时禁用鼠标可以按住 shift 键，参考 `:h mouse`
3. <C-r><C-w>可以读取光标下面的word（cword）
4. insert 搜索模式 命令模式 <C-r> 可以读取 registers 中的内容
5. <C-a> 数字自增 <C-x> 数字自减
6. 调用 vimL 函数
```lua
lua vim.api.nvim_call_function('ExecuteFile', {})
```

|前缀/后缀|作用模式                    |命令格式         |命令缩写        |
|---------|----------------------------|-----------------|----------------|
|\<Space> |普通、可视、选择和操作符等待|:map {lhs} {rhs} |                |
|n        |普通                        |:nmap {lhs} {rhs}|:nm {lhs} {rhs} |
|v        |可视和选择                  |:vmap {lhs} {rhs}|:vm {lhs} {rhs} |
|s        |选择                        |:smap {lhs} {rhs}|                |
|x        |可视                        |:xmap {lhs} {rhs}|:xm {lhs} {rhs} |
|o        |操作符等待                  |:omap {lhs} {rhs}|:om {lhs} {rhs} |
|!        |插入和命令行                |:map! {lhs} {rhs}|                |
|i        |插入                        |:imap {lhs} {rhs}|:im {lhs} {rhs} |
|l        |插入、命令行和 Lang-Arg 模式|:lmap {lhs} {rhs}|:lm {lhs} {rhs} |
|c        |命令行                      |:cmap {lhs} {rhs}|:cm {lhs} {rhs} |

前缀/后缀	说明	命令格式	命令缩写
nore	不递归映射，即不允许再对 {rhs} 进行映射扫描，也就是 {lhs} 定义后的映射就是 {rhs} 的键序列，不再对 {rhs} 键序列重新解释扫描，一般用于重定义一个命令。	:noremap {lhs} {rhs}	
:no  {lhs} {rhs}

:nor {lhs} {rhs}

un	取消 :map 绑定的 {lhs}	:unmap {lhs}	 
clear	取消所有 :map 绑定的 {lhs}，慎用	:mapclear	 
