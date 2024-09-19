-- https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md#bundling-as-extension
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local conf = require('telescope.config').values
return require('telescope').register_extension({
  exports = {
    paths = function(opts)
      opts = opts or {}
      pickers
        .new(opts, {
          prompt_title = 'runtime_paths',
          finder = finders.new_table({
            results = vim.api.nvim_list_runtime_paths(),
          }),
          sorter = conf.generic_sorter(opts),
        })
        :find()
    end,
  },
})
