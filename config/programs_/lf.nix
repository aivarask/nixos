{ ... }:
{
  xdg.configFile."lf/icons".source = ./lf_icons;
  programs.lf = {
    extraConfig = ''
      $mkdir -p ~/.trash
      set previewer pistol
      map t
      source /etc/nixos/config/programs_/lfrc
    '';
    # ~/.config/lf/lfrc
    enable = true;
    settings = {
      hidden = true;
      icons = true;
      ifs = "\n";
      info = "size";
      ratios = "1:2";
      scrolloff = 8;
      shell = "zsh";
      shellopts = "-ey";
    };
    commands = {
      get-mime-type = ''%xdg-mime query filetype "$f"'';
      open = "$$OPENER $f";
      touch = ''%touch "$@"'';
      mkdir = ''%mkdir "$@"'';
    };
    keybindings = {
      "." = "set hidden!";
      D = "%trash-put $fx";
      a = "push :touch<space>";
      A = "push :mkdir<space>";
      U = "!du -hs $fx";
      T = ":get-mime-type";
      "<esc>" = ":quit";
      "--" = "set ratios 1:2";
      "++" = "set ratios 1:2:3";
      "+w" = "$chmod +w $fx";
      "+x" = "$chmod +x $fx";
      "-w" = "$chmod -w $fx";
      "-x" = "$chmod -x $fx";
      "<c-f>" = "$fzf";
      "<c-g>" = "$Rg";
    };
    cmdKeybindings = { };
  };
}
