{ lib, ... }:
{
  imports = [
    (lib.mkAliasOptionModule [ "env" ] [ "environment" ])
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" "root" ])
  ];
  environment.variables.SELF = "/etc/nixos";
  environment.variables.EDITOR = "vim";
  environment.variables.VISUAL = "nvim";
  environment.pathsToLink = [
  ];
  environment.profiles = [ ];
  environment.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    # XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      # "${XDG_BIN_HOME}"
      "/etc/nixos/bin"
    ];
  };
  environment.shellAliases.wol_pc = "wol b4:2e:99:61:09:cf";
  environment.shellInit = "# OS environment.shellInit "; # /etc/profile
  environment.extraInit = "# OS environment.extraInit "; # /etc/set-environment
  programs.bash.shellInit = "# OS programs.bash.shellInit "; # /etc/bashrc
  programs.bash.interactiveShellInit = "# OS programs.bash.interactiveShellInit ";
  environment.interactiveShellInit = "# OS environment.interactiveShellInit ";
  programs.zsh.enable = true;
  # /etc/zshenv /etc/zshrc /etc/zinputrc
  programs.zsh.shellInit = "# OS programs.zsh.shellInit ";
}
