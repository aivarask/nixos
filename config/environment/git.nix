{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    git-lfs
    lazygit
    delta
    gh
    git-crypt
    pre-commit
  ];
}
