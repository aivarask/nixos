_: {
  programs.lf = {
    enable = true;
    settings = {
      anchorfind = null;
      color256 = null;
      dircounts = null;
      dirfirst = null;
      drawbox = null;
      errorfmt = null;
      filesep = null;
      findlen = null;
      globsearch = null;
      hidden = false;
      icons = true;
      ifs = "\n";
      ignorecase = null;
      ignoredia = null;
      incsearch = null;
      info = "size";
      number = null;
      period = null;
      preview = null;
      promptfmt = null;
      ratios = "1:2";
      relativenumber = null;
      reverse = null;
      scrolloff = 4;
      shell = "zsh";
      shellopts = "-ey";
      smartcase = null;
      smartdia = null;
      sortby = null;
      tabstop = null;
      timefmt = null;
      wrapscan = null;
      wrapscroll = null;
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
      "<c-f>" = "$fzf";
      "<c-e>" = "$(fzf -m) | xargs -r $EDITOR";
      "<c-g>" = "$fzl";
      "g~" = ''$lf -remote "send $id cd $HOME"'';
      "gn" = ''$lf -remote "send $id cd /etc/nixos"'';
      "gc" = ''$lf -remote "send $id cd ~/fixasparts/src/comp"'';
      "gl" = ''$lf -remote "send $id cd ~/fixasparts/src/lib"'';
      "gr" = ''$lf -remote "send $id cd ~/fixasparts/src/routes"'';
      "gp" = ''$lf -remote "send $id cd ~/fixasparts/prisma"'';
      "gu" = ''$lf -remote "send $id cd ~/fixasparts/src/util"'';
      "gt" = ''$lf -remote "send $id cd ~/fixasparts/src/routes/_test"'';
      "of" = ''!firefox $fx'';
      "oz" = ''!zathura $fx'';
      "til" = "$touch init.lua";
      "tlt" = "$touch +layout.server.ts";
      "tls" = "$touch +layout.svelte";
      "tpt" = "$touch +page.server.ts";
      "tps" = "$touch +page.svelte";
      "tst" = "$touch +server.ts";
    };
    cmdKeybindings = {};
    extraConfig = ''
      $mkdir -p ~/.trash
      # set previewer pistol
      set previewer pistol
      map t
    '';
  };
}
