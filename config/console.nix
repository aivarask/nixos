{pkgs, ...}: {
  console = {
    earlySetup = true;
    packages = with pkgs; [terminus_font];
    keyMap = "us";
  };
}
