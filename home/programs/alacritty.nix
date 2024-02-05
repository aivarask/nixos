{ lib, osConfig, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      keyboard = {
        bindings = [
          {
            key = "Return";
            mods = "Control";
            action = "SpawnNewInstance";
          }
        ];
      };
      font.size = if osConfig.networking.hostName == "dell" then 7.0 else 12;
      import = [ ./a_gruvbox.toml ];
    };
  };
}
