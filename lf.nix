{ config, pkgs, ... }: {
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
      "aa" = "push :touch<space>";
      A = "push :mkdir<space>";
      U = "!du -hs $fx";
      T = ":get-mime-type";
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
      "gc" = ''$lf -remote "send $id cd ~/svelte-sandbox/src/comp"'';
      "gl" = ''$lf -remote "send $id cd ~/svelte-sandbox/src/lib"'';
      "gr" = ''$lf -remote "send $id cd ~/svelte-sandbox/src/routes"'';
      "gp" = ''$lf -remote "send $id cd ~/svelte-sandbox/prisma"'';
      "gu" = ''$lf -remote "send $id cd ~/svelte-sandbox/src/util"'';
      "gt" = ''$lf -remote "send $id cd ~/svelte-sandbox/src/routes/_test"'';
      "of" = ''!firefox $fx'';
      "alt" = "$touch +layout.server.ts";
      "als" = "$touch +layout.svelte";
      "apt" = "$touch +page.server.ts";
      "aps" = "$touch +page.svelte";

    };
    cmdKeybindings = { };
    extraConfig = ''
      $mkdir -p ~/.trash
      set previewer pistol
    '';
  };

} 
