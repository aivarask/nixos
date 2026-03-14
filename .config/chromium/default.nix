{ pkgs, ... }:
{
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.chromium = {
    enable = true;
    # homepageLocation = "https://www.startpage.com/";
    commandLineArgs = [
      "--no-sandbox"
      # "--enable-features=AcceleratrdVideoEncoder"
      "--ignore-gpu-blocklist"
      "--enable-zero-copy"
    ];
    extensions = [
      # "eimadpbcbfnmbkopoojfekhnkhdbieeh;https://clients2.google.com/service/update2/crx" # dark reader
      # "aapbdbdomjkkjkaonfhkkikfgjllcleb;https://clients2.google.com/service/update2/crx" # google translate
      "mlomiejdfkolichcflejclcbmpeaniij" # ghostery
    ];
  };
}
