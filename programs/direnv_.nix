{ ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      load_dotenv = true;
    };
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
