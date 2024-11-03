# vim:foldlevel=4 foldnestmax=6
{ pkgs, ... }:
{
  home.packages = with pkgs; [ geckodriver ];
  programs.firefox = {
    enable = true;
    profiles.root = {
      # ~/.mozilla/firefox/root/user.js
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
      bookmarks = [
        {
          name = "about";
          toolbar = true;
          bookmarks = [
            {
              tags = [ "aa" ];
              name = "about:about";
              url = "about:about";
            }
            {
              tags = [ "ac" ];
              name = "about:config";
              url = "about:config";
            }
          ];
        }
      ];
      search = {
        force = true;
        default = "DuckDuckGo";
        privateDefault = "DuckDuckGo";
        order = [
          "DuckDuckGo"
          "Google"
        ];
        # https://mynixos.com/home-manager/option/programs.firefox.profiles.%3Cname%3E.search.engines
        engines =
          let
            updateInterval = 30 * 24 * 60 * 60 * 1000;
            reddit = "https://www.reddit.com";
            github = "https://github.com";
          in
          {
            "Bing".metaData.hidden = true;
            "Google".metaData.alias = "@g";
            # Reddit
            "Reddit @r" = {
              definedAliases = [ "@r" ];
              urls = [ { template = "${reddit}/search/?q={searchTerms}"; } ];
              iconUpdateURL = "https://redditinc.com/hubfs/Reddit%20Inc/Brand/Reddit_Logo.png";
              inherit updateInterval;
            };
            "@rzsh" = {
              definedAliases = [ "@rzsh" ];
              urls = [ { template = "${reddit}/r/zsh/search/?q={searchTerms}"; } ];
              iconUpdateURL = "https://zsh.org/color_vertical_icon.png";
              inherit updateInterval;
            };
            "@rvim" = {
              definedAliases = [ "@rvim" ];
              urls = [ { template = "${reddit}/r/vim/search/?q={searchTerms}"; } ];
              iconUpdateURL = "https://styles.redditmedia.com/t5_2qhqx/styles/communityIcon_9lpgb9pf6xh01.png";
              inherit updateInterval;
            };
            "@rneovim" = {
              definedAliases = [ "@rneovim" ];
              urls = [ { template = "${reddit}/r/neovim/search/?q={searchTerms}"; } ];
              iconUpdateURL = "https://styles.redditmedia.com/t5_30kix/styles/communityIcon_n2hvyn96zwk81.png";
              inherit updateInterval;
            };
            "@rNixOS" = {
              definedAliases = [ "@rnixos" ];
              urls = [ { template = "${reddit}/r/NixOS/search/?q={searchTerms}"; } ];
              iconUpdateURL = "https://styles.redditmedia.com/t5_2ssc0/styles/communityIcon_8yz6min83bg41.png";
              inherit updateInterval;
            };

            "@dnixos Discourse" = {
              definedAliases = [ "@dnixos" ];
              urls = [ { template = "https://discourse.nixos.org/search?q={searchTerms}"; } ];
              iconUpdateURL = "https://discourse.nixos.org/uploads/default/optimized/1X/401be373869e12dfe689b9d7eb347f78b1a105f0_2_32x32.png";
              inherit updateInterval;
            };

            "@dneovim Discourse" = {
              definedAliases = [ "@dneovim" ];
              urls = [ { template = "https://neovim.discourse.group/search?q={searchTerms}"; } ];
              iconUpdateURL = "https://canada1.discourse-cdn.com/free1/uploads/neovim/original/1X/48ee1361c952b59562a67d0c5d19d403f8f2ee12.png";
              inherit updateInterval;
            };
            "@mn MyNixOS" = {
              definedAliases = [ "@mn" ];
              urls = [ { template = "https://mynixos.com/search?q={searchTerms}"; } ];
              iconUpdateURL = "https://mynixos.com/favicon.ico";
              inherit updateInterval;
            };
            "@nw NixOS Wiki" = {
              definedAliases = [ "@nw" ];
              urls = [ { template = "https://nixos.wiki/index.php?search={searchTerms}"; } ];
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              inherit updateInterval;
            };
            #
            # "ArchWiki @aw" = {
            #   definedAliases = [ "@aw" ];
            #   iconUpdateURL = "https://wiki.archlinux.org/favicon.ico";
            #   urls = [ { template = "https://wiki.archlinux.org/index.php?search={searchTerms}"; } ];
            # };

            # "GitHub Code @gc" = {
            #   definedAliases = [ "@gc" ];
            #   urls = [ { template = "${github}/search?type=code&q={searchTerms}"; } ];
            #   iconUpdateURL = "https://github.githubassets.com/favicons/favicon.svg";
            # };
            # "GitHub Issues @gi" = {
            #   definedAliases = [ "@gi" ];
            #   urls = [ { template = "${github}/search?type=issues&q={searchTerms}"; } ];
            #   iconUpdateURL = "https://github.githubassets.com/favicons/favicon.svg";
            # };
            # "GitHub Repositories @gr" = {
            #   definedAliases = [ "@gr" ];
            #   urls = [ { template = "${github}/search?type=repositories&q={searchTerms}"; } ];
            #   iconUpdateURL = "https://github.githubassets.com/favicons/favicon.svg";
            # };
            # "GitHub Users @gu" = {
            #   definedAliases = [ "@gu" ];
            #   iconUpdateURL = "https://github.githubassets.com/favicons/favicon.svg";
            #   urls = [ { template = "${github}/search?type=users&q={searchTerms}"; } ];
            # };

            # "npm @npm" = {
            #   definedAliases = [ "@npm" ];
            #   iconUpdateURL = "https://static.npmjs.com/b0f1a8318363185cc2ea6a40ac23eeb2.png";
            #   urls = [ { template = "https://www.npmjs.com/search?q={searchTerms}"; } ];
            # };

            # "Nix Manual @nm" = {
            #   definedAliases = [ "@nm" ];
            #   iconUpdateURL = "https://nixos.org/manual/nix/unstable/favicon.svg";
            #   urls = [ { template = "https://nixos.org/manual/nix/unstable/?search={searchTerms}"; } ];
            # };

            # "NixOS Packages @np" = {
            #   definedAliases = [ "@np" ];
            #   icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            #   urls = [
            #     {
            #       template = "https://search.nixos.org/packages";
            #       params = [
            #         {
            #           name = "channel";
            #           value = "unstable";
            #         }
            #         {
            #           name = "type";
            #           value = "packages";
            #         }
            #         {
            #           name = "query";
            #           value = "{searchTerms}";
            #         }
            #       ];
            #     }
            #   ];
            # };

            # "NixOS Options @no" = {
            #   definedAliases = [ "@no" ];
            #   icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            #   urls = [
            #     {
            #       template = "https://search.nixos.org/options";
            #       params = [
            #         {
            #           name = "channel";
            #           value = "unstable";
            #         }
            #         {
            #           name = "type";
            #           value = "options";
            #         }
            #         {
            #           name = "query";
            #           value = "{searchTerms}";
            #         }
            #       ];
            #     }
            #   ];
            # };

          };
      };
      settings = {
        # "network.stricttransportsecurity.preloadlist" = true; # not recommended
        # "mousewheel.with_shift.action" = 0;
        # "mousewheel.with_shift.action.override_x" = 1;
        # ~/.mozilla/firefox/root/prefs.js
        "app.shield.optoutstudies.enabled" = false;
        "beacon.enabled" = false; # https://developer.mozilla.org/en-US/docs/Web/API/Beacon_API
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
          "tabs.loadInBackground" = false;
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
            "showUserAgentStyles" = true;
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
}
