{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # chromedriver
    vimpager
  ];
  programs.eza.enable = true;
  programs.eza.icons = "auto";
  programs.eza.enableZshIntegration = false;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.direnv.config = {
    load_dotenv = true;
  };
  programs.direnv.enableBashIntegration = true;
  programs.direnv.enableZshIntegration = true;

  programs.gh.enable = true;
  programs.gh.extensions = with pkgs; [
    gh-eco
    # gh-poi
    # gh-dash
    # gh-actions-cache
    gh-markdown-preview
  ];
  programs.gh.settings = {
    git_protocol = "ssh";
    prompt = "enabled";
    aliases = {
      co = "pr checkout";
      pv = "pr view";
    };
  };
  programs.nix-index-database.comma.enable = true;
  programs.nix-index.enable = true;
  programs.nix-index.enableZshIntegration = true;
  programs.nix-index.enableBashIntegration = true;
}
