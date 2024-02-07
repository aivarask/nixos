{ ... }: {
  programs.lf = {
    enable = true;
    settings = {
      hidden = false;
      icons = true;
      ifs = "\n";
      info = "size";
      ratios = "1:2";
      scrolloff = 4;
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
      "<backspace>" = "set hidden!";
      H = "set hidden!";
      D = "%trash-put $fx";
      e = "$$EDITOR $fx";
      E = "$vim $fx";
      a = "push :touch<space>";
      A = "push :mkdir<space>";
      U = "!du -hs $fx";
      T = ":get-mime-type";
      "<esc>" = ":quit";
      ZZ = ":quit";
      lg = "!lazygit";
      "--" = "set ratios 1:2";
      "++" = "set ratios 1:2:3";
      "+x" = "$chmod +x $fx";
      "-x" = "$chmod -x $fx";
      "<c-f>" = "$fzf --preview 'pistol {}'";
      "<c-g>" = "$Rg";
      "gn" = ''$lf -remote "send $id cd /etc/nixos"'';
      "of" = ''!firefox $fx'';
      "oz" = ''!zathura $fx'';
    };
    cmdKeybindings = { };
    extraConfig = ''
      $mkdir -p ~/.trash
      set previewer pistol
      map t
    '';
  };
}
