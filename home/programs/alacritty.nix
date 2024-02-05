{ lib, ... }: {
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
      font.size = lib.mkDefault 10.0;
      import = [ ./a_gruvbox.toml ];
    };
  };
}
