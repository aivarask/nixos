{ pkgs, xdgconf, ... }:
{
  home.packages = with pkgs; [
    git
    git-lfs
    gh
    git-crypt
    pre-commit
    delta
    lazygit
    difftastic
    diff-so-fancy
    python3Packages.ydiff
    patchutils
  ];
  programs.git.enable = true;
  # programs.git.package = pkgs.gitFull;
  programs.git.lfs.enable = true;
  programs.git.maintenance.enable = true;
  programs.git.settings = {
    include.path = [
      "${xdgconf}/git/config_global"
      "${xdgconf}/git/config_user"
    ];
  };
}
