{
  pkgs,
  config,
  xdgconf,
  osConfig,
  ...
}:
let
  username = config.home.username;
  symlink = osConfig.symlink;
in
{
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
  programs.firefox.profiles."test" = {
    id = 2;
    name = "test";
    path = "test";
  };

  programs.firefox.profiles."${username}" = {

    # isDefault = true;
    id = 0;
    name = "${username}";
    path = "${username}";
    search = import ./search.nix;
  };
}
