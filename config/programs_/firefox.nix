# vim:foldlevel=4 foldnestmax=6 nowrap
# https://searchfox.org
# ~/.mozilla/firefox/root/user.js
# ~/.mozilla/firefox/root/prefs.js
{ pkgs, ... }:
{
  home.packages = with pkgs; [ geckodriver ];
  programs.firefox = {
    enable = true;
    profiles.root = {
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        # https://nur.nix-community.org/repos/rycee
        # https-everywhere
        # moz-extension://6ba3b5f2-39a3-4b91-8d24-199a65e1e907/pages/options.html
        vimium # ./firefox.vimium.json
        darkreader
        df-youtube
        ublock-origin
        privacy-badger
        decentraleyes
        clearurls
        sponsorblock
        h264ify
        browserpass
        foxytab # https://addons.mozilla.org/en-US/firefox/addon/foxytab/
      ];
      settings = {
        # "network.stricttransportsecurity.preloadlist" = true; # not recommended
        # "mousewheel.with_shift.action" = 0;
        # "mousewheel.with_shift.action.override_x" = 1;
        "app.shield.optoutstudies.enabled" = false;
        "beacon.enabled" = false; # https://developer.mozilla.org/en-US/docs/Web/API/Beacon_API
        general.useragent.override = "";
        "gfx.webrender.all" = true;
        "gfx.webrender.enabled" = true;
        "identity.fxaccounts.enabled" = false;
        browser = {
          "download.lastDir" = "~";
          "fixup.fallback-to-https" = false;
          "newtabpage.activity-stream.feeds.section.topstories" = true;
          "newtabpage.activity-stream.feeds.topsites" = true;
          "newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" = "DuckDuckGo";
          "newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines" = "DuckDuckGo";
          "newtabpage.activity-stream.section.highlights.includePocket" = false;
          "newtabpage.activity-stream.showSponsoredTopSites" = false;
          "newtabpage.pinned" = true;
          "safebrowsing.downloads.remote.enabled" = false;
          "search.suggest.enabled" = false;
          "send_pings" = false;
          "tabs.closeWindowWithLastTab" = false;
          "tabs.loadDivertedInBackground" = true;
          "tabs.loadInBackground" = true;
          "toolbars.bookmarks.visibility" = "never";
          "uidensity" = 1;
          "urlbar.placeholderName" = "DuckDuckGo";
          "urlbar.shortcuts.bookmarks" = false;
          "urlbar.shortcuts.history" = false;
          "urlbar.shortcuts.tabs" = false;
          "urlbar.speculativeConnect.enabled" = false;
          "urlbar.suggest.bookmark" = true;
          "urlbar.suggest.engines" = false;
          "urlbar.suggest.history" = true;
          "urlbar.suggest.openpage" = false;
          "urlbar.suggest.topsites" = false;
          "urlbar.trimHttps" = true;
        };
        devtools = {
          "dom.enabled" = true;
          "cache.disabled" = false;
          performance = {
            enabled = false;
          };
          inspector = {
            "showUserAgentStyles" = false;
          };
          "debugger" = {
            remote-enabled = true;
          };
          editor = {
            keymap = "vim";
          };
          "responsive" = {
            "html.displayedDeviceList" = {
              added = [
                "iPhone 6/7/8"
                "1080p Full HD Television (Custom)"
                "Some custom "
              ];
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
          };
        };
        dom = {
          "event.clipboardevents.enabled" = false;
          "security.https_only_mode_ever_enabled" = true;
        };
        extensions = {
          "activeThemeID" = "firefox-compact-dark@mozilla.org";
          "autoDisableScopes" = false;
          "pocket.enabled" = false;
        };
        media = {
          "autoplay.enabled" = false;
          "ffmpeg.vaapi.enabled" = true;
          "ffvpx.enabled" = false;
          "navigator.enabled" = false;
          "peerconnection.enabled" = false;
          "peerconnection.identity.timeout" = 1;
          "peerconnection.turn.disable" = true;
          "peerconnection.use_document_iceservers" = false;
          "peerconnection.video.enabled" = false;
        };
        network = {
          "prefetch-next" = false;
          "IDN_show_punycode" = true;
          "cookie.cookieBehavior" = 1;
          "dns.disablePrefetch" = true;
          "dns.disablePrefetchFromHTTPS" = true;
          "http.referer.XOriginPolicy" = 2;
          "http.referer.XOriginTrimmingPolicy" = 2;
          "predictor.enable-prefetch" = false;
          "predictor.enabled" = false;
        };
        privacy = {
          "firstparty.isolate" = true;
          "resistFingerprinting" = true;
          "trackingprotection.cryptomining.enabled" = true;
          "trackingprotection.enable" = true;
          "trackingprotection.fingerprinting.enabled" = true;
        };
        toolkit = {
          "legacyUserProfileCustomizations.stylesheets" = true;
          "zoomManager.zoomValues" = ".8,.95,1,1.1,1.2,1.3";
        };
      };
      userChrome = ''
        * {
          box-shadow: none !important;
          border: 0px solid !important;
          }
      '';
    };
  };
  programs.firefox.profiles.root.bookmarks = [
    {
      name = "about";
      toolbar = true;
      bookmarks = [
        {
          tags = [ "a:a" ];
          name = "about:about";
          url = "about:about";
        }
      ];
    }
  ];
  programs.firefox.profiles.root.search = {
    force = true;
    default = "DuckDuckGo";
    privateDefault = "DuckDuckGo";
    order = [
      "DuckDuckGo"
      "Google"
    ];
    engines =
      # https://mynixos.com/home-manager/option/programs.firefox.profiles.%3Cname%3E.search.engines
      let
        reddit = "https://www.reddit.com";
        duck = "https://duckduckgo.com/?q="; # https://duckduckgo.com/duckduckgo-help-pages/results/syntax/
        github = "https://github.com";
      in
      {
        "Bing".metaData.hidden = true;
        "Google".metaData.alias = "@g";
        "@ad httpd.apache.org/docs/2.4" = {
          definedAliases = [ "@ad" ];
          urls = [ { template = "${duck}site:httpd.apache.org/docs/2.4+{searchTerms}"; } ];
        };
        "@ah askapache.com/htaccess" = {
          definedAliases = [ "@ah" ];
          urls = [ { template = "${duck}site:askapache.com/htaccess+{searchTerms}"; } ];
        };
        "@php php.net" = {
          definedAliases = [ "@php" ];
          urls = [ { template = "${duck}site:php.net+{searchTerms}"; } ];
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
        "@reddit suckless" = {
          definedAliases = [ "@rsuckless" ];
          urls = [ { template = "${reddit}/r/suckless/search/?q={searchTerms}"; } ];
        };
        "@reddit nixos" = {
          definedAliases = [ "@rnixos" ];
          urls = [ { template = "${reddit}/r/NixOS/search/?q={searchTerms}"; } ];
        };
        "@np nixos packages" = {
          definedAliases = [ "@np" ];
          urls = [
            {
              template = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={searchTerms}";
            }
          ];
        };
        "@no nixos options" = {
          definedAliases = [ "@no" ];
          urls = [
            { template = "https://search.nixos.org/options?channel=unstable&type=options&query={searchTerms}"; }
          ];
        };
        "@nm nixos.org/manual" = {
          definedAliases = [ "@nm" ];
          urls = [ { template = "https://nixos.org/manual/nix/unstable/?search={searchTerms}"; } ];
        };
        "@nw nixos wiki oficial" = {
          definedAliases = [ "@nw" ];
          urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
        };
        "@nd nixos discourse" = {
          definedAliases = [ "@nd" ];
          urls = [ { template = "https://discourse.nixos.org/search?q={searchTerms}"; } ];
        };
        "@nwo nixos wiki legacy" = {
          definedAliases = [ "@nwo" ];
          urls = [ { template = "https://nixos.wiki/index.php?search={searchTerms}"; } ];
        };
        "@mn mynixos.com" = {
          definedAliases = [ "@mn" ];
          urls = [ { template = "https://mynixos.com/search?q={searchTerms}"; } ];
        };
        "@aw archwiki" = {
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
        "@npm npmjs.com" = {
          definedAliases = [ "@npm" ];
          urls = [ { template = "https://www.npmjs.com/search?q={searchTerms}"; } ];
        };

      };
  };
}
