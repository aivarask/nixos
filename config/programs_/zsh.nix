# vim:nofoldenable
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
    plugins = [ ];
  };
}
