print('ignored.lua actually active')

-- https://github.com/willothy/flatten.nvim
-- require('flatten').setup({
--   nest_if_no_args = true,
-- })

-- https://github.com/Issafalcon/lsp-overloads.nvim
-- if client.server_capabilities.signatureHelpProvider then
--   require('lsp-overloads').setup(client, {
--     keymaps = {
--       next_signature = '<F7>',
--       previous_signature = '<F6>',
--       next_parameter = '<C-l>',
--       previous_parameter = '<C-h>',
--       close_signature = '<A-s>',
--     },
--   })
-- end

-- vim.api.nvim_create_autocmd('BufWritePost', {
--   pattern = { '*.js', '*.ts' },
--   callback = function(ctx)
--     local clients = vim.lsp.get_active_clients({ name = 'svelte' })
--     print(pretty(clients))
--     -- if client.name == 'svelte' then
--     --   print('svelte client $/onDidChangeTsOrJsFile')
--     --   client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.file })
--     -- end
--   end,
-- })

-- ['<F4>'] = cmp.mapping.complete({
--   config = {
--     sources = {
--       { name = 'luasnip' },
--     },
--   },
-- }),
-- ['<F5>'] = cmp.mapping(
--   cmp.mapping.confirm({
--     behavior = cmp.ConfirmBehavior.Replace,
--     select = true,
--   }),
--   { 'i', 'c' }
-- ),
