if not pcall(require, 'nvim-treesitter') then return end

wkr({
  ['['] = {
    name = 'Previous',
    t = { require('todo-comments').jump_prev, 'todo-comments.jump_prev' },
  },
  [']'] = {
    name = 'Next',
    t = { require('todo-comments').jump_next, 'todo-comments.jump_next' },
  },
})

require('nvim-treesitter.configs').setup({
  textobjects = {
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['ax'] = '@attribute.outer',
        ['aX'] = '@block.outer',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
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
        ['>x'] = '@attribute.outer',
        ['>X'] = '@block.outer',
        ['>p'] = '@parameter.inner',
        ['>c'] = '@class.outer',
        ['>f'] = '@function.outer',
      },
      swap_previous = {
        ['<x'] = '@attribute.outer',
        ['<X'] = '@block.outer',
        ['<p'] = '@parameter.inner',
        ['<c'] = '@class.outer',
        ['<f'] = '@function.outer',
      },
    },
    move = {
      -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects#text-objects-move
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']x'] = '@attribute.outer',
        [']X'] = '@block.outer',
        [']c'] = '@class.outer',
        [']f'] = '@function.outer',
      },
      goto_previous_start = {
        ['[x'] = '@attribute.outer',
        ['[X'] = '@block.outer',
        ['[c'] = '@class.outer',
        ['[f'] = '@function.outer',
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
