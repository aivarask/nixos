local function relative()
  local cmd = 'Glow '
  local head = vim.fn.expand('%:h') .. '/'
  local t = { '_README.md', 'README.md' }

  for index, value in ipairs(t) do
    if io.open(head .. value) then
      return vim.cmd.Glow(head .. value)
    end
  end
  print('Not found:')
end

wkr({
  g = {
    name = 'Glow',
    p = { [[:Glow<CR>]], ':Glow (preview buffer)' },
    g = { [[:Glow README.md<CR>]], ':Glow README.md' },
    r = { relative, ':Glow ./{_README.md|README.md}' },
    a = {
      function()
        require('glow').execute({
          fargs = {
            vim.fn.expand('%'),
          },
        })
      end,
      'alternative execution',
    },
  },
}, { prefix = '<space>' })
