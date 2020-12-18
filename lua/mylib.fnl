(var M {})

(fn M.search_word []
  "my search word"
  (vim.cmd "normal vey")
  (vim.cmd (.. "Ag " (vim.fn.getreg "0"))))
  
(fn M.coc_status []
  "print coc status message"
  (print (or (~= (vim.fn.coc#status) "") "no coc status message")))

M
