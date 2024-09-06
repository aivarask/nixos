local dapui = require "dapui"
dapui.setup {
  layouts = {
    {
      elements = {
        { id = "scopes",      size = 0.70, },
        { id = "breakpoints", size = 0.15, },
        { id = "stacks",      size = 0.15, },
        -- { id = "watches",     size = 0.25 },
      },
      size = 40,
      position = "right",
    },
    {
      elements = {
        "repl",
        -- "console",
      },
      size = 20,
      position = "bottom",
    },
  },
}
