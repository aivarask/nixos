{ ... }:
{
  programs.nix-index-database.comma.enable = true;
  programs.nix-index.enable = true;
  programs.nix-index.enableZshIntegration = true;
  programs.nix-index.enableBashIntegration = true;
}
