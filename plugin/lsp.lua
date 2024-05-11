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

function on_attach(client, bufnr)
  -- LspAttach help
  if client.server_capabilities.completionProvider then
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
  end
  if client.server_capabilities.definitionProvider then
    vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
  end

  -- lsp-inlay_hint
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    -- print(client.name, ' inlayHintProvider')
  end

  -- lsp-overloads-nvim
  if client ~= nil and client.server_capabilities.signatureHelpProvider then
    require('lsp-overloads').setup(client, {
      ui = {
        border = nil,
        height = nil,
        width = nil,
        wrap = true,
        wrap_at = nil,
        max_width = nil,
        max_height = 30,
        close_events = { "CursorMoved", "BufHidden", "InsertLeave" },
        focusable = true,
        focus = false,
        offset_x = 0,
        offset_y = 0,
        floating_window_above_cur_line = false,
        -- (note, if the height of the float would be greater than the space left above the cursor, it will default
        -- to placing the float below the cursor. The max_height option allows for finer tuning of this)
        silent = true, -- Prevents noisy notifications (make false to help debug why signature isn't working)
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
    })
  end




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
  }, { buffer = bufnr })

  wkr({
    D = { vim.lsp.buf.type_definition, 'vim.lsp.type_definition' },
    rn = { vim.lsp.buf.rename, 'vim.lsp.buf.rename' },
    rc = { inspect_lsp_client, 'Inspect LSP client' },
  }, { prefix = '<space>', buffer = bufnr })

  wkr({
    name = 'Workspace',
    a = { vim.lsp.buf.add_workspace_folder, 'vim.lsp.buf.add_workspace_folder' },
    r = { vim.lsp.buf.remove_workspace_folder, 'vim.lsp.buf.remove_workspace_folder' },
    l = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, 'vim.lsp.list_workspace_folders' },
  }, { prefix = '<space>w', buffer = bufnr })
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    local buf = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    on_attach(client, buf)
  end,
})
