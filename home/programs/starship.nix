_: {
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      package = { disabled = true; };
      golang = { disabled = true; };
      lua = { disabled = true; };
      nodejs = { disabled = true; };
      php = { disabled = true; };
      rust = { disabled = true; };
    };
  };
}
