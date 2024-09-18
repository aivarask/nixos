require('nvim-autopairs').setup({ --- @see nvim-autopairs
  disable_filetype = { 'TelescopePrompt', 'vim' },
  fast_wrap = { map = '<M-w>' },
  check_ts = true,
})

-- completions
local cmp = require('cmp') --- @see nvim-cmp
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:clear()
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({}))

-- rules
npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')

-- inspection
local inspect = require('inspect')
-- print(inspect(npairs.config.rules { depth = 3, }))
-- print(inspect(npairs.get_rules('{', { depth = 2, })))
