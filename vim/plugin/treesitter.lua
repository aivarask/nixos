if not pcall(require, 'nvim-treesitter') then
  return
end

-- https://github.com/nvim-treesitter/nvim-treesitter
require('nvim-treesitter.configs').setup({
  context_commentstring = {
    enable = true,
    -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
    config = {
      css = '/* %s */',
      postcss = '/* %s */',
      scss = '/* %s */',
      -- typescript = { __default = '// %s', __multiline = '/* %s */' },
      -- https://github.com/Himujjal/tree-sitter-svelte/#usage
      -- svelte = {
      -- __default = '<!-- %s -->',
      -- comment = '<!-- %s -->',
      -- element = '<!-- %s -->',
      -- https://github.com/tpope/vim-commentary/issues/145
      -- https://github.com/sveltejs/svelte/issues/5213
      -- attribute_name = '--%s',
      -- text = '// %s',
      -- },
    },
  },
  highlight = {
    enable = true,
  },
  autopairs = {
    enable = true,
  },
  incremental_selection = { -- https://github.com/nvim-treesitter/nvim-treesitter
    enable = true,
    keymaps = {
      init_selection = 'tt',
      node_incremental = '<Tab>',
      scope_incremental = 'ti',
      node_decremental = '<S-Tab>',
    },
  },
  indent = { -- https://github.com/nvim-treesitter/nvim-treesitter#indentation
    enable = true,
    -- disable = { 'javascript' },
  },
  matchup = { -- https://github.com/andymass/vim-matchup#tree-sitter-integration
    enable = false,
  },
  rainbow = { -- https://github.com/p00f/nvim-ts-rainbow
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
  autotag = { -- https://github.com/windwp/nvim-ts-autotag
    enable = true,
  },
  textobjects = { -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        -- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
        ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
      },
      -- You can choose the select mode (default is charwise 'v')
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding xor succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      include_surrounding_whitespace = true,
    },
    swap = { -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects#text-objects-swap
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
    move = { -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects#text-objects-move
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = { query = '@class.outer', desc = 'Next class start' },
        --
        -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
        [']o'] = '@loop.*',
        -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
        --
        -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
        -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
        [']s'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },
        [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
      -- Below will go to either the start or the end, whichever is closer.
      -- Use if you want more granular movements
      -- Make it even more gradual by adding multiple queries and regex.
      -- goto_next = {
      --   [']d'] = '@conditional.outer',
      -- },
      -- goto_previous = {
      --   ['[d'] = '@conditional.outer',
      -- },
    },
  },
})

-- vim.keymap.set('n', '<leader><leader>n', function()
--   local node = require('nvim-treesitter.ts_utils').get_node_at_cursor()
--   print(node)({ desc = "require('nvim-treesitter.ts_utils').get_node_at_cursor()" })
-- end)

vim.keymap.set('n', '<leader><leader>n', require('nvim-treesitter.ts_utils').get_node_at_cursor)
