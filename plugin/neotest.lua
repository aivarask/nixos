require('neotest').setup({
  summary = { open = 'botright vsplit | vertical resize 30 | set winfixwidth' },
  output_panel = { open = 'botright vsplit | vertical resize 60 | set winfixwidth' },
  adapters = {
    -- require('neotest-phpunit')({
    --   phpunit_cmd = function() return "vendor/bin/phpunit" end,
    --   root_files = { "composer.json" },
    --   filter_dirs = { ".git", "node_modules", "vendor" },
    --   env = { XDEBUG_CONFIG = "idekey=neotest" },
    --   dap = require('dap').configurations.php[1],
    -- }),
    -- require('neotest-node'),
    -- require('neotest-plenary'),
    -- require('neotest-busted'),
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
