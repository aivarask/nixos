{pkgs, ...}: {
  imports = [
    ./programs/alacritty.nix
    ./programs/bat.nix
    ./programs/chromium.nix
    ./programs/direnv.nix
    ./programs/firefox.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/lf.nix
    ./programs/ncmpcpp.nix
    ./programs/nix-index.nix
    ./programs/pistol.nix
    ./programs/starship.nix
    ./programs/zsh.nix
    ./services/dunst.nix
    ./services/redshift-gammastep/redshift.nix
    ./services/sxhkd.nix
    ./services/unclutter.nix
    # --
    ../vim
    ./glow.nix
  ];
  # https://mynixos.com/search?q=home+variables
  systemd.user.sessionVariables = {
    FOO = "home systemd.user.sessionVariables";
  };
  programs.zsh.localVariables = {
    FOO = "zsh.localVariables";
  };
  home = {
    file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";
    pointerCursor = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
      size = 64;
      x11 = {
        enable = true;
      };
      gtk = {
        enable = true;
      };
    };
    sessionVariables = {
      FOO = "home.sessionVariables1";
      BROWSER = "firefox";
      MOZ_X11_EGL = "1";
    };
    stateVersion = "18.09";
    file.".xinitrc".text = builtins.readFile ./xinitrc;
  };
}
