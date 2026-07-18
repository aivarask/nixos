{
  SELF,
  ...
}:

{
  environment.etc."firefox/policies/policies.json".source = "/etc/nixos/firefox/policies.json";
  home-manager.sharedModules = [
    (
      { config, ... }:
      let
        ff = "mozilla/firefox";
        ffprof = "${ff}/aiva.profile";
        ffproftest = "${ff}/_test.profile";
        s = "${SELF}/firefox";
      in
      {
        home.file.".mozilla/native-messaging-hosts".enable = false;
        programs.firefox.enable = true;
        programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";
        programs.firefox.languagePacks = [ "en-US" ];

        xdg.configFile = {
          "${ff}/profiles.ini" = {
            force = true;
            source = config.lib.file.mkOutOfStoreSymlink "${s}/profiles.ini";
          };

          ## aiva.profile
          "${ffprof}/chrome/userChrome.css" = {
            force = true;
            source = config.lib.file.mkOutOfStoreSymlink "${s}/userChrome.css";
          };
          "${ffprof}/chrome/userContent.css" = {
            force = true;
            source = config.lib.file.mkOutOfStoreSymlink "${s}/userContent.css";
          };
          "${ffprof}/places.sqlite" = {
            force = true;
            source = config.lib.file.mkOutOfStoreSymlink "${s}/places.sqlite";
          };
          "${ffprof}/prefs.js" = {
            force = true;
            source = config.lib.file.mkOutOfStoreSymlink "${s}/prefs.js";
          };
          "${ffprof}/user.js" = {
            force = true;
            source = config.lib.file.mkOutOfStoreSymlink "${s}/user.js";
          };

          ## _test.profile
          "${ffproftest}/chrome/userChrome.css" = {
            force = true;
            source = config.lib.file.mkOutOfStoreSymlink "${s}/userChrome.css";
          };
          "${ffproftest}/chrome/userContent.css" = {
            force = true;
            source = config.lib.file.mkOutOfStoreSymlink "${s}/userContent.css";
          };
          "${ffproftest}/prefs.js" = {
            force = true;
            source = config.lib.file.mkOutOfStoreSymlink "${s}/prefs.js";
          };
          "${ffproftest}/user.js" = {
            force = true;
            source = config.lib.file.mkOutOfStoreSymlink "${s}/user.js";
          };
        };
      }
    )
  ];
}
