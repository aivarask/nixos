wkr({
  name = 'Rename',
  r = {
    function()
      local source_file = vim.api.nvim_buf_get_name(0)
      print(source_file)
      local target_file
      vim.ui.input({
        prompt = 'Target : ',
        completion = 'file',
        default = source_file,
      }, function(input)
        target_file = input
        print(target_file)
        local params = {
          command = '_typescript.applyRenameFile',
          arguments = {
            {
              sourceUri = source_file,
              targetUri = target_file,
            },
          },
          title = '',
        }
        vim.lsp.util.rename(source_file, target_file, {})
        vim.lsp.buf.execute_command(params)
      end)
    end,
    'Rename file',
  },
  n = { vim.lsp.buf.rename, 'vim.lsp.buf.rename' },
  w = {
    function()
      vim.lsp.buf.rename()
      vim.cmd('silent! wall')
    end,
    'vim.lsp.rename | write',
  },
}, { prefix = '<leader>r' })
