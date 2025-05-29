{ osConfig, config, ... }:
{
  xdg.configFile."alacritty/alacritty.extra.toml".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/term/alacritty.extra.toml";
  programs.alacritty = {
    enable = true;
    settings = {
      general.import = [
        ./gruvbox.toml
        "alacritty.extra.toml"
      ];
    };
  };
}
