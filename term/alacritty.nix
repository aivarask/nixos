{
  home-manager =
    { osConfig, config, ... }:
    {
      xdg.configFile."alacritty/alacritty_.toml".source =
        config.lib.file.mkOutOfStoreSymlink "/etc/nixos/term/alacritty_.toml";
      xdg.configFile."alacritty/alacritty_hints.toml".source =
        config.lib.file.mkOutOfStoreSymlink "/etc/nixos/term/alacritty_hints.toml";
      xdg.dataFile."applications/alacritty.desktop".source =
        config.lib.file.mkOutOfStoreSymlink "/etc/nixos/term/alacritty.desktop";
      programs.alacritty = {
        enable = true;
        settings = {
          general.import = [
            ./gruvbox.toml
            "alacritty_.toml"
          ];
        };
      };
    };
}
