{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    lazygit
    git
    git-lfs
    gitlab
    gitlab-shell
    glab
    delta
    gh
    git-crypt
  ];
}
