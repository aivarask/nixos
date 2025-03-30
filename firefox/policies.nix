{
  # Cookies = { };
  DefaultDownloadDirectory = "/root";
  DisableAccounts = true;
  DisableFeedbackCommands = true;
  DisableFirefoxAccounts = true;
  DisableFirefoxStudies = true;
  DisablePocket = true;
  DisableTelemetry = true;
  DisplayBookmarksToolbar = "newtab";
  DisplayMenuBar = "always";
  # DNSOverHTTPS = {
  #   Enabled = true;
  #   ProviderURL = "";
  #   ExcludeDomains = [ ];
  #   Fallback = true;
  #   Locked = false;
  # };
  DontCheckDefaultBrowser = true;
  EnableTrackingProtection = {
    Value = true;
    Locked = true;
    Cryptomining = true;
    Fingerprinting = true;
    EmailTracking = true;
    Exceptions = [ ];
  };
  # https://mozilla.github.io/policy-templates/
  # about:debugging#/runtime/this-firefox
  ExtensionSettings = {
    # https://mozilla.github.io/policy-templates/#extensionsettings
    "queryamoid@kaply.com" = {
      # https://github.com/mkaply/queryamoid
      installation_mode = "force_installed";
      install_url = "https://github.com/mkaply/queryamoid/releases/download/v0.1/query_amo_addon_id-0.1-fx.xpi";
      default_area = "menupanel";
    };
    "{830f38bd-efc5-45dc-a5a6-064d9a638806}" = {
      # https://addons.mozilla.org/en-US/firefox/addon/dark-mode-by-albert-inc/
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/dark-mode-by-albert-inc/latest.xpi";
      default_area = "navbar";
      private_browsing = true;
    };
    "firefox@ghostery.com" = {
      # https://addons.mozilla.org/en-US/firefox/addon/ghostery/
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/firefox@ghostery.com/latest.xpi";
      default_area = "menupanel";
      private_browsing = true;
    };
    "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
      # https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager
      installation_mode = "force_installed";
      install_url = "http://addons.mozilla.org/firefox/downloads/latest/{446900e4-71c2-419f-a6a7-df9c091e268b}/latest.xpi";
      default_area = "navbar";
    };

    "uBlock0@raymondhill.net" = {
      # https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/
      installation_mode = "blocked";
      install_url = "http://addons.mozilla.org/firefox/downloads/latest/uBlock0@raymondhill.net/latest.xpi";
      default_area = "navbar";
    };
  };
  ExtensionUpdate = true;
  FirefoxHome = {
    Search = false;
    TopSites = false;
    SponsoredTopSites = false;
    Highlights = false;
    Pocket = false;
    SponsoredPocket = false;
    Snippets = false;
    Locked = false;
  };
  # SearchSuggestEnabled = false;
  # FirefoxSuggest = {
  #   "WebSuggestions" = false;
  #   "SponsoredSuggestions" = false;
  #   "ImproveSuggest" = false;
  #   "Locked" = true;
  # };
  GoToIntranetSiteForSingleWordEntryInAddressBar = true;
  # https://mozilla.github.io/policy-templates/#handlers
  HardwareAcceleration = true;
  # https://mozilla.github.io/policy-templates/#homepage
  Homepage = {
    # "URL" = "http://localhost";
    "Locked" = true;
    "Additional" = [
      "http://hw.local"
    ];
    "StartPage" = "previous-session";
  };
  OverrideFirstRunPage = "";
  OfferToSaveLogins = false;
  PasswordManagerEnabled = false;
  Permissions = {
    # https://mozilla.github.io/policy-templates/#permissions
    "Notifications" = {
      "BlockNewRequests" = true;
      "Locked" = true;
    };
    "Autoplay" = {
      "Default" = "allow-audio-video";
      "Locked" = true;
    };
  };
  PictureInPicture = {
    "Enabled" = false;
    "Locked" = true;
  };
  PopupBlocking = {
    "Default" = true;
    "Locked" = true;
  };
  Preferences = {
    # https://mozilla.github.io/policy-templates/#preferences
    # https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml
  };
  SanitizeOnShutdown = {
    # https://mozilla.github.io/policy-templates/#sanitizeonshutdown-selective
  };
  SearchBar = "unified";
  ShowHomeButton = true;
  TranslateEnabled = false;
  UserMessaging = {
    # https://mozilla.github.io/policy-templates/#usermessaging
  };
  # https://mozilla.github.io/policy-templates/#usesystemprintdialog
}
