{
  pkgs,
  lib,
  config,
  SELF,
  xdgconf,
  ...
}:
{
  home.file.".mozilla/native-messaging-hosts".enable = false;
  imports = [
    ./profile.nix
    ./policies.nix
  ];
  programs.firefox.enable = true;
  programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";
  programs.firefox.languagePacks = [
    "en-US"
    # "lt"
  ];

}
