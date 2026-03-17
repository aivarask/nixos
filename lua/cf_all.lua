---@diagnostic disable-next-line: missing-fields
require('which-key').setup({
    preset = 'helix',
    sort = { 'alphanum' },
    replace = {
        desc = {
            { '<Plug>%(?(.*)%)?', '%1' },
            { '^%+',              '' },
            { '<[cC]md>',         '' },
            { '<[cC][rR]>',       '' },
            { '<[sS]ilent>',      '' },
            { '^lua%s+',          '' },
            { '^call%s+',         '' },
            { '^:%s*',            '' },
        },
    },
})

require('auto-session').setup({
    allowed_dirs = { '/etc/nixos' },
    log_level = vim.log.levels.ERROR,
})

require('flatten').setup {}
require('colorizer').setup({})
if vim.uv.os_getenv('WAYLAND_DISPLAY') then
    require('image').setup({ backend = 'kitty' }) -- https://raw.githubusercontent.com/3rd/image.nvim/refs/heads/master/README.md
end

local mini = require('mini.icons')
require('mini.icons').setup(
    {
        style              = 'glyph', -- ascii
        default            = {},
        directory          = {},
        extension          = {},
        -- file               = { vimrc = require('mini.icons').get('filetype', 'vim') },
        filetype           = {},
        lsp                = {},
        os                 = {},
        use_file_extension = function(ext, file) return true end,
    }
)

local devicons = require('nvim-web-devicons')
require('nvim-web-devicons').setup({
    override = {
        ['nix'] = { icon = '', color = '#ff0000', cterm_color = '110', name = 'Nix' },
    },
    override_by_filename = {
        [".gitignore"] = { icon = "", color = "#f1502f", name = "Gitignore" },
    },
    override_by_extension = {
        ["log"] = { icon = "", color = "#81e043", name = "Log" }
    },
})

require('fidget').setup({})
require('notify').setup({
    top_down = false,
})
vim.notify = require('notify')
