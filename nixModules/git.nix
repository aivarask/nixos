{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    git-lfs
    gh
    git-crypt
    pre-commit
  ];
}
