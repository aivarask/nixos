{ pkgs, ... }: {
  environment.systemPackages =
    [ pkgs.python3 ]
    ++ (with pkgs.nodePackages_latest; [ pyright ])
    ++ (with pkgs.python3Packages; [
      requests
      tuimoji
      autopep8
      # debugpy
      pynvim
      python-lsp-server
      flake8
      tomlkit
    ]);
}
