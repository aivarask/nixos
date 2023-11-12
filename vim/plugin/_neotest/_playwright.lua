-- https://github.com/thenbe/neotest-playwright#configuration
-- ./_playwright_util.lua
playwright = require('neotest-playwright').adapter({
  options = {
    -- default values shown

    persist_project_selection = false,

    enable_dynamic_test_discovery = false,

    preset = 'none', -- "none" | "headed" | "debug"

    -- get_playwright_binary = function()
    --    return vim.loop.cwd() + "/node_modules/.bin/playwright"
    -- end,

    get_playwright_config = function()
      return vim.uv.cwd() .. '/playwright.config.js'
    end,

    -- get_cwd = function()
    --    return vim.loop.cwd()
    -- end,

    -- env = { },

    -- Extra args to always pass to playwright.
    -- These are merged with any extra_arg passed
    -- to neotest's run command.
    -- extra_args = { },

    -- Filter directories when searching for test files,
    -- useful in large projects (see performance notes).
    -- filter_dir = function(name, rel_path, root)
    -- 		return name ~= "node_modules"
    -- end,
  },
})
