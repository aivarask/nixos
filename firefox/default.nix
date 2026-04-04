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
  s = "${SELF}/firefox";
  d = "mozilla/firefox";
  p = "${d}/profile";

in
{
  home.file.".mozilla/native-messaging-hosts".enable = false;
  programs.firefox.enable = true;
  programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";
  programs.firefox.languagePacks = [ "en-US" ];
  xdg.configFile."${d}/default.nix".source = symlink "${s}/default.nix";
  xdg.configFile."${p}/chrome/userChrome.css".source = symlink "${s}/userChrome.css";
  xdg.configFile."${p}/bookmarks.html".source = symlink "${s}/bookmarks.html";
  xdg.configFile."${p}/prefs.js".source = symlink "${s}/prefs.js";
  xdg.configFile."${p}/search.json.mozlz4".source = symlink "${s}/search.json.mozlz4";
  xdg.configFile."${p}/user.js".source = symlink "${s}/user.js";
  xdg.configFile."${d}/profiles.ini".source = symlink "${s}/profiles.ini";
}
