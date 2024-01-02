-- https://neovim.io/doc/user/lsp.html

-- vim.lsp.start({
--   name = 'my-server-name',
--   cmd = {
--     'node',
--     '/root/vscode-extension-samples/lsp-sample/server/out/server.js',
--   },
--   root_dir = vim.fs.dirname(vim.fs.find({ 'flake.nix' }, { upward = true })[1]),
-- })
