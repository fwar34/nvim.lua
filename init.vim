lua require('start').init()

let g:completion_chain_complete_list = [
			\  {'complete_items': ['lsp']},
			\  {'complete_items': ['snippet']},
			\  {'complete_items': ['buffers']},
			\  {'complete_items': ['path']},
			\  {'mode': '<c-p>'},
			\  {'mode': '<c-n>'}
			\]
