local G = {}

-- local Lsp_formatting = function(bufnr)
--   vim.lsp.buf.format({
--     filter = function(client)
--       -- apply whatever logic you want (in this example, we'll only use null-ls)
--       print(client.name)
--       return client.name == "null-ls"
--     end,
--     bufnr = bufnr,
--   })
-- end

function Table_has_value(tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end
  return false
end

function ReloadModule(arg)
  local target = vim.fn.expand(arg)
  require('plenary.reload').reload_module(target)
  print('reload ', target)
end

function ReloadFile()
  local module_name = vim.fn.expand('%:t:r')
  if module_name == 'init' then
    module_name = vim.fn.expand('%:h:t')
  end
end

return G
