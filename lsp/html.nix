{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # vscode-langservers-extracted
    htmx-lsp
    emmet-ls
    emmet-language-server
    ludtwig
    html-tidy
  ];
}
