{
  pkgs,
  lib,
  config,
  SELF,
  xdgconf,
  ...
}:
{
  home.file.".mozilla/native-messaging-hosts".enable = false;
  imports = [ ./profile.nix ];
  programs.firefox.enable = true;
  programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";
  programs.firefox.languagePacks = [
    "en-US"
    "lt"
  ];
  programs.firefox.policies = {
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
    AppAutoUpdate = true;
    BackgroundAppUpdate = true;

    EnableTrackingProtection = {
      Value = true;
      Locked = true;
      Cryptomining = true;
      Fingerprinting = true;
    };
    # Feature Disabling
    DisableBuiltinPDFViewer = true;
    DisableFirefoxStudies = true;
    DisableFirefoxAccounts = true;
    DisableFirefoxScreenshots = true;
    DisableForgetButton = true;
    DisableMasterPasswordCreation = true;
    # DisableProfileImport = true;
    # DisableProfileRefresh = true;
    DisableSetDesktopBackground = true;
    DisablePocket = true;
    DisableTelemetry = true;
    DisableFormHistory = true;
    DisablePasswordReveal = true;

    # Access Restrictions
    BlockAboutConfig = false;
    BlockAboutProfiles = false;
    BlockAboutSupport = false;

    # UI and Behavior
    DontCheckDefaultBrowser = true;
    HardwareAcceleration = true;
    OfferToSaveLogins = false;
    DefaultDownloadDirectory = "${config.home.homeDirectory}/Downloads";
    SearchEngines = {
      Default = "DuckDuckGo";
      PreventInstalls = true;
    };
    DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
    DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
    SearchBar = "unified"; # alternative: "separate"
    OverrideFirstRunPage = "";
    OverridePostUpdatePage = "";

    # https://mozilla.github.io/policy-templates/#extensionsettings
    ExtensionSettings =
      let
        moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
        adminSettings = {
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
            # "easylist"
            # "easyprivacy"
            # "urlhaus-1"
            # "plowe-0"
            # "fanboy-cookiemonster"
            # "ublock-cookies-easylist"
            # "adguard-cookies"
            # "ublock-cookies-adguard"
            # "fanboy-social"
            # "adguard-social"
            # "fanboy-thirdparty_social"
            # "easylist-chat"
            # "easylist-newsletters"
            # "easylist-notifications"
            # "easylist-annoyances"
            # "adguard-mobile-app-banners"
            # "adguard-other-annoyances"
            # "adguard-popup-overlays"
            # "adguard-widgets"
            # "ublock-annoyances"
            # "LTU-0"
          ];
        };
      in
      {
        "*".installation_mode = "blocked";
        "*".default_area = "navbar";
        "*".updates_disabled = true;
        "*".private_browsing = true;
        # https://ublockorigin.com/
        "uBlock0@raymondhill.net" = {
          install_url = moz "ublock-origin";
          installation_mode = "force_installed";
          private_browsing = true;
          inherit adminSettings;
        };
        "3rdparty".Extensions = {
          "uBlock0@raymondhill.net" = {
            inherit adminSettings;
          };
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = moz "bitwarden-password-manager";
          installation_mode = "force_installed";
        };
        "markdown-viewer@outofindex.com" = {
          install_url = moz "markdown-viewer-chrome";
          installation_mode = "force_installed";
        };
        "{943b8007-a895-44af-a672-4f4ea548c95f}" = {
          install_url = moz "markdown-viewer-webext";
          installation_mode = "force_installed";
        };
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

      };
  };

}
