{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vimPlugins.SchemaStore-nvim
    vscode-langservers-extracted
    # vscode-html-language-server 
    # vscode-css-language-server 
    # vscode-eslint-language-server
    # vscode-markdown-language-server 
    # vscode-json-language-server
  ];
}
