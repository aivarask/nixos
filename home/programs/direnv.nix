_: {
  home.shellAliases.da = "direnv allow";
  programs.direnv = {
    enable = true;
    # silent = false;
    nix-direnv.enable = true;
    # https://direnv.net/man/direnv.toml.1.html#codeloaddotenvcode
    config = {
      load_dotenv = true;
    };
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
