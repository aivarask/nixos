{ ... }:
{
  home.shellAliases = {
    hx = "hx -c /etc/nixos/home/programs/helix/config.toml";
  };
  programs.helix = {
    enable = true;
    themes = {
      autumn_night_transparent = {
        "inherits" = "autumn_night";
        "ui.background" = { };
      };
    };
  };
}
