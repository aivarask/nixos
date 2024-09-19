set iskeyword+=-
iabbrev wk local wk = require "which-key"
iabbrev no local notify = vim.notify
let b:switch_custom_definitions =
        \ [
        \   ['foo', 'bar'],
				\		['print', 'vim.print']
        \ ]
