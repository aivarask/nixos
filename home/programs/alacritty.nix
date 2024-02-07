{ osConfig, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      import = [ ./a_gruvbox.toml ];
      font.size = if osConfig.networking.hostName == "dell" then 8 else 12;
      keyboard = {
        bindings = [
          { key = "Return"; mods = "Control"; action = "SpawnNewInstance"; }
        ];
      };
    };
  };
}
