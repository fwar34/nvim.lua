(fn search-word []
  "my search word"
  (vim.cmd "normal vey")
  (vim.cmd (.. "Ag " (vim.fn.getreg "0"))))
  
(fn coc-status []
  "print coc status message"
  (print (or (~= (vim.fn.coc#status) "") "no coc status message")))

{:search_word search-word :coc_status coc-status}
