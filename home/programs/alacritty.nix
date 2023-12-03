{lib, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      # https://github.com/alacritty/alacritty/blob/master/extra/man/alacritty.5.scd
      import = [./gruvbox.yml];
      key_bindings = [
        {
          key = "Return";
          mods = "Control";
          action = "SpawnNewInstance";
        }
      ];

      font.size = lib.mkDefault 8.0;
      # window.opacity = 0.9;
      # window.decorations = "none";
    };
  };
}
