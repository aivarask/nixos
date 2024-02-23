{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nodePackages.pyright
    black
    (python3.withPackages (ps: with ps; [ requests ]))
  ];
}
