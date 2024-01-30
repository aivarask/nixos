{ pkgs, ... }: {
  programs.mtr.enable = true;
  programs.adb.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.zsh.enable = true;

}
