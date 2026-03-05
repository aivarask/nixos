vim.o.pumheight = 16
vim.o.complete = 'o,w,.'
vim.o.autocomplete = true
vim.o.completeopt = "fuzzy,menu,menuone,noselect,popup"
-- vim.o.wildmode = "noselect,list:lastused"
-- vim.o.wildoptions = "exacttext,fuzzy,pum"
-- vim.o.wildignorecase = true

vim.lsp.config('*', {
    root_markers = { '.git' },
    capabilities = {
        textDocument = {
            semanticTokens = {
                multilineTokenSupport = true,
            }
        }
    }
})

vim.lsp.config.bashls = {
    cmd = { 'bash-language-server', 'start' },
    filetypes = { 'bash', 'sh' }
}
vim.lsp.enable {
    -- 'bashls',
    -- 'clangd',
    'lua_ls',
    'nixd',
    -- 'php_ls',
    -- 'pylsp',
    -- 'pyright',
    -- 'stylelint_lsp',
    'toml_ls',
    -- 'typescript_ls',
    'vscode_css',
    'vscode_html',
    'vscode_json',
    'yaml_ls',

}
