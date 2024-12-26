# vim: nofoldenable
{ pkgs, ... }:
{
  # sh
  home.packages = with pkgs; [
    zed-editor
    nodePackages.bash-language-server
    shellcheck
    shfmt
    dotenv-linter
    shellharden
  ];
  programs.bash.enable = true;
  programs.zsh = {
    enable = true;
    autocd = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    dotDir = ".config/zsh";
    history = {
      size = 10000;
      extended = true;
    };
    profileExtra = '''';
    initExtraBeforeCompInit = ''
      # programs.zsh.initExtraBeforeCompinit
    '';
    completionInit = ''
      # programs.zsh.completionInit
    '';
    initExtra = ''
      # programs.zsh.initExtra
      source /etc/nixos/config/programs_/zshrc.zsh
    '';
    plugins = [
      {
        # https://github.com/olets/zsh-abbr
        # https://zsh-abbr.olets.dev
        name = "zsh-abbr";
        src = pkgs.zsh-abbr;
        file = "share/zsh/zsh-abbr/zsh-abbr.plugin.zsh";
      }
      {
        # https://github.com/olets/zsh-autosuggestions-abbreviations-strategy
        name = "zsh-autosuggestions-abbreviations-strategy";
        src = pkgs.zsh-autosuggestions-abbreviations-strategy;
        file = "share/zsh/site-functions/zsh-autosuggestions-abbreviations-strategy.plugin.zsh";
      }
      # {
      #   # https://github.com/jeffreytse/zsh-vi-mode
      #   name = "vi-mode";
      #   src = pkgs.zsh-vi-mode;
      #   file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      # }
      # {
      #   # https://github.com/kutsan/zsh-system-clipboard
      #   # https://github.com/kutsan/zsh-system-clipboard#options
      #   name = "system-clipboard";
      #   src = pkgs.zsh-system-clipboard;
      #   file = "share/zsh/zsh-system-clipboard/zsh-system-clipboard.zsh";
      # }
    ];
  };
}
