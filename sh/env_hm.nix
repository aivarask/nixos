{
  config,
  SELF,
  lib,
  ...
}:
{
  # /etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh
  # https://mynixos.com/home-manager/options/xsession
  xsession.enable = true;
  xsession.profileExtra = ''# HM xsession.profileExtra ''; # $HOME/.xprofile
  xsession.initExtra = ''# HM xsession.initExtra ''; # $HOME/.xsession
  programs.bash.enable = true;
  programs.bash.profileExtra = ''# HM programs.bash.profileExtra ''; # $HOME/.bash_profile
  programs.bash.initExtra = ''# HM programs.bash.initExtra ''; # $HOME/.bashrc
  programs.zsh.enable = true;
  programs.zsh.profileExtra = ''# HM programs.zsh.profileExtra ''; # $HOME/.zprofile
  programs.zsh.envExtra = ''# HM programs.zsh.envExtra ''; # $HOME/.zshenv
  # programs.zsh.initExtraBeforeCompInit = ''# HM programs.zsh.initExtraBeforeCompinit ''; # $HOME/.zshrc
  # programs.zsh.initContent = lib.mkOrder 550 ''# HM programs.zsh.initExtraBeforeCompinit ''; # $HOME/.zshrc
  programs.zsh.completionInit = ''# HM programs.zsh.completionInit '';
  # programs.zsh.initExtra = ''
  #    # HM programs.zsh.initExtra
  #   source $HOME/.zshrc.extra
  # '';
  programs.zsh.initContent = ''
     # HM programs.zsh.initContent
    source $HOME/.zshrc.extra
  '';

  home.file.".zshrc.extra".source = config.lib.file.mkOutOfStoreSymlink "${SELF}/sh/zshrc.extra";
}
