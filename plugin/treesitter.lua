if not pcall(require, 'nvim-treesitter') then
  return
end

vim.cmd([[
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  set nofoldenable
" set foldlevelstart=2
" set foldlevel=3
" set foldlevel=99
" set foldnestmax=5
]])

-- nvim-treesitter-context
require 'treesitter-context'.setup {
  enable = true,
  max_lines = 2,
  min_window_height = 0,
  line_numbers = true,
  multiline_threshold = 20,
  trim_scope = 'outer',
  mode = 'cursor',
  separator = nil,
  zindex = 20,
  on_attach = nil,
}

-- nvim-ts-context-commentstring
vim.g.skip_ts_context_commentstring_module = true
require('ts_context_commentstring').setup {}

require('nvim-ts-autotag').setup({ filetypes = { "html", 'php', 'twig', 'xml' } })
require('nvim-treesitter.configs').setup({ -- nvim-treesitter
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'tt',
      node_incremental = '<Tab>',
      scope_incremental = 'ti',
      node_decremental = '<S-Tab>',
    },
  },
  matchup = { enable = true }, -- vim-matchup
  endwise = { enable = true }, -- nvim-treesitter-endwise
  textobjects = {              -- nvim-treesitter-textobjects
    -- nvim-treesitter-text-objects-select-submod*
    select = {
      enable = false,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
        -- ['ax'] = '@attribute.outer',
        -- ['aX'] = '@block.outer',
      },
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V',  -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      include_surrounding_whitespace = true,
    },
    -- nvim-treesitter-text-objects-swap-submod
    swap = {
      enable = false,
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
    -- nvim-treesitter-text-objects-move-submod
    move = {
      enable = false,
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
    -- nvim-treesitter-textobjects-lsp_interop-submod
    lsp_interop = {
      enable = true,
      border = 'none',
      floating_preview_opts = {},
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },
  },
})
