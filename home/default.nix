_: {
  imports = [
    ../vim
    ./files.nix
    ./home-cursor.nix
    ./home-environment.nix
    ./misc/gtk.nix
    ./misc/version.nix
    ./misc/xdg.nix
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
    ./programs/vscode.nix
    ./programs/zsh.nix
    ./services/dunst.nix
    ./services/sxhkd.nix
  ];
  programs.home-manager.enable = true;
}
