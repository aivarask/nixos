{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    git-lfs
    lazygit
    gitlab
    gitlab-shell
    glab
    delta
    gh
    git-crypt
  ];
}
