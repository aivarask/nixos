_: {
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
      # window.opacity = 0.9;
      # window.decorations = "none";
    };
  };
}
