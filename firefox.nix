{ pkgs, ... }: {
  programs.firefox = {
    # nativeMessagingHosts = { };
    enable = true;

    profiles.root = {
      # https://mynixos.com/home-manager/options/programs.firefox.profiles.%3Cname%3E
      search = {
        force = true;
        default = "DuckDuckGo";
        order = [ "DuckDuckGo" "Google" ];
        engines = {
          "Bing".metaData.hidden = true;
          "Google".metaData.alias = "@g";

          "GitHub" = {
            urls = [
              {
                template = "https://github.com/search?q={searchTerms}";
              }
            ];
            definedAliases = [ "@gh" ];
            iconUpdateURL = "https://github.githubassets.com/favicons/favicon.svg";
          };

          "npmjs" = {
            urls = [
              {
                template = "https://www.npmjs.com/search?q={searchTerms}";
              }
            ];
            definedAliases = [ "@npm" ];
            iconUpdateURL = "https://static.npmjs.com/b0f1a8318363185cc2ea6a40ac23eeb2.png";
          };

          "NixOS Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          "NixOS Options" = {
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "type";
                    value = "options";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@no" ];
          };

          "NixOS Wiki" = {
            urls = [
              {
                template = "https://nixos.wiki/index.php?search={searchTerms}";
              }
            ];
            iconUpdateURL = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@nw" ];
          };

          "MyNixOS" = {
            urls = [{ template = "https://mynixos.com/search?q={searchTerms}"; }];
            iconUpdateURL = "https://mynixos.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@mn" ];
          };

          "NixOS Discourse" = {
            urls = [
              {
                template = "https://discourse.nixos.org/search?q={searchTerms}";
              }
            ];
            iconUpdateURL = "https://discourse.nixos.org/uploads/default/optimized/1X/401be373869e12dfe689b9d7eb347f78b1a105f0_2_32x32.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@nd" ];
          };
        };
      };

      bookmarks = [
        {
          name = "Sofascore Euroleague";
          url = "https://www.sofascore.com/tournament/basketball/international/euroleague/138";
        }
        {
          name = "wikipedia";
          keyword = "wiki";
          url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&amp;go=Go";
        }
        {
          name = "kernel.org";
          url = "https://www.kernel.org";
        }
        {
          name = "Nix sites";
          bookmarks = [
            {
              name = "homepage";
              url = "https://nixos.org/";
            }
            {
              name = "wiki";
              url = "https://nixos.wiki/";
            }
          ];
        }
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
        metamask
      ];

      # https://discourse.nixos.org/t/hardware-acceleration-on-firefox/7947/18
      # https://firefox-source-docs.mozilla.org/devtools-user/keyboard_shortcuts/index.html
      # https://firefox-source-docs.mozilla.org/devtools-user/keyboard_shortcuts/index.html#source-editor
      # ~/.mozilla/firefox/root/prefs.js
      settings = {
        "app.shield.optoutstudies.enabled" = false;
        "beacon.enabled" =
          false; # https://developer.mozilla.org/en-US/docs/Web/API/Beacon_API
        "browser.download.lastDir" = "~/Downloads";
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" = "DuckDuckGo";
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines" = "DuckDuckGo";
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "browser.search.suggest.enabled" = false;
        "browser.send_pings" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.uidensity" = 1;
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "browser.urlbar.shortcuts.bookmarks" = true;
        "browser.urlbar.shortcuts.history" = false;
        "browser.urlbar.shortcuts.tabs" = false;
        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.urlbar.suggest.bookmark" = false;
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.history" = true;
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.suggest.topsites" = false;
        "devtools.cache.disabled" = true;
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
        "extensions.activeThemeID" = "firefox-compact-light@mozilla.org";
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
