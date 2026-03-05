return {
    cmd = { 'vscode-html-language-server', '--stdio' },
    filetypes = { 'html', 'xml' },
    init_options = {
        provideFormatter = true,
        embeddedLanguages = { css = true, javascript = true },
        configurationSection = { 'html', 'css', 'javascript' },
    },
}
