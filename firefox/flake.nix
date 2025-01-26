{
  inputs.nur.url = "github:nix-community/NUR";
  outputs =
    { self, ... }@inputs:
    {
      overlays.default = inputs.nur.overlays.default;

      nixosModules = {
        default = _: {
          environment.profiles = [ "${./.}" ];
        };
        main =
          { pkgs, ... }:
          {
            dconf = {
              enable = true;
              settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
            };
            nixpkgs.overlays = [ self.overlays.default ];
            home.sessionVariables = {
              MOZ_USE_XINPUT2 = "1";
            };
            home.packages = [
              pkgs.geckodriver
            ];
            programs.firefox = {
              enable = true;
              package = pkgs.firefox;
              profiles.root = {
                isDefault = true;
                bookmarks = [
                  (import ./bookmarks_about.nix)
                  (import ./bookmarks_nix.nix)
                  (import ./bookmarks_.nix)
                ];
                search = {
                  force = true;
                  default = "DuckDuckGo";
                  privateDefault = "DuckDuckGo";
                  order = [
                    "DuckDuckGo"
                    "Google"
                  ];
                  engines = import ./search_engines.nix;
                };
                userChrome = ''
                  * {
                    box-shadow: none !important;
                    border: 0px solid !important;
                    }
                '';
              };
            };
          };
        extensions =
          { pkgs, ... }:
          let
            PKGS = (pkgs.extend self.overlays.default);
          in
          {
            programs.firefox.profiles.root.extensions = with PKGS.nur.repos.rycee.firefox-addons; [
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
              h264ify
              # tab-session-manager # https://github.com/sienori/Tab-Session-Manager
              stylus
              # leechblock-ng
            ];
            programs.firefox.profiles.root.settings = {
              "extensions.autoDisableScopes" = false;
              "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
              "extensions.pocket.enabled" = false;
              "extensions.htmlaboutaddons.recommendations.enabled" = false;
              "extensions.recommendations.privacyPolicyUrl" = "";
              "extensions.systemAddon.update.enabled" = false;
              "extensions.update.enabled" = false;
              "extensions.webcompat-reporter.enabled" = false;
              "identity.fxaccounts.enabled" = false;
            };
          };
        basic = _: {
          programs.firefox.profiles.root.settings = {
            "layout.css.prefers-color-scheme.content-override" = 3;
            # "layout.css.iframe-embedder-prefers-color-scheme.content.enabled" = true;
            "reader.color_scheme" = "dark";
            "app.normandy.first_run" = false;
            "toolkit.telemetry.reportingpolicy.firstRun" = false;
            "trailhead.firstrun.didSeeAboutWelcome" = true;
            "intl.accept_languages" = "en, lt";
            "browser.aboutwelcome.enabled" = false;
            "browser.aboutConfig.showWarning" = false;
            "browser.search.suggest.enabled" = false;
            "browser.search.update" = false;
            "browser.uidensity" = 1;
            "browser.shell.checkDefaultBrowser" = false;
            "browser.toolbars.bookmarks.visibility" = "always"; # "newtab"
            "browser.startup.firstrunSkipsHomepage" = true;
            "widget.use-xdg-desktop-portal.file-picker" = 1;
            # "widget.use-xdg-desktop-portal.location" = 2;
            # "widget.use-xdg-desktop-portal.mime-handler" = 2;
            # "widget.use-xdg-desktop-portal.open-uri" = 2;
            # "widget.use-xdg-desktop-portal.settings" = 2;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          };
        };
        dns = {
          programs.firefox.profiles.root.settings = {
            "browser.fixup.fallback-to-https" = false;
            "browser.fixup.domainsuffixwhitelist.lan" = true;
            "browser.fixup.domainsuffixwhitelist.l" = true;
            "browser.fixup.domainsuffixwhitelist.containers" = true;
            "browser.fixup.domainsuffixwhitelist.c" = true;
          };
        };
        devtools = {
          programs.firefox.profiles.root.settings = {
            "devtools.dom.enabled" = true;
            "devtools.cache.disabled" = false;
            "devtools.performance.enabled" = false;
            "devtools.inspetor.showUserAgentStyles" = false;
            "devtools.debugger.remote-enabled" = true;
            "devtools.editor.keymap" = "vim";
          };
        };
        newtabpage = {
          programs.firefox.profiles.root.settings = {
            "browser.startup.homepage" = "about:blank";
            "browser.newtabpage.enabled" = false;
            "browser.newtabpage.pinned" = true;
            "browser.newtabpage.activity-stream.feeds.topsites" = false;
            "browser.newtabpage.activity-stream.feeds.telemetry" = false;
            "browser.newtabpage.activity-stream.feeds.sections" = true;
            "browser.newtabpage.activity-stream.section.highlights.rows" = 3;
            "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
            "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" = "DuckDuckGo";
            "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines" =
              "DuckDuckGo";
          };
        };
        urlbar = {
          programs.firefox.profiles.root.settings = {
            "browser.urlbar.autoFill" = true;
            "browser.urlbar.placeholderName" = "DuckDuckGo";
            "browser.urlbar.shortcuts.bookmarks" = false;
            "browser.urlbar.shortcuts.history" = false;
            "browser.urlbar.shortcuts.tabs" = false;
            "browser.urlbar.speculativeConnect.enabled" = false;
            "browser.urlbar.suggest.addons" = true;
            "browser.urlbar.suggest.bookmark" = true;
            "browser.urlbar.suggest.calculator" = false;
            "browser.urlbar.suggest.clipboard" = true;
            "browser.urlbar.suggest.engines" = true;
            "browser.urlbar.suggest.fakespot" = false;
            "browser.urlbar.suggest.history" = false;
            "browser.urlbar.suggest.mdn" = false;
            "browser.urlbar.suggest.openpage" = false;
            "browser.urlbar.suggest.pocket" = false;
            "browser.urlbar.suggest.quickactions" = false;
            "browser.urlbar.suggest.recentsearches" = false;
            "browser.urlbar.suggest.remotetab" = true;
            "browser.urlbar.suggest.searches" = false;
            "browser.urlbar.suggest.topsites" = false;
            "browser.urlbar.suggest.trending" = false;
            "browser.urlbar.suggest.weather" = false;
            "browser.urlbar.suggest.yelp" = false;
            "browser.urlbar.trimHttps" = true;
          };
        };
        telemetry = {
          programs.firefox.profiles.root.settings = {
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.unified" = false;
            "browser.ping-centre.telemetry" = false;
            "toolkit.telemetry.bhrPing.enabled" = false;
            "toolkit.telemetry.firstShutdownPing.enabled" = false;
            "toolkit.telemetry.hybridContent.enabled" = false;
            "toolkit.telemetry.newProfilePing.enabled" = false;
            "toolkit.telemetry.reportingpolicy.firstRun" = false;
            "toolkit.telemetry.shutdownPingSender.enabled" = false;
            "toolkit.telemetry.updatePing.enabled" = false;
            "toolkit.telemetry.archive.enabled" = false;
            "devtools.onboarding.telemetry.logged" = false;
            "datareporting.healthreport.uploadEnabled" = false;
            "datareporting.policy.dataSubmissionEnabled" = false;
            "datareporting.sessions.current.clean" = true;
          };
        };
        tabs = {
          programs.firefox.profiles.root.settings = {
            "browser.tabs.groups.enabled" = true;
            "browser.tabs.closeWindowWithLastTab" = false;
            "browser.tabs.loadBookmarksInBackground" = false;
            "browser.tabs.loadBookmarksInTabs" = false;
            "browser.tabs.loadDivertedInBackground" = true;
            "browser.tabs.loadInBackground" = true;
          };
        };
        privacy = {
          # https://www.reddit.com/r/privacytoolsIO/comments/ew4ejq/firefox_privacy_guide/
          programs.firefox.profiles.root.settings = {
            # "browser.privatebrowsing.autostart" = true;
            # "browser.sessionstore.privacy_level" = 2;
            # "browser.sessionstore.max_tabs_undo" = 0;
            # "browser.bookmarks.max_backups" = 0;
            # "signon.rememberSignons" = false;
            "webgl.disabled" = true;
            "beacon.enabled" = false;
            "browser.cache.disk.enable" = false;
            "browser.cache.memory.enable" = true;
            "browser.cache.offline.enable" = false;
            "browser.send_pings" = false;
            "dom.battery.enabled" = false; # battery track
            "dom.event.clipboardevents.enabled" = false; # copy/paste track
            "dom.webnotifications.enabled" = false; # pusho notifications
            "geo.enabled" = false;
            "general.useragent.override" = "Linux/Firefox";
            "media.navigator.enabled" = false;
            "media.peerconnection.enabled" = false;
            "media.peerconnection.identity.timeout" = 1;
            "media.peerconnection.turn.disable" = true;
            "media.peerconnection.use_document_iceservers" = false;
            "media.peerconnection.video.enabled" = false;
            "network.captive-portal-service.enabled" = false;
            "network.cookie.cookieBehavior" = 1;
            "network.dns.disablePrefetch" = true;
            "network.dns.disablePrefetchFromHTTPS" = false;
            "network.http.referer.XOriginPolicy" = 2;
            "network.http.referer.XOriginTrimmingPolicy" = 2;
            "network.predictor.enabled" = false;
            "network.prefetch-next" = false;
            "network.ttr.mode" = 2;
            "privacy.firstparty.isolate" = true;
            "privacy.donottrackheader.enabled" = true;
            "privacy.resistFingerprinting" = true;
            "privacy.trackingprotection.cryptomining.enabled" = true;
            "privacy.trackingprotection.enabled" = true;
            "privacy.trackingprotection.fingerprinting.enabled" = true;
            "privacy.trackingprotection.emailtracking.enabled" = true;
            "privacy.trackingprotection.socialtracking.enabled" = true;
          };
        };
        media = {
          programs.firefox.profiles.root.settings = {
            "media.autoplay.enabled" = true;
            "media.videocontrols.picture-in-picture.enabled" = true;
            "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
          };
        };
        vaapi = _: {
          # https://github.com/elFarto/nvidia-vaapi-driver
          home.sessionVariables.MOZ_X11_EGL = "1";
          programs.firefox.profiles.root.settings = {
            "media.ffmpeg.vaapi.enabled" = true;
            "media.rdd-ffmpeg.enabled" = true;
            "media.av1.enabled" = true;
            "gfx.x11-egl.force-enabled" = true;
            "widget.dmabuf.force-enabled" = true;
          };

        };
        vaapi_bc = _: {
          home.sessionVariables.MOZ_X11_EGL = "1";
          programs.firefox.profiles.root.settings = {
            # https://searchfox.org
            "app.shield.optoutstudies.enabled" = false;
            "gfx.webrender.enabled" = true;
            "gfx.webrender.all" = true;
            "browser.safebrowsing.downloads.remote.enabled" = false;
            "dom.security.https_only_mode_ever_enabled" = true;
            "media.ffmpeg.vaapi.enabled" = true;
            "media.ffvpx.enabled" = false;
            "media.rdd-vpx.enabled" = false;
            "media.rdd-ffmpeg.enabled" = true;
            "gfx.x11-egl.force-enabled" = true;
            "widget.dmabuf.force-enabled" = true;
            "media.navigator.mediadatadecoder_vpx_enabled" = true;
            "network.IDN_show_punycode" = true;
            "network.predictor.enable-prefetch" = false;
          };
        };
      };
    };
}
