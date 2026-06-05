{
  ...
}:

{
  home-manager.sharedModules = [
    (
      { config, SELF, ... }:
      let
        ff = "mozilla/firefox";
        ffprof = "${ff}/profile";
        s = "${SELF}/firefox";
      in
      {
        home.file.".mozilla/native-messaging-hosts".enable = false;
        programs.firefox.enable = true;
        programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";
        programs.firefox.languagePacks = [ "en-US" ];
        xdg.configFile."${ff}/profiles.ini".source =
          config.lib.file.mkOutOfStoreSymlink "${s}/profiles.ini";
        xdg.configFile."${ffprof}/chrome/userChrome.css".source =
          config.lib.file.mkOutOfStoreSymlink "${s}/userChrome.css";
        xdg.configFile."${ffprof}/chrome/userContent.css".source =
          config.lib.file.mkOutOfStoreSymlink "${s}/userContent.css";
        xdg.configFile."${ffprof}/user.js".source = config.lib.file.mkOutOfStoreSymlink "${s}/user.js";
      }
    )
  ];
}
