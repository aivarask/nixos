return {
    cmd = { 'yaml-language-server', '--stdio' },
    filetypes = { 'yaml' },
    settings = {
        -- https://github.com/redhat-developer/yaml-language-server#language-server-settings
        yaml = {
            format = { enable = true },
            schemaStore = { enable = false },
            schemas = require('schemastore').yaml.schemas(),
        },
    },
}
