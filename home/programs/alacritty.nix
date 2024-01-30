{ lib, config, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      # https://github.com/alacritty/alacritty/blob/master/extra/man/alacritty.5.scd
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

      import = [ ./a_gruvbox.toml ];

      # colors = with config.colorScheme.colors; rec {
      #   cursor = { text = "CellBackground"; cursor = "CellForeground"; };
      #   vi_mode_cursor = cursor;
      #   selection = cursor;
      #   primary = {
      #     background = "0x${base00}"; #282828
      #     foreground = "0x${base06}"; #ebdbb2
      #     bright_foreground = "0x${base07}"; #fbf1c7
      #     dim_foreground = "0x${base04}"; #bdae93
      #   };
      #   normal = {
      #     black = "0x${base00}";
      #     red = "0x${base08}";
      #     green = "0x${base0B}";
      #     yellow = "0x${base0A}";
      #     blue = "0x${base0D}";
      #     magenta = "0x${base0E}";
      #     cyan = "0x${base0C}";
      #     white = "0x${base07}";
      #   };
      # };
    };
  };
}
