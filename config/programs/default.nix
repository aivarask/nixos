{ ... }: {
  programs.mtr.enable = true;
  programs.bandwhich.enable = true;
  programs.browserpass.enable = false;
  programs.iftop.enable = true;
  programs.npm.enable = true; # check other files
  programs.screen = {
    enable = true;
    screenrc = ''
'';
  };
  programs.sharing.enable = true;
  programs.wireshark.enable = true; # tshark 
}
