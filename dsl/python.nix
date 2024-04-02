{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nodePackages.pyright
    black
    (python3.withPackages (ps: with ps; [
      pip
      # pipx
      requests
      pytest
      pytest-watch
      pytest-timeout
      pytest-playwright
      pynvim
      livereload
    ]))
  ];
}
