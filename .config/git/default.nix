{
  pkgs,
  config,
  xdgconf,
  ...
}:
let
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.packages = with pkgs; [
    git
    git-lfs
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
  xdg.configFile."git/config_global".source = symlink "${xdgconf}/git/config_global";
  xdg.configFile."git/config_user".source = symlink "${xdgconf}/git/config_user";
  xdg.configFile."git/ignore".source = symlink "${xdgconf}/git/ignore";

}
