{ pkgs, ... }: {
  environment = {
    profiles = [
      # $NIX_PROFILES
      # "/etc/nixos"
      "${pkgs.zsh-completions}"
    ];
    variables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      editor = "vim";
      PNPM_HOME = "$HOME/.pnpm-global";
      NODE_OPTIONS = "--no-warnings";
      GDK_SCALE = "1";
      GDK_DPI_SCALE = "1";
      QT_AUTO_SCREEN_SET_FACTOR = "0";
      QT_SCALE_FACTOR = "1";
      QT_FONT_DPI = "144";
      XINITRC = "/etc/nixos/xinitrc";
      # XSERVERRC = "/etc/X11/xinit/xserverrc";
    };
    shellAliases = {
      codium = "codium --no-sandbox --user-data-dir ~/.codium";
      brave = "brave --no-sandbox --enable-features=TouchpadOverscrollHistoryNavigation";
      wol_pc = "wol b4:2e:99:61:09:cf";
      ".." = "cd ..";
      "..." = "../..";
      l = "ls -l --group-directories-first";
      la = "ls -la";
      lg = "lazygit";
      ls = "eza --icons --git";
      lt = "ls --tree --level=2";
      oras = "curl wttr.in/Vilnius";
      tre = "trans :en";
      trl = "trans :lt";
      x = "startx";
      xs = "xinit $XINITRC -- $XSERVERRC";
      xa = "startx $XINITRC awesome";
    };
    sessionVariables = rec {
      # https://nixos.wiki/wiki/Environment_variables
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";

      XDG_BIN_HOME = "$HOME/.local/bin";

      PATH = [
        "${XDG_BIN_HOME}"
        "/etc/nixos/bin"
        "$HOME/.pnpm-global"
        "$HOME/.node_modules/bin"
        "$HOME/.config/composer/vendor/bin"
      ];

    };
    variables.LF_ICONS = ''
      tw=:\
      st=:\
      ow=:\
      dt=:\
      di=:\
      fi=:\
      ln=:\
      or=:\
      ex=:\
      *.c=:\
      *.cc=:\
      *.clj=:\
      *.coffee=:\
      *.cpp=:\
      *.css=:\
      *.d=:\
      *.dart=:\
      *.erl=:\
      *.exs=:\
      *.fs=:\
      *.go=:\
      *.h=:\
      *.hh=:\
      *.hpp=:\
      *.hs=:\
      *.html=:\
      *.java=:\
      *.jl=:\
      *.js=:\
      *.json=:\
      *.lua=:\
      *.md=:\
      *.php=:\
      *.pl=:\
      *.pro=:\
      *.py=:\
      *.rb=:\
      *.rs=:\
      *.scala=:\
      *.ts=:\
      *.vim=:\
      *.cmd=:\
      *.ps1=:\
      *.sh=:\
      *.bash=:\
      *.zsh=:\
      *.fish=:\
      *.tar=:\
      *.tgz=:\
      *.arc=:\
      *.arj=:\
      *.taz=:\
      *.lha=:\
      *.lz4=:\
      *.lzh=:\
      *.lzma=:\
      *.tlz=:\
      *.txz=:\
      *.tzo=:\
      *.t7z=:\
      *.zip=:\
      *.z=:\
      *.dz=:\
      *.gz=:\
      *.lrz=:\
      *.lz=:\
      *.lzo=:\
      *.xz=:\
      *.zst=:\
      *.tzst=:\
      *.bz2=:\
      *.bz=:\
      *.tbz=:\
      *.tbz2=:\
      *.tz=:\
      *.deb=:\
      *.rpm=:\
      *.jar=:\
      *.war=:\
      *.ear=:\
      *.sar=:\
      *.rar=:\
      *.alz=:\
      *.ace=:\
      *.zoo=:\
      *.cpio=:\
      *.7z=:\
      *.rz=:\
      *.cab=:\
      *.wim=:\
      *.swm=:\
      *.dwm=:\
      *.esd=:\
      *.jpg=:\
      *.jpeg=:\
      *.mjpg=:\
      *.mjpeg=:\
      *.gif=:\
      *.bmp=:\
      *.pbm=:\
      *.pgm=:\
      *.ppm=:\
      *.tga=:\
      *.xbm=:\
      *.xpm=:\
      *.tif=:\
      *.tiff=:\
      *.png=:\
      *.svg=:\
      *.svgz=:\
      *.mng=:\
      *.pcx=:\
      *.mov=:\
      *.mpg=:\
      *.mpeg=:\
      *.m2v=:\
      *.mkv=:\
      *.webm=:\
      *.ogm=:\
      *.mp4=:\
      *.m4v=:\
      *.mp4v=:\
      *.vob=:\
      *.qt=:\
      *.nuv=:\
      *.wmv=:\
      *.asf=:\
      *.rm=:\
      *.rmvb=:\
      *.flc=:\
      *.avi=:\
      *.fli=:\
      *.flv=:\
      *.gl=:\
      *.dl=:\
      *.xcf=:\
      *.xwd=:\
      *.yuv=:\
      *.cgm=:\
      *.emf=:\
      *.ogv=:\
      *.ogx=:\
      *.aac=:\
      *.au=:\
      *.flac=:\
      *.m4a=:\
      *.mid=:\
      *.midi=:\
      *.mka=:\
      *.mp3=:\
      *.mpc=:\
      *.ogg=:\
      *.ra=:\
      *.wav=:\
      *.oga=:\
      *.opus=:\
      *.spx=:\
      *.xspf=:\
      *.pdf=:\
      *.nix=:\
    '';
  };
}
