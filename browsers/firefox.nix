{
  pkgs,
  lib,
  config,
  ...
}:
{

  programs.firefox = {
    enable = true;

    languagePacks = [
      "en-US"
      "lt"
    ];

    policies = {
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
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = moz "bitwarden-password-manager";
            installation_mode = "force_installed";
          };
          # https://ublockorigin.com/
          "uBlock0@raymondhill.net" = {
            install_url = moz "ublock-origin";
            installation_mode = "force_installed";
          };
          "{f3b4b962-34b4-4935-9eee-45b0bce58279}" = {
            install_url = moz "animated-purple-moon-lake";
            installation_mode = "force_installed";
          };
          # https://noscript.net/
          # "{73a6fe31-595d-460b-a920-fcc0f8843232}" = {
          #   install_url = moz "noscript";
          #   installation_mode = "force_installed";
          # };
          # https://wiki.greasespot.net/
          "{e4a8a97b-f2ed-450b-b12d-ee082ba24781}" = {
            install_url = moz "greasemonkey";
            installation_mode = "force_installed";
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

              selectedFilterLists = [
                "CZE-0"
                "adguard-generic"
                "adguard-annoyance"
                "adguard-social"
                "adguard-spyware-url"
                "easylist"
                "easyprivacy"
                "https:#github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
                "plowe-0"
                "ublock-abuse"
                "ublock-badware"
                "ublock-filters"
                "ublock-privacy"
                "ublock-quick-fixes"
                "ublock-unbreak"
                "urlhaus-1"
              ];
            };
          };
        };
    };

    profiles.default.search = {
      force = true;
      default = "ddg";
      privateDefault = "ddg";
      engines = import ./engines.nix;

    };
  };
}
