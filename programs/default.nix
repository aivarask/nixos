{ ... }:
{
  programs.mtr.enable = true;
  programs.bandwhich.enable = false;
  programs.browserpass.enable = false;
  programs.iftop.enable = true;
  programs.npm.enable = true;
  programs.screen = {
    enable = true;
    screenrc = '''';
  };
  programs.sharing.enable = true;
  programs.wireshark.enable = true;

}
