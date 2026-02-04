{
  pkgs,
  config,
  lib,
  SELF,
  homeManager,
  ...
}:
{
  # https://github.com/rothgar/mastering-zsh
  home.packages = with pkgs; [
    bash-language-server
    shellcheck
    shfmt
    dotenv-linter
    shellharden
    zoxide
  ];

  xdg.configFile."zsh/.zshenv_".source =
    config.lib.file.mkOutOfStoreSymlink "${SELF}/.config/zsh/.zshenv_";
  xdg.configFile."zsh/.zshrc_".source =
    config.lib.file.mkOutOfStoreSymlink "${SELF}/.config/zsh/.zshrc_";
  programs.zsh.envExtra = builtins.concatStringsSep "\n" [
    "source $ZDOTDIR/.zshenv_"
  ];
  programs.zsh.initContent = builtins.concatStringsSep "\n" [
    "source $HOME/.alias"
    "source $ZDOTDIR/.zshrc_"
  ];
  programs.zsh.enable = true;
  programs.zsh.autocd = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.autosuggestion.enable = false;
  programs.zsh.dotDir = "${config.xdg.configHome}/zsh";
  programs.zsh.history.size = 10000;
  programs.zsh.history.extended = true;
  programs.zsh.history.share = true;
  xdg.configFile."zsh-system-clipboard/method".source =
    config.lib.file.mkOutOfStoreSymlink "${SELF}/.config/zsh-system-clipboard/method";
  programs.zsh.plugins = [
    # {
    #   name = "zsh-system-clipboard";
    #   src = pkgs.zsh-system-clipboard; # https://github.com/kutsan/zsh-system-clipboard
    #   file = "share/zsh/zsh-system-clipboard/zsh-system-clipboard.zsh"; # ~/.config/zsh/plugins/zsh-system-clipboard/share/zsh/zsh-system-clipboard/zsh-system-clipboard.zsh
    # }
    {
      name = "zsh-zhooks"; # https://github.com/agkozak/zhooks
      src = pkgs.zsh-zhooks;
      file = "share/zsh/zhooks/zhooks.plugin.zsh";
    }
    # {
    #   name = "zsh-autocomplete"; # https://github.com/marlonrichert/zsh-autocomplete
    #   src = pkgs.zsh-autocomplete;
    #   file = "share/zsh-autocomplete/zsh-autocomplete.plugin.zsh";
    #   completions = [ "share/zsh/site-functions" ];
    # }
    {
      name = "vi-mode";
      src = pkgs.zsh-vi-mode; # https://github.com/jeffreytse/zsh-vi-mode
      file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
    }
  ];

}
