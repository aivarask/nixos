if not pcall(require, 'nvim-treesitter') then
  return
end

require('nvim-treesitter.configs').setup({
  textobjects = {
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
      },
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      include_surrounding_whitespace = true,
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = { query = '@class.outer' },
        [']o'] = '@loop.*',
        [']s'] = { query = '@scope', query_group = 'locals' },
        [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
        ['[o'] = '@loop.*',
        ['[z'] = { query = '@fold', query_group = 'folds', desc = 'Previous fold' },
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
      goto_next = {
        [']c'] = '@conditional.outer',
      },
      goto_previous = {
        ['[c'] = '@conditional.outer',
      },
    },
  },
  context_commentstring = {
    -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
    enable = true,
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
  -- https://github.com/nvim-treesitter/nvim-treesitter
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'tt',
      node_incremental = '<Tab>',
      scope_incremental = 'ti',
      node_decremental = '<S-Tab>',
    },
  },
  indent = {
    enable = true,
  },
  matchup = {
    -- https://github.com/andymass/vim-matchup#tree-sitter-integration
    enable = true,
  },
  autotag = {
    -- https://github.com/windwp/nvim-ts-autotag
    enable = true,
  },
})
