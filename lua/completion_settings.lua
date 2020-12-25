-- " Use <Tab> and <S-Tab> to navigate through popup menu
vim.cmd [[ inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"  ]]
vim.cmd [[ inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"  ]]

vim.g.completion_confirm_key = ""
vim.cmd [[ imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ? "<Plug>(completion_confirm_completion)"  : "<c-e><CR>" :  "<CR>" ]]
