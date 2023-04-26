{pkgs, ...}: {
  imports = [
    ../vim
    ./alacritty.nix
    ./bat.nix
    ./fzf.nix
    ./git.nix
    ./glow.nix
    ./lf.nix
    ./pistol.nix
    ./sxhkd.nix
    ./zsh.nix
    ./firefox.nix
  ];
  # https://mynixos.com/search?q=home+variables
  systemd.user.sessionVariables = {
    FOO = "home systemd.user.sessionVariables";
  };
  programs.zsh.localVariables = {
    FOO = "zsh.localVariables";
  };
  home = {
    pointerCursor = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
      size = 64;
    };
    sessionVariables = {
      FOO = "home.sessionVariables1";
      BROWSER = "firefox";
      MOZ_X11_EGL = "1";
    };
    stateVersion = "18.09";
    file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";
    file.".xinitrc".text = builtins.readFile ./xinitrc;
  };
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--no-sandbox"
      "--enable-features=TouchpadOverscrollHistoryNavigation"
      "--no-default-browser-check"
    ];
    extensions = [
      {
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; # uBlock Origin
      }
      {
        id = "dbepggeogbaibhgnhhndojpepiihcmeb"; # vimium
      }
    ];
  };

  services = {
    redshift = {
      enable = true;
      temperature = {
        day = 6500; # 5500
        night = 4500; # 3700
      };
      latitude = 54.0;
      longitude = 25.0;
      provider = "manual";
    };
    dunst = {enable = true;};
    unclutter = {
      enable = true;
      timeout = 2;
    };
  };

  programs.ncmpcpp = {
    enable = true;
    settings = {
      "allow_for_physical_item_deletion" = "yes";
      "user_interface" = "alternative";
      "alternative_header_first_line_format" = "$b$5«« {%a}|{%t} »»$9$/b";
      alternative_header_second_line_format = "$b$5 {%b}|{%f} {%b} ({%y})$9$/b";
      song_columns_list_format = "(40)[blue]{a|f} (40)[green]{tE} (20)[blue]{bE}";
    };
  };
}
