{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    git-lfs
    # delta
    gh
    git-crypt
    pre-commit
  ];
}
