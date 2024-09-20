-- https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md#bundling-as-extension
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local conf = require('telescope.config').values

local colors = function(opts)
  opts = opts or {}
  pickers
    .new(opts, {
      prompt_title = 'colors',
      finder = finders.new_table({
        results = { 'red', 'green', 'blue' },
      }),
      sorter = conf.generic_sorter(opts),

    })
end

-- to execute the function
colors()

return require('telescope').register_extension({
  exports = {
    colors = colors,
  },
})
