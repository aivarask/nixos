{ config, pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      import = [ ./gruvbox.yml ];
      key_bindings = [
        {
          key = "Return";
          mods = "Control";
          action = "SpawnNewInstance";
        }
      ];
    };
  };
}
