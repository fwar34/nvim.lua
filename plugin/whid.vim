if exists('g:loaded_whid') | finish | endif

let s:save_cpo = &cpo
set cpo&vim

command! Whid lua require('whid').whid()

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_whid = 1
