{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ghc
    ghcid
    ghciwatch
  ];
}
