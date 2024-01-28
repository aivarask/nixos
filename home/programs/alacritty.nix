{ lib, config, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      # https://github.com/alacritty/alacritty/blob/master/extra/man/alacritty.5.scd
      import = [ /etc/nixos/home/files/gruvbox.toml ];
      keyboard = {
        bindings = [
          {
            key = "Return";
            mods = "Control";
            action = "SpawnNewInstance";
          }
        ];
      };

      font.size = lib.mkDefault 7.0;
      # font.size = lib.mkDefault 10.0;
      # window.opacity = 0.9;
      # window.decorations = "none";
      # colors = with config.colorScheme.colors; {
      #   bright = {
      #     black = "0x${base00}";
      #     blue = "0x${base0D}";
      #     cyan = "0x${base0C}";
      #     green = "0x${base0B}";
      #     magenta = "0x${base0E}";
      #     red = "0x${base08}";
      #     white = "0x${base06}";
      #     yellow = "0x${base09}";
      #   };
      #   cursor = {
      #     cursor = "0x${base06}";
      #     text = "0x${base06}";
      #   };
      #   normal = {
      #     black = "0x${base01}";
      #     blue = "0x${base0D}";
      #     cyan = "0x${base0C}";
      #     green = "0x${base0B}";
      #     magenta = "0x${base0E}";
      #     red = "0x${base08}";
      #     white = "0x${base06}";
      #     yellow = "0x${base0A}";
      #   };
      #   primary = {
      #     background = "0x${base00}";
      #     foreground = "0x${base06}";
      #   };
      # };
    };
  };
}
