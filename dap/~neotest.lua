require('neotest').setup({
  summary = { open = 'botright vsplit | vertical resize 30 | set winfixwidth' },
  output_panel = { open = 'botright vsplit | vertical resize 60 | set winfixwidth' },
  adapters = {
    -- require("neotest-go")({ recursive_run = true }),
    -- require('neotest-node'), -- local
    -- require('neotest-vitest')
    -- require('neotest-plenary'),
    -- require('neotest-busted'), -- local

    -- require('neotest-phpunit')({
    --   phpunit_cmd = function() return "vendor/bin/phpunit" end,
    --   root_files = { "composer.json" },
    --   filter_dirs = { ".git", "node_modules", "vendor" },
    --   env = { XDEBUG_CONFIG = "idekey=neotest" },
    --   dap = require('dap').configurations.php[2],
    -- }),
    -- require("neotest-python")({}),  -- dap pytest builtin (usefull example)
    -- cargo-nextest
    -- cargo nextest run
    require('rustaceanvim.neotest'),
    -- require('neotest-rust')({ }),

    -- require("neotest-playwright").adapter({
    --   options = {
    --     persist_project_selection = true,
    --     enable_dynamic_test_discovery = true,
    --   },
    -- }),
  },
})
