{ pkgs, ... }:
{
  # https://github.com/rothgar/mastering-zsh
  home.packages = with pkgs; [
    bash-language-server
    shellcheck
    shfmt
    dotenv-linter
    shellharden
  ];
  programs.zsh.autocd = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.autosuggestion.enable = true;
  # programs.zsh.dotDir = ".config/zsh";
  programs.zsh.history.size = 10000;
  programs.zsh.history.extended = true;
  programs.zsh.plugins = [
    #https://github.com/agkozak/zhooks
    # {
    #   name = "vi-mode";
    #   src = pkgs.zsh-vi-mode; # https://github.com/jeffreytse/zsh-vi-mode
    #   file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
    # }
    # {
    #   name = "system-clipboard";
    #   src = pkgs.zsh-system-clipboard; # https://github.com/kutsan/zsh-system-clipboard
    #   file = "share/zsh/zsh-system-clipboard/zsh-system-clipboard.zsh";
    # }
  ];

}
