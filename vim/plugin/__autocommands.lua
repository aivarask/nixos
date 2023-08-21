-- https://github.com/akinsho/toggleterm.nvim
local Terminal = require('toggleterm.terminal').Terminal

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = 'schema.prisma',
  command = 'TermExec open=1 cmd="npx prisma db push && dotenv -e .env.e2e -- npx prisma db push && exit" | LspRestart',
})

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = { 'en.json', 'en.yml' },
  command = 'TermExec open=1 cmd="npx @inlang/cli machine translate -f && exit"',
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '.env*',
  callback = function()
    vim.diagnostic.disable()
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Format before write',
  group = vim.api.nvim_create_augroup('format', { clear = true }),
  callback = function(opts)
    local buf_filetype = vim.bo[opts.buf].filetype
    local t = {
      -- svelte = 'svelte',
      prisma = 'prismals',
      -- typescript = 'tsserver',
    }
    for filetype, client_name in pairs(t) do
      if buf_filetype == filetype then
        vim.lsp.buf.format({
          filter = function(client)
            return client.name == client_name
          end,
        })
        return
      end
    end
    vim.lsp.buf.format({
      filter = function(client)
        return client.name == 'null-ls'
      end,
    })
  end,
})

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<cmd>wincmd l<CR>]], opts)
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'toggleterm',
  callback = set_terminal_keymaps,
})
