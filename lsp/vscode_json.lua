return {
  cmd = { 'vscode-json-languageserver', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  settings = {
    json = {
      validate = { enable = true },
      format = { enable = true },
      schemas = require('schemastore').json.schemas({
        select = {
          '.eslintrc',
          'prettierrc.json',
          'package.json',
          'jsconfig.json',
          'tsconfig.json',
          'composer.json',
        },
        extra = {
          {
            fileMatch = { '*/snippets/*.json', '!*/snippets/package.json' },
            name = 'snippets',
            url = 'https://raw.githubusercontent.com/Yash-Singh1/vscode-snippets-json-schema/main/schema.json',
          },
        },
      }),
    },
  },
}
