local npairs = require("nvim-autopairs")
local cmp = require("cmp")

npairs.setup({
  fast_wrap = {}, -- https://github.com/windwp/nvim-autopairs#fastwrap
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
