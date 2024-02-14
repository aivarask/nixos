{ pkgs, ... }: {
  # https://nixos.wiki/wiki/Python#Libraries
  # https://nixos.org/manual/nixpkgs/unstable/#python
  environment.systemPackages = with pkgs; [
    (python3.withPackages (ps: with ps; [ requests ]))
  ];
  nixpkgs.overlays = [ ];
}
