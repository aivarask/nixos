{
  ...
}:

{
  environment.etc."firefox/policies/policies.json".source = "/etc/nixos/firefox/policies.json";
  home-manager.sharedModules = [
    (
      { config, SELF, ... }:
      let
        ff = "mozilla/firefox";
        ffprof = "${ff}/aiva.profile";
        s = "${SELF}/firefox";
      in
      {
        home.file.".mozilla/native-messaging-hosts".enable = false;
        programs.firefox.enable = true;
        programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";
        programs.firefox.languagePacks = [ "en-US" ];
        xdg.configFile."${ff}/profiles.ini" = {
          force = true;
          source = config.lib.file.mkOutOfStoreSymlink "${s}/profiles.ini";
        };
        xdg.configFile."${ffprof}/chrome/userChrome.css" = {
          force = true;
          source = config.lib.file.mkOutOfStoreSymlink "${s}/userChrome.css";
        };
        xdg.configFile."${ffprof}/chrome/userContent.css" = {
          force = true;
          source = config.lib.file.mkOutOfStoreSymlink "${s}/userContent.css";
        };
        xdg.configFile."${ffprof}/places.sqlite" = {
          force = true;
          source = config.lib.file.mkOutOfStoreSymlink "${s}/places.sqlite";
        };
        xdg.configFile."${ffprof}/prefs.js" = {
          force = true;
          source = config.lib.file.mkOutOfStoreSymlink "${s}/prefs.js";
        };
        xdg.configFile."${ffprof}/user.js" = {
          force = true;
          source = config.lib.file.mkOutOfStoreSymlink "${s}/user.js";
        };
      }
    )
  ];
}
