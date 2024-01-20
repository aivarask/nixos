{ pkgs, ... }: {

  imports = [ ./ff_search.nix ];
  programs.firefox = {
    # nativeMessagingHosts = { };
    enable = true;

    # moz-extension://cd54c47b-5f75-4660-a7fb-767b63a96a36/home.html#initialize/seed-phrase
    # lobster harbor kingdom combine filter base suggest badge wood measure pelican future

    profiles.root = {
      # https://mynixos.com/home-manager/options/programs.firefox.profiles.%3Cname%3E


      bookmarks = [
        { name = "pcl.local:9000"; url = "http://pcl.local:9000/#pc"; }
        { name = "pcw.local:9000"; url = "http://pcw.local:9000/#pc"; }
        # Manuals
        {
          name = "Nix Manual";
          url = "https://nixos.org/manual/nix/unstable/";
          tags = [ "nix" "man" ];
        }
        {
          name = "Nixpkgs Manual";
          tags = [ "nix" "man" ];
          url = "https://nixos.org/manual/nixpkgs/unstable";
        }
        {
          name = "NixOS Manual";
          tags = [ "nix" "man" ];
          url = "https://nixos.org/manual/nixos/unstable/";
        }
        # Sites
        {
          name = "Nix sites";
          bookmarks = [
            { name = "NixOS Home"; url = "https://nixos.org"; }
            { name = "NixOS Wiki"; url = "https://nixos.wiki"; }
          ];
        }
        { name = "Sofascore Euroleague"; url = "https://www.sofascore.com/tournament/basketball/international/euroleague/138"; }
      ];

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
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
      ];

      # https://discourse.nixos.org/t/hardware-acceleration-on-firefox/7947/18
      # https://firefox-source-docs.mozilla.org/devtools-user/keyboard_shortcuts/index.html
      # https://firefox-source-docs.mozilla.org/devtools-user/keyboard_shortcuts/index.html#source-editor
      # ~/.mozilla/firefox/root/prefs.js
      settings = {
        "app.shield.optoutstudies.enabled" = false;
        "beacon.enabled" = false; # https://developer.mozilla.org/en-US/docs/Web/API/Beacon_API
        "browser.download.lastDir" = "~/Downloads";
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = true;
        "browser.newtabpage.activity-stream.feeds.topsites" = true;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" = "DuckDuckGo";
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines" = "DuckDuckGo";
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.pinned" = true;
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "browser.search.suggest.enabled" = false;
        "browser.send_pings" = false;
        "browser.tabs.closeWindowWithLastTab" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.uidensity" = 1;
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "browser.urlbar.shortcuts.bookmarks" = true;
        "browser.urlbar.shortcuts.history" = false;
        "browser.urlbar.shortcuts.tabs" = false;
        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.urlbar.suggest.bookmark" = true;
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.history" = true;
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.suggest.topsites" = false;
        "devtools.cache.disabled" = false;
        "devtools.editor.keymap" = "vim";
        "devtools.responsive.html.displayedDeviceList" = {
          added = [ "iPhone 6/7/8" "1080p Full HD Television (Custom)" "Fixasparts" ];
          removed = [
            "Galaxy Note 20"
            "Galaxy Note 20 Ultra"
            "Galaxy S10/S10+"
            "Galaxy S20"
            "Galaxy S20 Ultra"
            "Galaxy S20+"
            "iPhone 11 Pro"
            "iPhone 11 Pro Max"
            "iPhone 12/13 + Pro"
            "iPhone 12/13 mini"
            "iPhone 12/13 Pro Max"
            "iPhone SE 2nd gen"
            "iPad"
            "Kindle Fire HDX"
          ];
        };

        # ~/.mozilla/firefox/root/user.js

        "dom.event.clipboardevents.enabled" = false;
        "dom.security.https_only_mode_ever_enabled" = true;
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "extensions.autoDisableScopes" = false;
        "extensions.pocket.enabled" = false;
        "gfx.webrender.all" = true;
        "gfx.webrender.enabled" = true;
        "identity.fxaccounts.enabled" = false;
        "media.autoplay.enabled" = false;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.ffvpx.enabled" = false;
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
        # "browser.fixup.fallback-to-https" = true;
        # "network.stricttransportsecurity.preloadlist" = true; # not recommended
        # "mousewheel.with_shift.action" = 0;
        # "mousewheel.with_shift.action.override_x" = 1;
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
