{
  pkgs,
  lib,
  config,
  SELF,
  xdgconf,
  osConfig,
  ...
}:
let
  username = config.home.username;
  symlink = osConfig.symlink;
in
{
  home.file.".mozilla/native-messaging-hosts".enable = false;
  programs.firefox.enable = true;
  programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";
  programs.firefox.languagePacks = [ "en-US" ];
  programs.firefox.profiles."test" = {
    id = 20;
    name = "test";
    path = "test";
  };

  programs.firefox.profiles."${username}" = {
    containersForce = true;
    isDefault = true;
    id = 16;
    name = "${username}";
    path = "${username}";
    search = import ./search.nix;
  };
  # programs.firefox.policies = lib.mkForce /etc/firefox/policies.json;

  xdg.configFile."mozilla/firefox/${username}/chrome/userContent.css" = {

    source = symlink "${xdgconf}/firefox/chrome/userContent.css";
    enable = true;
    force = true;
    recursive = true;
  };
  xdg.configFile."mozilla/firefox/${username}/user.js" = {
    source = symlink "${xdgconf}/firefox/user.js";
    enable = true;
    force = true;
  };
}
