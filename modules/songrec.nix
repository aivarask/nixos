{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    songrec
    shaq
  ];

}
