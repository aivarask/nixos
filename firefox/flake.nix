{
  outputs =
    { ... }:
    {
      nixosModules = {
        default = _: { environment.profiles = [ "${./.}" ]; };
        home =
          { pkgs, ... }:
          let
            bookmarks = {
              force = true;
              settings = [
                (import ./bookmarks_about.nix)
                (import ./bookmarks_nix.nix)
                (import ./bookmarks_.nix)
              ];
            };
            search = {
              force = true;
              default = "ddg";
              privateDefault = "ddg";
              order = [
                "ddg"
                "google"
                "bing"
              ];
              engines = import ./engines.nix;
            };
            # https://www.reddit.com/r/FirefoxCSS/wiki/index/tutorials/
            # https://firefox-source-docs.mozilla.org/devtools-user/browser_toolbox/index.html
            # https://github.com/doc-han/xtensio
            userChrome = ''
              * {
                box-shadow: none !important;
                border: 0px solid !important;
                }
            '';
            userContent = ''
              * {
                scrollbar-width:none !important;
              }
            '';
            settings = {
              "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
              "devtools.debugger.remote-enabled" = true;
              "browser.aboutConfig.showWarning" = false;
              "accessibility.typeaheadfind" = true;
              "accessibility.typeaheadfind.manual" = false;
              "browser.urlbar.suggest.recentSearches" = false;
            };
          in
          {
            home.sessionVariables.MOZ_USE_XINPUT2 = "1";
            home.sessionVariables.MOZ_X11_EGL = "1";
            home.packages = [ pkgs.geckodriver ];
            programs.firefox = {
              enable = true;
              package = pkgs.firefox;
              policies = import ./policies.nix;
              profiles.arkenfox = {
                inherit
                  bookmarks
                  search
                  # userChrome
                  # userContent
                  settings
                  ;
                id = 1;
                name = "arkenfox";
                isDefault = false;
              };
              profiles.root = {
                inherit
                  bookmarks
                  search
                  # userChrome
                  # userContent
                  settings
                  ;
                id = 0;
                name = "root";
                isDefault = true;
              };
            };
          };
      };
    };
}
