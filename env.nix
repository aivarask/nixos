{
  system =
    { lib, ... }:
    {
      imports = [
        (lib.mkAliasOptionModule [ "env" ] [ "environment" ])
        (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" "root" ])
      ];
      environment.variables.SELF = "/etc/nixos";
      environment.variables.EDITOR = "vim";
      environment.pathsToLink = [
        #	 "/share/zsh"
        #	 "/share/fish"
      ];
      environment.sessionVariables = rec {
        XDG_CACHE_HOME = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_DATA_HOME = "$HOME/.local/share";
        XDG_STATE_HOME = "$HOME/.local/state";
        XDG_BIN_HOME = "$HOME/.local/bin";
        PATH = [
          "${XDG_BIN_HOME}"
          "/etc/nixos/bin"
        ];
      };
      environment.shellAliases.wol_pc = "wol b4:2e:99:61:09:cf";
      environment.profiles = [ "/etc/nixos" ];
      environment.shellInit = ''# OS environment.shellInit ''; # /etc/profile
      environment.extraInit = ''# OS environment.extraInit ''; # /etc/set-environment
      programs.bash.shellInit = ''# OS programs.bash.shellInit ''; # /etc/bashrc
      programs.bash.interactiveShellInit = ''# OS programs.bash.interactiveShellInit '';
      environment.interactiveShellInit = ''# OS environment.interactiveShellInit '';
      programs.zsh.enable = true;
      # /etc/zshenv /etc/zshrc /etc/zinputrc
      programs.zsh.shellInit = ''# OS programs.zsh.shellInit '';
    };
  hm =
    {
      config,
      SELF,
      lib,
      ...
    }:
    {
      programs.bash.enable = true;
      programs.bash.profileExtra = ''# HM programs.bash.profileExtra ''; # $HOME/.bash_profile
      programs.bash.initExtra = ''
        # HM programs.bash.initExtra 
        source $HOME/.bashrc_
      ''; # $HOME/.bashrc
      home.file.".bashrc_".source = config.lib.file.mkOutOfStoreSymlink "${SELF}/.bashrc_";
      home.file.".alias".source = config.lib.file.mkOutOfStoreSymlink "${SELF}/.alias";

      programs.zsh.enable = true;
      programs.zsh.profileExtra = ''
        # HM programs.zsh.profileExtra 
        source $HOME/.zprofile_
      ''; # $HOME/.zprofile
      programs.zsh.envExtra = ''
        # HM programs.zsh.envExtra 
        source $HOME/.zshenv_
      ''; # $HOME/.zshenv
      # programs.zsh.initExtraBeforeCompInit = ''# HM programs.zsh.initExtraBeforeCompinit ''; # $HOME/.zshrc
      # programs.zsh.initContent = lib.mkOrder 550 ''# HM programs.zsh.initExtraBeforeCompinit ''; # $HOME/.zshrc
      programs.zsh.completionInit = ''# HM programs.zsh.completionInit '';
      programs.zsh.initContent = ''
            # HM programs.zsh.initContent
        		source $HOME/.zshrc_
      '';
      home.file.".zprofile_".source = config.lib.file.mkOutOfStoreSymlink "${SELF}/.zprofile_";
      home.file.".zshenv_".source = config.lib.file.mkOutOfStoreSymlink "${SELF}/.zshenv_";
      home.file.".zshrc_".source = config.lib.file.mkOutOfStoreSymlink "${SELF}/.zshrc_";
    };
}
