require('lsp-file-operations').setup() -- nvim-lsp-file-operations
require('refactoring').setup({})       -- refactoring-nvim

require('lsp_signature').setup({       -- lsp_signature-nvim
  floating_window = false,
  close_timeout = 1000,
  hint_prefix = '🚀 ',
  toggle_key = '<M-x>',
})

-- lspconfig nvim-lspconfig
local wkr = require('which-key').register
wkr({
  ['[d'] = { vim.diagnostic.goto_prev, 'vim.diagnostic.goto_prev' },
  [']d'] = { vim.diagnostic.goto_next, 'vim.diagnostic.goto_next' },
})

wkr({
  e = { vim.diagnostic.open_float, 'vim.diagnostic.open_float' },
  q = { vim.diagnostic.setloclist, 'vim.diagnostic.setloclist' },
}, { prefix = '<space>' })

local function get_keys(t)
  local keys = {}
  for key, _ in pairs(t) do
    table.insert(keys, key)
  end
  return keys
end

function inspect_lsp_client()
  local pretty = require('pl.pretty')
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  vim.ui.select(clients, {
    prompt = 'Select LSP client',
    format_item = function(client)
      return client.name
    end,
  }, function(selected_client)
    if selected_client then
      local client = vim.lsp.get_client_by_id(selected_client.id)
      local keys = get_keys(client)

      vim.ui.select(keys, _,
        function(key) if key and client ~= nil and client[key] then pretty(client[key]) else pretty(client) end end)
    end
  end)
end

function on_attach(client, buffer)
  if client ~= nil and client.server_capabilities.signatureHelpProvider then
    require('lsp-overloads').setup(client, {
      ui = {
        border = nil,    -- The border to use for the signature popup window. Accepts same border values as |nvim_open_win()|.
        height = nil,    -- Height of the signature popup window (nil allows dynamic sizing based on content of the help)
        width = nil,     -- Width of the signature popup window (nil allows dynamic sizing based on content of the help)
        wrap = true,     -- Wrap long lines
        wrap_at = nil,   -- Character to wrap at for computing height when wrap enabled
        max_width = nil, -- Maximum signature popup width
        max_height = 30, -- Maximum signature popup height
        -- Events that will close the signature popup window: use {"CursorMoved", "CursorMovedI", "InsertCharPre"} to hide the window when typing
        close_events = { "CursorMoved", "BufHidden", "InsertLeave" },
        focusable = true,                       -- Make the popup float focusable
        focus = false,                          -- If focusable is also true, and this is set to true, navigating through overloads will focus into the popup window (probably not what you want)
        offset_x = 0,                           -- Horizontal offset of the floating window relative to the cursor position
        offset_y = 0,                           -- Vertical offset of the floating window relative to the cursor position
        floating_window_above_cur_line = false, -- Attempt to float the popup above the cursor position
        -- (note, if the height of the float would be greater than the space left above the cursor, it will default
        -- to placing the float below the cursor. The max_height option allows for finer tuning of this)
        silent = true, -- Prevents noisy notifications (make false to help debug why signature isn't working)
        -- Highlight options is null by default, but this just shows an example of how it can be used to modify the LspSignatureActiveParameter highlight property
        highlight = {
          italic = true,
          bold = true,
          fg = "#ffffff",
          -- ...,  -- Other options accepted by the `val` parameter of vim.api.nvim_set_hl()
        },
      },
      keymaps = {
        next_signature = "<F4>",
        previous_signature = "<C-k>",
        next_parameter = "<C-l>",
        previous_parameter = "<C-h>",
        close_signature = "<A-s>",
      },
      display_automatically = false, -- Uses trigger characters to automatically display the signature overloads when typing a method signature
    })                               -- lsp-overloads-nvim
  end

  print()

  wkr({
    [']a'] = { vim.lsp.buf.code_action, 'vim.lsp.buf.code_action', mode = { 'n', 'v' } },
    gD = { vim.lsp.buf.declaration, 'vim.lsp.buf.declaration' },
    gd = { vim.lsp.buf.definition, 'vim.lsp.buf.definition' },
    K = { vim.lsp.buf.hover, 'vim.lsp.buf.hover' },
    gi = { vim.lsp.buf.implementation, 'vim.lsp.buf.implementation' },
    ['<F2>'] = { vim.lsp.buf.signature_help, 'vim.lsp.signature_help', mode = { 'n', 'i' } },
    -- ['<F3>'] = { require('lsp_signature').toggle_float_win, 'lsp_signature.toggle_float_win', mode = { 'n', 'i' } },

    ['<F3>'] = { [[<cmd>LspOverloadsSignature<CR>]], 'LspOverloadsSignature', mode = { 'n', 'i' } },
    gr = { vim.lsp.buf.references, 'vim.lsp.buf.references' },
  }, { buffer = buffer })

  wkr({
    D = { vim.lsp.buf.type_definition, 'vim.lsp.type_definition' },
    rn = { vim.lsp.buf.rename, 'vim.lsp.buf.rename' },
    rc = { inspect_lsp_client, 'Inspect LSP client' },
  }, { prefix = '<space>', buffer = buffer })

  wkr({
    name = 'Workspace',
    a = { vim.lsp.buf.add_workspace_folder, 'vim.lsp.buf.add_workspace_folder' },
    r = { vim.lsp.buf.remove_workspace_folder, 'vim.lsp.buf.remove_workspace_folder' },
    l = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, 'vim.lsp.list_workspace_folders' },
  }, { prefix = '<space>w', buffer = buffer })
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    local buffer = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    on_attach(client, buffer)
  end,
})
