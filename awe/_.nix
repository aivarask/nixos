{ pkgs, ... }:
{
  home.packages = with pkgs; [
    awesome
    luajitPackages.vicious
  ];
}
