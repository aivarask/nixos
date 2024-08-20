{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # vscode-langservers-extracted
    # vscode-html-language-server 
    # vscode-css-language-server 
    # vscode-eslint-language-server
    # vscode-markdown-language-server 
    # vscode-json-language-server
    nodePackages.fixjson
  ];
}
