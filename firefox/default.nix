{
  pkgs,
  lib,
  config,
  SELF,
  xdgconf,
  osConfig,
  inputs,
  ...
}:
let

  username = config.home.username;
  symlink = osConfig.symlink;
  s = "${SELF}/firefox";
  ff = "mozilla/firefox";
  ffprof = "${ff}/profile";
  zen = "zen";
  zenprof = "${zen}/profile_zen_twilight";
in
{
  # https://github.com/0xc000022070/zen-browser-flake
  imports = [
    # inputs.zen-browser.homeModules.twilight
  ];
    programs.zen-browser.nativeMessagingHosts = [pkgs.firefoxpwa];
  programs.zen-browser = {
    enable = true;

    # setAsDefaultBrowser = true;
  };
  # home.packages = with pkgs; [
  #   # inputs.zen-browser.homeModules.twilight
  #   (inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.twilight-unwrapped.override (
  #     lib.importJSON ./policies.json
  #   ))
  # ];
  home.file.".mozilla/native-messaging-hosts".enable = false;
  programs.firefox.enable = true;
  programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";
  programs.firefox.languagePacks = [ "en-US" ];

  xdg.configFile."${ff}/profiles.ini".source = symlink "${s}/profiles.ini";
  xdg.configFile."${ffprof}/chrome/userChrome.css".source = symlink "${s}/userChrome.css";
  xdg.configFile."${ffprof}/chrome/userContent.css".source = symlink "${s}/userContent.css";
  xdg.configFile."${ffprof}/user.js".source = symlink "${s}/user.js";
  xdg.configFile."${zen}/profiles.ini".source = symlink "${s}/profiles.ini";
  xdg.configFile."${zenprof}/chrome/userChrome.css".source = symlink "${s}/userChrome.css";
  xdg.configFile."${zenprof}/chrome/userContent.css".source = symlink "${s}/userContent.css";
  xdg.configFile."${zenprof}/user.js".source = symlink "${s}/user.js";
}
