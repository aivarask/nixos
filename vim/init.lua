vim.cmd([[
 source /etc/nixos/vim/vimrc.vim
]])

io.popen('echo > ' .. vim.lsp.get_log_path())
vim.lsp.set_log_level(vim.lsp.log_levels.DEBUG)

vim.api.nvim_create_autocmd('LspDetach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    print(client.name, vim.uv)
    -- Do something with the client
    -- vim.cmd('setlocal tagfunc< omnifunc<')
    io.popen('echo > ' .. vim.lsp.get_log_path())
  end,
})

-- print(vim.uv)

-- local uv = require('luv')

-- vim.api.nvim_create_autocmd({ 'TextChangedI' }, {
--   pattern = { '*' },
--   callback = function(e)
--     -- local p = require('pl.pretty')

--     -- p(e)
--   end,
-- })
