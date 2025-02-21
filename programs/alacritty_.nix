{ osConfig, ... }:
{
  # home.shellAliases.alacritty = "alacritty --config-file=/etc/nixos/config/files/alacritty.toml";
  programs.alacritty = {
    enable = true;
    settings = {
      general.import = [
        ./gruvbox.toml
      ];
      font = {
        size = if osConfig.networking.hostName == "pc" then 28 else 8;
      };
      window.dimensions.columns = 120;
      window.dimensions.lines = 40;
      keyboard = {
        bindings = [
          {
            key = "Return";
            mods = "Control";
            action = "SpawnNewInstance";
          }
        ];
      };
    };
  };
  programs.wezterm = {
    enable = true;
  };

}
