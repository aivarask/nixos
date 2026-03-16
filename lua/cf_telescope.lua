local lfs = require 'lfs'
local data = vim.fn.stdpath('data')
lfs.mkdir(data .. '/databases')

require('telescope').setup({
    defaults = {
        layout_strategy = 'flex',
        layout_config = {
            bottom_pane = {
                height = 25,
                preview_cutoff = 120,
                prompt_position = "top"
            },
            center = {
                height = 0.4,
                preview_cutoff = 40,
                prompt_position = "top",
                width = 0.5
            },
            cursor = {
                height = 0.9,
                preview_cutoff = 40,
                width = 0.8
            },
            horizontal = {
                height = 0.9,
                preview_cutoff = 40, -- 120
                prompt_position = "bottom",
                width = 0.9
            },
            vertical = {
                height = 0.9,
                preview_cutoff = 40,
                prompt_position = "bottom",
                width = 0.9
            }
        },
        border = true,
        mappings = {
            i = {
                ["<C-Down>"] = require('telescope.actions').cycle_history_next,
                ["<C-Up>"] = require('telescope.actions').cycle_history_prev,
            },
        },
        history = {
            path = data .. '/databases/telescope_history.sqlite3',
            limit = 100,
        },
        -- vimgrep_arguments = {
        -- 'rg'
        -- },
        -- file_sorter = require('telescope.sorters').fuzzy_with_index_bias()
        -- generic_sorter = nil

    },
    pickers = {},
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_file_sorter = true,    -- override the file sorter
            override_generic_sorter = true, -- override the generic sorter
            case_mode = 'smart_case',       -- default "smart_case" or "ignore_case" or "respect_case"
        },
        -- manix = {
        --     cword = true,
        -- }
    },
})
-- require("telescope").load_extension("notify")
-- require('telescope').load_extension('fzf')
