{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vscode-langservers-extracted
    nodePackages.fixjson
  ];
}
