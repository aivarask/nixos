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
                (import ./bookmarks_firefox.nix)
                (import ./bookmarks_google.nix)
                (import ./bookmarks_nixos.nix)
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
              "accessibility.warn_on_browsewithcaret" = false; # F7
              "accessibility.typeaheadfind" = true;
              "accessibility.typeaheadfind.manual" = false;
              "toolkit.tabbox.switchByScrolling" = true;
              "browser.tabs.insertAfterCurrent" = true;
              # Enable DRM
              "media.eme.enabled" = true;
              # "media.gmp-widevinecdm.visible" = true;
              # "media.gmp-widevinecdm.enabled" = true;

              # Disable location bar making speculative connections
              "browser.urlbar.speculativeConnect.enabled" = false;
              # Disable location bar contextual suggestions
              "browser.urlbar.quicksuggest.enabled" = false;
              "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
              "browser.urlbar.suggest.quicksuggest.sponsored" = false;
              # Disable live search suggestions
              "browser.search.suggest.enabled" = false;
              "browser.urlbar.suggest.searches" = false;
              # Disable urlbar trending search suggestions
              "browser.urlbar.trending.featureGate" = false;
              # Disable urlbar suggestions
              "browser.urlbar.addons.featureGate" = false;
              "browser.urlbar.mdn.featureGate" = false;

              "browser.urlbar.suggest.topsites" = false;
              "browser.urlbar.suggest.history" = false;
              "browser.urlbar.suggest.bookmark" = true;
              "browser.urlbar.suggest.openpage" = false;
              "browser.urlbar.suggest.engines" = false;

              "browser.urlbar.suggest.addons" = false;
              "browser.urlbar.suggest.quickactions" = false;
              "browser.urlbar.suggest.recentsearches" = false;
              "browser.urlbar.maxRichResults" = 10;

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
                isDefault = true;
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
                isDefault = false;
              };
            };
          };
      };
    };
}
