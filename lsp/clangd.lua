-- https://clangd.llvm.org/config
-- https://clang.llvm.org/docs/CommandGuide/clang.html#environment
-- https://clangd.llvm.org/features#formatting
return {
  cmd = {
    'clangd',
    -- '--enable-config'
  },
  root_markers = { '.git', '.clangd', '.clang-format' },
  filetypes = {
    'c',
    'cpp',
    -- 'objc',
    -- 'objcpp',
    -- 'cuda',
    -- 'proto'
  },
}
