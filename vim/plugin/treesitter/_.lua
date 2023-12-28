if not pcall(require, 'nvim-treesitter') then
  return
end

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
    filetypes = {
      'templ', -- added
      'html',
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
      'svelte',
      'vue',
      'tsx',
      'jsx',
      'rescript',
      'xml',
      'php',
      'markdown',
      'astro',
      'glimmer',
      'handlebars',
      'hbs',
    },
  },
  endwise = {
    enable = true,
  },
})
