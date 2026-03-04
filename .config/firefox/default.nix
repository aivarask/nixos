{
  pkgs,
  lib,
  config,
  SELF,
  ...
}:
let
  symlink = config.lib.file.mkOutOfStoreSymlink;

in
{

  programs.firefox = {
    enable = true;

    languagePacks = [
      "en-US"
      "lt"
    ];

    # https://mozilla.github.io/policy-templates/
    policies = {
      # https://searchfox.org/firefox-main/source/modules/libpref/init/StaticPrefList.yaml
      Preferences = {
        "general.autoScroll" = true;
      };
      Permissions.Autoplay.Default = "allow-audio-video";
      # Permission = {
      #   "Autoplay" = {
      #     # "Allow" = [ "https://example.org" ];
      #     # "Block" = [ "https://example.edu" ];
      #     "Default" = "allow-audio-video";
      #     # "Locked" = false;
      #   };
      # };
      PopupBlocking = {
        "Allow" = [
          "http://example.org/"
          "http://example.edu/"
        ];
        "Default" = true;
        "Locked" = false;
      };
      # Updates & Background Services
      AppAutoUpdate = false;
      BackgroundAppUpdate = false;

      # Feature Disabling
      DisableBuiltinPDFViewer = true;
      DisableFirefoxStudies = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxScreenshots = true;
      DisableForgetButton = true;
      DisableMasterPasswordCreation = true;
      DisableProfileImport = true;
      DisableProfileRefresh = true;
      DisableSetDesktopBackground = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DisableFormHistory = true;
      DisablePasswordReveal = true;

      # Access Restrictions
      BlockAboutConfig = false;
      BlockAboutProfiles = true;
      BlockAboutSupport = false;

      # UI and Behavior
      DisplayMenuBar = "never";
      DontCheckDefaultBrowser = true;
      HardwareAcceleration = true;
      OfferToSaveLogins = false;
      DefaultDownloadDirectory = "${config.home.homeDirectory}/Downloads";
      SearchEngines = {
        Default = "DuckDuckGo";
        PreventInstalls = true;
      };

      # https://mozilla.github.io/policy-templates/#extensionsettings
      ExtensionSettings =
        let
          moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
        in
        {
          "*".installation_mode = "blocked";
          "*".default_area = "navbar";
          "*".updates_disabled = true;
          "*".private_browsing = true;
          "markdown-viewer@outofindex.com" = {
            install_url = moz "markdown-viewer-chrome";
            installation_mode = "force_installed";
          };
          "{943b8007-a895-44af-a672-4f4ea548c95f}" = {
            install_url = moz "markdown-viewer-webext";
            installation_mode = "force_installed";
          };
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = moz "bitwarden-password-manager";
            installation_mode = "force_installed";
          };
          # https://ublockorigin.com/
          "uBlock0@raymondhill.net" = {
            install_url = moz "ublock-origin";
            installation_mode = "force_installed";
            private_browsing = true;
          };
          # "{f3b4b962-34b4-4935-9eee-45b0bce58279}" = {
          #   install_url = moz "animated-purple-moon-lake";
          #   installation_mode = "force_installed";
          # };
          # https://noscript.net/
          # "{73a6fe31-595d-460b-a920-fcc0f8843232}" = {
          #   install_url = moz "noscript";
          #   installation_mode = "force_installed";
          # };
          # https://wiki.greasespot.net/
          "{e4a8a97b-f2ed-450b-b12d-ee082ba24781}" = {
            install_url = moz "greasemonkey";
            installation_mode = "force_installed";
            private_browsing = true;
            default_area = "navbar";
          };
          "queryamoid@kaply.com" = {
            # https://github.com/mkaply/queryamoid
            installation_mode = "force_installed";
            install_url = "https://github.com/mkaply/queryamoid/releases/download/v0.1/query_amo_addon_id-0.1-fx.xpi";
            default_area = "menupanel";
          };
          "{830f38bd-efc5-45dc-a5a6-064d9a638806}" = {
            # https://addons.mozilla.org/en-US/firefox/addon/dark-mode-by-albert-inc/
            installation_mode = "force_installed";
            install_url = moz "dark-mode-by-albert-inc";
            private_browsing = true;
            default_area = "navbar";
          };
          "firefox@ghostery.com" = {
            # https://addons.mozilla.org/en-US/firefox/addon/ghostery/
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/firefox@ghostery.com/latest.xpi";
            installation_mode = "blocked";
            default_area = "menupanel";
          };

          "3rdparty".Extensions = {
            "uBlock0@raymondhill.net".adminSettings = {
              userSettings = rec {
                uiTheme = "dark";
                uiAccentCustom = true;
                uiAccentCustom0 = "#8300ff";
                cloudStorageEnabled = lib.mkForce false;

                importedLists = [
                  "https:#filters.adtidy.org/extension/ublock/filters/3.txt"
                  "https:#github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
                ];

                externalLists = lib.concatStringsSep "\n" importedLists;
              };

              userFilters = "||accounts.google.com/gsi/iframe";
              selectedFilterLists = [
                "user-filters"
                "ublock-filters"
                "ublock-badware"
                "ublock-privacy"
                "ublock-quick-fixes"
                "ublock-unbreak"
                "easylist"
                "easyprivacy"
                "urlhaus-1"
                "plowe-0"
                "fanboy-cookiemonster"
                "ublock-cookies-easylist"
                "adguard-cookies"
                "ublock-cookies-adguard"
                "fanboy-social"
                "adguard-social"
                "fanboy-thirdparty_social"
                "easylist-chat"
                "easylist-newsletters"
                "easylist-notifications"
                "easylist-annoyances"
                "adguard-mobile-app-banners"
                "adguard-other-annoyances"
                "adguard-popup-overlays"
                "adguard-widgets"
                "ublock-annoyances"
                "LTU-0"
              ];
            };
          };
        };
    };

    profiles."default".search = {
      force = true;
      default = "ddg";
      privateDefault = "ddg";
      engines =
        let
          reddit = "https://www.reddit.com";
          ddg = "https://duckduckgo.com/?q="; # https://duckduckgo.com/duckduckgo-help-pages/results/syntax/
          github = "https://github.com";
        in
        {
          "bing".metaData.hidden = true;
          "google".metaData.alias = "@g";
          # "" = {
          #   definedAliases = [ "" ];
          #   urls = [
          #     { template = ""; }
          #   ];
          # };
          "@nb https://nix-builtins-search.extranix.com" = {
            definedAliases = [
              "@nb"
              "@nix-builtins"
            ];
            urls = [
              { template = "https://nix-builtins-search.extranix.com/?query={searchTerms}&release=nix-v2.24"; }
            ];
          };
          "@hm home-manager-options.extranix.com" = {
            definedAliases = [
              "@hm"
              "@home-manager"
            ];
            urls = [
              {
                template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=release-24.11";
              }
            ];
          };
          "@yt youtube.com" = {
            definedAliases = [ "@yt" ];
            urls = [ { template = "https://www.youtube.com/results?search_query={searchTerms}"; } ];
          };
          "@ad httpd.apache.org/docs/2.4" = {
            definedAliases = [
              "@ad"
              "@apache"
            ];
            urls = [ { template = "${ddg}site:httpd.apache.org/docs/2.4+{searchTerms}"; } ];
          };
          "@ah askapache.com/htaccess" = {
            definedAliases = [
              "@ah"
              "@apache"
            ];
            urls = [ { template = "${ddg}site:askapache.com/htaccess+{searchTerms}"; } ];
          };
          "@ff searchfox.org" = {
            definedAliases = [
              "@ff"
              "@sf"
            ];
            urls = [
              {
                template = "https://searchfox.org/mozilla-central/search?q={searchTerms}&path=&case=false&regexp=false";
              }
            ];
          };
          "@php php.net" = {
            definedAliases = [ "@php" ];
            urls = [ { template = "${ddg}site:php.net+{searchTerms}"; } ];
          };
          "@nur" = {
            definedAliases = [ "@nur" ];
            urls = [ { template = "${ddg}site:nur.nix-community.org+{searchTerms}"; } ];
          };
          # Reddit
          "@reddit" = {
            definedAliases = [ "@r" ];
            urls = [ { template = "${reddit}/search/?q={searchTerms}"; } ];
          };
          "@reddit zsh" = {
            definedAliases = [ "@rzsh" ];
            urls = [ { template = "${reddit}/r/zsh/search/?q={searchTerms}"; } ];
          };
          "@reddit vim" = {
            definedAliases = [ "@rvim" ];
            urls = [ { template = "${reddit}/r/vim/search/?q={searchTerms}"; } ];
          };
          "@reddit neovim" = {
            definedAliases = [ "@rneovim" ];
            urls = [ { template = "${reddit}/r/neovim/search/?q={searchTerms}"; } ];
          };
          "@reddit nixos" = {
            definedAliases = [ "@rnixos" ];
            urls = [ { template = "${reddit}/r/NixOS/search/?q={searchTerms}"; } ];
          };
          "@np search.nixos.org/packages" = {
            definedAliases = [ "@np" ];
            urls = [
              {
                template = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={searchTerms}";
              }
            ];
          };
          "@no search.nixos.org/options" = {
            definedAliases = [ "@no" ];
            urls = [
              { template = "https://search.nixos.org/options?channel=unstable&type=options&query={searchTerms}"; }
            ];
          };
          "@nm nixos.org/manual" = {
            definedAliases = [ "@nm" ];
            urls = [ { template = "https://nixos.org/manual/nix/unstable/?search={searchTerms}"; } ];
          };
          "@nw wiki.nixos.org" = {
            definedAliases = [ "@nw" ];
            urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
          };
          "@nd discourse.nixos.org" = {
            definedAliases = [ "@nd" ];
            urls = [ { template = "https://discourse.nixos.org/search?q={searchTerms}"; } ];
          };
          "@aw wiki.archlinux.org" = {
            definedAliases = [ "@aw" ];
            urls = [ { template = "https://wiki.archlinux.org/index.php?search={searchTerms}"; } ];
          };
          "@gc github code" = {
            definedAliases = [ "@gc" ];
            urls = [ { template = "${github}/search?type=code&q={searchTerms}"; } ];
          };
          "@gi github issues" = {
            definedAliases = [ "@gi" ];
            urls = [ { template = "${github}/search?type=issues&q={searchTerms}"; } ];
          };
          "@gr github repositories" = {
            definedAliases = [ "@gr" ];
            urls = [ { template = "${github}/search?type=repositories&q={searchTerms}"; } ];
          };
          "@gu github users" = {
            definedAliases = [ "@gu" ];
            urls = [ { template = "${github}/search?type=users&q={searchTerms}"; } ];
          };
          "@ex explainshell.com" = {
            definedAliases = [ "@ex" ];
            urls = [ { template = "https://explainshell.com/explain?cmd={searchTerms}"; } ];
          };
        };
    };
  };
}
