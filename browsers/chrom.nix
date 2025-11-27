{ pkgs, ... }:
{
  home.sessionVariables.NIXOS_OZONE_WL = "1";
  # home.packages = with pkgs; [
  #   (chromium.override {
  #     # extensions = [ ];
  #     enableWideVine = true;
  #     commandLineArgs = [
  #       "--enable-features=AcceleratedVideoEncoder"
  #       "--ignore-gpu-blocklist"
  #       "--enable-zero-copy"
  #     ];
  #     extraOpts = {
  #       "BrowserSignin" = 0;
  #       "SyncDisabled" = true;
  #       "PasswordManagerEnabled" = false;
  #       "SpellcheckEnabled" = true;
  #       "SpellcheckLanguage" = [
  #         "lt"
  #         "en-US"
  #       ];
  #     };
  #   })
  # ];

  programs.chromium = {
    enable = true;
    # homepageLocation = "https://www.startpage.com/";
    commandLineArgs = [
      "--no-sandbox"
      "--enable-features=AcceleratedVideoEncoder"
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
