{ config, pkgs, ... }: {
  console = {
    earlySetup = true;
    font = "ter-i16b";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
  };
}
