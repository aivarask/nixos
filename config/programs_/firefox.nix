# vim: foldlevel=6 foldnestmax=6 nowrap nofoldenable
{ pkgs, ... }:
{
  home.sessionVariables = {
    # environment.variables.LIBVA_DRIVER_NAME = "nvidia";
    # environment.variables.VDPAU_DRIVER = "nvidia";
    # environment.variables.VAAPI_DEVICE = "/dev/dri/by-path/pci-0000:01:00.0-render";
    # environment.variables.MOZ_DISABLE_RDD_SANDBOX = 1;
    # environment.variables.NVD_BACKEND = "direct";
    # https://unix.stackexchange.com/a/596888
    # https://wiki.archlinux.org/title/HiDPI#GDK_3_(GTK_3)
    MOZ_X11_EGL = "1";
    MOZ_USE_XINPUT2 = "1";
    GDK_DPI_SCALE = "0.75"; # firefox
  };
  home.packages = with pkgs; [
    geckodriver
  ];
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    # package = pkgs.firefox-devedition;
    profiles.root = {
      isDefault = true;
      bookmarks = [
        {
          name = "r:pc";
          toolbar = true;
          bookmarks = [
            {
              name = "r:pc";
              tags = [ "remote-touchpad:pc" ];
              url = "http://pcw.local:9000/#pc";
            }
          ];
        }
        {
          name = "about";
          toolbar = true;
          bookmarks = [
            {
              tags = [ "a:a" ];
              name = "a:a";
              url = "about:about";
            }
            {
              tags = [ "a:c" ];
              name = "a:config";
              url = "about:config";
            }
            {
              tags = [ "a:p" ];
              name = "a:policies";
              url = "about:policies#documentation";
            }
            {
              tags = [ "a:s" ];
              name = "a:support";
              url = "about:support";
            }
          ];
        }
      ];
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        # https://nur.nix-community.org/repos/rycee
        privacy-badger
        facebook-container # https://addons.mozilla.org/en-US/firefox/addon/facebook-container/
        clearurls
        ublock-origin
        foxytab # https://addons.mozilla.org/en-US/firefox/addon/foxytab/
        # sponsorblock
        # vimium
        # df-youtube
        # decentraleyes
        # h264ify
        # browserpass
        # tab-session-manager # https://github.com/sienori/Tab-Session-Manager
        # stylus
        # leechblock-ng
      ];
      settings = {
        # https://searchfox.org
        # "network.stricttransportsecurity.preloadlist" = true; # not recommended
        # "mousewheel.with_shift.action" = 0;
        # "mousewheel.with_shift.action.override_x" = 1;
        # "general.useragent.override" = "";
        "dom.webnotifications.enabled" = false;
        "intl.accept_languages" = "en-US, en, lt";
        "app.shield.optoutstudies.enabled" = false;
        "beacon.enabled" = false;
        "gfx.webrender.enabled" = true;
        "gfx.webrender.all" = true;
        "identity.fxaccounts.enabled" = false;
        "browser.aboutwelcome.enabled" = false;
        "browser.aboutConfig.showWarning" = false;
        "browser.fixup.fallback-to-https" = false;
        "browser.startup.firstrunSkipsHomepage" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = true;
        "browser.newtabpage.activity-stream.feeds.topsites" = true;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" = "DuckDuckGo";
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines" =
          "DuckDuckGo";
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.pinned" = true;
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "browser.search.suggest.enabled" = false;
        "browser.send_pings" = false;
        "browser.tabs.closeWindowWithLastTab" = false;
        "browser.tabs.loadDivertedInBackground" = true;
        "browser.tabs.loadInBackground" = true;
        "browser.toolbars.bookmarks.visibility" = "newtab";
        "browser.uidensity" = 1;
        "browser.urlbar.autoFill" = false;
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "browser.urlbar.shortcuts.bookmarks" = false;
        "browser.urlbar.shortcuts.history" = false;
        "browser.urlbar.shortcuts.tabs" = false;
        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.urlbar.suggest.bookmark" = true;
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.history" = true;
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.suggest.topsites" = false;
        "browser.urlbar.trimHttps" = true;
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "extensions.autoDisableScopes" = false;
        "extensions.pocket.enabled" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "extensions.recommendations.privacyPolicyUrl" = ""; # "https://www.mozilla.org/privacy/firefox/?utm_source=firefox-browser&utm_medium=firefox-browser&utm_content=privacy-policy-link#addons";
        "devtools.dom.enabled" = true;
        "devtools.cache.disabled" = false;
        "devtools.performance.enabled" = false;
        "devtools.inspetor.showUserAgentStyles" = false;
        "devtools.debugger.remote-enabled" = true;
        "devtools.editor.keymap" = "vim";
        "dom.event.clipboardevents.enabled" = false;
        "dom.security.https_only_mode_ever_enabled" = true;
        "media.autoplay.enabled" = false;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.ffvpx.enabled" = false;
        "media.navigator.enabled" = false;
        "media.peerconnection.enabled" = false;
        "media.peerconnection.identity.timeout" = 1;
        "media.peerconnection.turn.disable" = true;
        "media.peerconnection.use_document_iceservers" = false;
        "media.peerconnection.video.enabled" = false;
        "media.videocontrols.picture-in-picture.enabled" = true;
        "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
        "network.prefetch-next" = false;
        "network.IDN_show_punycode" = true;
        "network.cookie.cookieBehavior" = 1;
        "network.dns.disablePrefetch" = true;
        "network.dns.disablePrefetchFromHTTPS" = true;
        "network.http.referer.XOriginPolicy" = 2;
        "network.http.referer.XOriginTrimmingPolicy" = 2;
        "network.predictor.enable-prefetch" = false;
        "network.predictor.enabled" = false;
        "privacy.firstparty.isolate" = true;
        "privacy.resistFingerprinting" = true;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.trackingprotection.enable" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "toolkit.zoomManager.zoomValues" = ".8,.95,1,1.1,1.2,1.3";
      };
      userChrome = ''
        * {
          box-shadow: none !important;
          border: 0px solid !important;
          }
      '';
    };
  };

  programs.firefox.profiles.root.search = {
    force = true;
    default = "DuckDuckGo";
    privateDefault = "DuckDuckGo";
    order = [
      "DuckDuckGo"
      "Google"
    ];
    engines =
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
        "@reddit lua" = {
          definedAliases = [ "@rlua" ];
          urls = [ { template = "${reddit}/r/lua/search/?q={searchTerms}"; } ];
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
