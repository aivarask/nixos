vim.keymap.set('n', '<leader>]', [[:Neotest summary<CR>]])

local neo = require('neotest')
neo.setup({
  summary = { open = 'botright vsplit | vertical resize 40 | set winfixwidth' },
  output_panel = { open = 'botright vsplit | vertical resize 60 | set winfixwidth' },
  adapters = {
    require('neotest-plenary'),
    require("neotest-go"),
    require('neotest-phpunit')({
      phpunit_cmd = function() return "vendor/bin/phpunit" end,
      root_files = { "composer.json" },
      filter_dirs = { ".git", "node_modules", "vendor" },
      -- root_ignore_files = {},
      env = { XDEBUG_CONFIG = "idekey=neotest" },
      -- https://github.com/olimorris/neotest-phpunit/#debugging-with-dap-strategy
      dap = nil, -- dap.configurations.php
    }),
    -- cargo-nextest
    -- cargo nextest run
    require('neotest-rust'),
    require("neotest-zig"),
    require("neotest-python")({
    }),
    require("neotest-playwright").adapter({
      options = {
        persist_project_selection = true,
        enable_dynamic_test_discovery = true,
      },
    }),
  },
})


require('which-key').register({
  name = 'Neotest',
  ['1'] = { function() neo.run.run({ vim.fn.expand('%'), strategy = 'dap' }) end, '% dap' },
  r = { neo.run.run, 'run.run' },
  a = { neo.run.attach, 'run.attach' },
  l = { neo.run.run_last, 'run.run_last' },
  -- s = { neotest.run.stop, 'run.stop' },
  S = { neo.summary.toggle, 'summary.toggle' },
  o = { neo.output_panel.toggle, 'output_panel.toggle' },
  s = { function() neo.run.run({ suite = true }) end, 'suite' },
  b = { function() neo.run.run(vim.fn.expand('%')) end, '%' },
  d = { function() neo.run.run({ strategy = 'dap' }) end, 'dap' },
  x = { function() neo.summary:expand(vim.uv.cwd(), true) end, 'summary:expand' },
  w = {
    name = 'Watch',
    w = { neo.watch.watch, 'watch.watch' },
    t = { neo.watch.toggle, 'neotest.watch.toggle' },
    s = { neo.watch.stop, 'neotest.watch.stop' },
    ['?'] = { function() print(neo.watch.is_watching()) end, 'neotest.watch.is_watching' },
  },
}, { prefix = '<leader>n' })
