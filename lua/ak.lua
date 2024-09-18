-- https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md#first-picker
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values

local M = {}

M.colors = function(opts)
  opts = opts or {}
  pickers
    .new(opts, {
      prompt_title = 'colors',
      finder = finders.new_table({
        results = { 'red', 'green', 'blue' },
      }),
      sorter = conf.generic_sorter(opts),
    })
    :find()
end

M.paths = function(opts)
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
end

M._php = function(opts)
  opts = opts or {}
  pickers
    .new(opts, {
      prompt_title = 'php projects',
      finder = finders.new_table({
        results = { 'red', 'green', 'blue' },
      }),
      sorter = conf.generic_sorter(opts),
    })
    :find()
end
return M
