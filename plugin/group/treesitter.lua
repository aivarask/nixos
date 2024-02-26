if not pcall(require, 'nvim-treesitter') then
  return
end

vim.cmd([[
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  set nofoldenable
]])

-- nvim-treesitter-context plugin
require 'treesitter-context'.setup {
  enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to show for a single context
  trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20,     -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

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
  autotag = {                  -- nvim-ts-autotag
    enable = true,
    filetypes = { 'templ', 'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'xml', 'php', 'markdown' },
  },
  -- nvim-ts-context-commentstring plugin
  textobjects = { -- nvim-treesitter-textobjects
    select = {
      enable = true,
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
    -- TODO: swap config
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
    -- TODO: move config
    move = {
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
