local function LspLogClear()
  io.popen('echo > ' .. vim.lsp.get_log_path())
  vim.lsp.set_log_level(vim.lsp.log_levels.WARN)
end

return {
  lsp_log_clear = LspLogClear
}
