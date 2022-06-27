{ config, pkgs, lib, ... }:
{
  programs.firefox =
    {
      enable = true;
      extensions =
        with pkgs.nur.repos.rycee.firefox-addons; [
          # https://nur.nix-community.org/repos/rycee
          darkreader
          df-youtube
          ublock-origin
          # https-everywhere
          privacy-badger
          decentraleyes
          clearurls
          sponsorblock
          h264ify
          browserpass
          vimium
          metamask
        ];

      profiles.root = {
        settings = {
          # "network.stricttransportsecurity.preloadlist" = true; # not recommended
          # "browser.fixup.fallback-to-https" = true;
          # ---
          "app.shield.optoutstudies.enabled" = false;
          "beacon.enabled" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines" = "DuckDuckGo";
          "browser.safebrowsing.downloads.remote.enabled" = false;
          "browser.search.suggest.enabled" = false;
          "browser.send_pings" = false;
          "browser.toolbars.bookmarks.visibility" = "never";
          "browser.uidensity" = 1;
          "browser.urlbar.placeholderName" = "DuckDuckGo";
          "browser.urlbar.shortcuts.bookmarks" = false;
          "browser.urlbar.shortcuts.history" = false;
          "browser.urlbar.shortcuts.tabs" = false;
          "browser.urlbar.speculativeConnect.enabled" = false;
          "browser.urlbar.suggest.bookmark" = false;
          "browser.urlbar.suggest.engines" = false;
          "browser.urlbar.suggest.history" = true;
          "browser.urlbar.suggest.openpage" = false;
          "browser.urlbar.suggest.topsites" = false;
          "dom.event.clipboardevents.enabled" = false;
          "dom.security.https_only_mode_ever_enabled" = true;
          "extensions.activeThemeID" = "firefox-compact-light@mozilla.org";
          "extensions.autoDisableScopes" = false;
          "extensions.pocket.enabled" = false;
          "identity.fxaccounts.enabled" = false;
          "media.autoplay.enabled" = false;
          "media.navigator.enabled" = false;
          "media.peerconnection.enabled" = false;
          "media.peerconnection.identity.timeout" = 1;
          "media.peerconnection.turn.disable" = true;
          "media.peerconnection.use_document_iceservers" = false;
          "media.peerconnection.video.enabled" = false;
          "network.IDN_show_punycode" = true;
          "network.cookie.cookieBehavior" = 1;
          "network.dns.disablePrefetch" = true;
          "network.dns.disablePrefetchFromHTTPS" = true;
          "network.http.referer.XOriginPolicy" = 2;
          "network.http.referer.XOriginTrimmingPolicy" = 2;
          "network.predictor.enable-prefetch" = false;
          "network.predictor.enabled" = false;
          "network.prefetch-next" = false;
          "privacy.firstparty.isolate" = true;
          "privacy.resistFingerprinting" = true;
          "privacy.trackingprotection.cryptomining.enabled" = true;
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.fingerprinting.enabled" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "toolkit.zoomManager.zoomValues" = ".8,.95,1,1.1,1.2";
        };
        userChrome = ''
          * { 
          box-shadow: none !important;
          border: 0px solid !important;
          }
        '';
      };
    };
}
