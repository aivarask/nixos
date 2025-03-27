-- https://clangd.llvm.org/config
-- https://clang.llvm.org/docs/CommandGuide/clang.html#environment
return {
  cmd = {
    'clangd',
    -- '--enable-config'
  },
  root_markers = { '.git' },
  filetypes = {
    'c',
    'cpp',
    -- 'objc',
    -- 'objcpp',
    -- 'cuda',
    -- 'proto'
  },
}
