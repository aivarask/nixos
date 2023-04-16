-- INFO: async rename and create file LSP rename
-- https://github.com/nvim-tree/nvim-tree.lua/pull/1870
-- https://github.com/antosha417/nvim-lsp-file-operations
require('lsp-file-operations').setup()

-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Open-At-Startup#recipes
local function open_nvim_tree(data)
  local real_file = vim.fn.filereadable(data.file) == 1 -- buffer is a real file on the disk
  local no_name = data.file == '' and vim.bo[data.buf].buftype == '' -- buffer is a [No Name]
  if not real_file and not no_name then
    return
  end
  require('nvim-tree.api').tree.toggle({ focus = false, find_file = true })
end
vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = open_nvim_tree })

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- https://github.com/kyazdani42/nvim-tree.lua
-- https://github.com/ahmedkhalf/project.nvim#-features
require('nvim-tree').setup()
