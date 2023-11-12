-- https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md#bundling-as-extension
-- NOTE:
-- The exports table declares the exported pickers that can then be accessed via Telescope plugin_name stuff. If you only provide one export it is suggested that you name the key like the plugin, so you can access it with Telescope plugin_name.
-- USE:
-- :Telescope ak colors
return require('telescope').register_extension({
  -- setup = function(ext_config, config)
  --   -- access extension config and user config
  -- end,
  exports = {
    colors = require('ak').colors,
    paths = require('ak').paths,
  },
})
