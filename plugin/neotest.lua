local neo = require('neotest')
neo.setup({
  summary = { open = 'botright vsplit | vertical resize 20 | set winfixwidth' },
  output_panel = { open = 'botright vsplit | vertical resize 60 | set winfixwidth' },
  adapters = {
    -- require('neotest-phpunit')({
    --   phpunit_cmd = function() return "vendor/bin/phpunit" end,
    --   root_files = { "composer.json" },
    --   filter_dirs = { ".git", "node_modules", "vendor" },
    --   env = { XDEBUG_CONFIG = "idekey=neotest" },
    --   dap = require('dap').configurations.php[1],
    -- }),
    -- require('neotest-plenary'),
    require('neotest-node'),
    -- require('neotest-vitest')
    -- require("neotest-go"),
    -- cargo-nextest
    -- cargo nextest run
    -- require('neotest-rust'),
    -- require("neotest-zig"),
    -- require("neotest-python")({ }),
    -- require("neotest-playwright").adapter({
    --   options = {
    --     persist_project_selection = true,
    --     enable_dynamic_test_discovery = true,
    --   },
    -- }),
  },
})

require('which-key').register({
  name = 'Neotest',
  s = { function() neo.run.run({ suite = true }) end, 'suite' },
  S = { function() neo.run.run({ suite = true, strategy = 'dap' }) end, 'suite dap' },
  b = { function() neo.run.run(vim.fn.expand('%')) end, '%' },
  B = { function() neo.run.run({ vim.fn.expand('%'), strategy = 'dap' }) end, '% dap' },
  r = { function() neo.run.run() end, 'run' },
  R = { function() neo.run.run({ strategy = 'dap' }) end, 'run dap' },
  l = { function() neo.run.run_last() end, 'run_last' },
  L = { function() neo.run.run_last({ strategy = 'dap' }) end, 'run_last dap' },
  x = { function() neo.summary:expand(vim.uv.cwd(), true) end, 'summary:expand' },
  w = { neo.watch.watch, 'watch.watch' },
  t = { neo.watch.toggle, 'neotest.watch.toggle' },
  W = { neo.watch.stop, 'neotest.watch.stop' },
  --
}, { prefix = '<leader>n' })
