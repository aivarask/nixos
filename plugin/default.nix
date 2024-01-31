{ pkgs, ... }: {
  # https://nixos.org/manual/nixpkgs/unstable/#chap-language-support
  environment.systemPackages = with pkgs; [ ];
}
