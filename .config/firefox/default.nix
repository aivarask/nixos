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
  xdg.configFile."mozilla/firefox/default.nix" = {
    source = symlink "${xdgconf}/firefox/default.nix";
    enable = true;
  };
  xdg.configFile."mozilla/firefox/profile/chrome" = {
    source = symlink "${xdgconf}/firefox/chrome";
    enable = true;
    force = true;
    recursive = true;
  };
  xdg.configFile."mozilla/firefox/profile/bookmarks.html" = {
    source = symlink "${xdgconf}/firefox/bookmarks.html";
    enable = true;
    force = true;
    recursive = true;
  };
  xdg.configFile."mozilla/firefox/profile/prefs.js" = {
    source = symlink "${xdgconf}/firefox/prefs.js";
    enable = true;
    force = true;
    recursive = true;
  };
  xdg.configFile."mozilla/firefox/profile/search.json.mozlz4" = {
    source = symlink "${xdgconf}/firefox/search.json.mozlz4";
    enable = true;
    force = true;
    recursive = true;
  };
  xdg.configFile."mozilla/firefox/profile/user.js" = {
    source = symlink "${xdgconf}/firefox/user.js";
    enable = true;
    force = true;
    recursive = true;
  };
  xdg.configFile."mozilla/firefox/profiles.ini" = {
    source = symlink "${xdgconf}/firefox/profiles.ini";
    enable = true;
    force = true;
  };
}
