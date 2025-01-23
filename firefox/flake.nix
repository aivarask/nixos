# vim: foldlevel=6 foldnestmax=6 nowrap nofoldenable
{
  inputs.nur.url = "github:nix-community/NUR";
  # inputs.nur.inputs.nixpkgs.follows = "nixpkgs";
  outputs =
    { self, ... }@inputs:
    {
      overlays.default = inputs.nur.overlays.default;
      nixosModules.default = _: {
        environment.profiles = [ "${./.}" ];
      };
      nixosModules.home =
        { pkgs, ... }:
        let
          PKGS = (pkgs.extend self.overlays.default);
        in
        {
          nixpkgs.overlays = [
            self.overlays.default
            # nur.overlays.default
          ];
          home.sessionVariables = {
            # environment.variables.LIBVA_DRIVER_NAME = "nvidia";
            # environment.variables.VDPAU_DRIVER = "nvidia";
            # environment.variables.VAAPI_DEVICE = "/dev/dri/by-path/pci-0000:01:00.0-render";
            # environment.variables.MOZ_DISABLE_RDD_SANDBOX = 1;
            # environment.variables.NVD_BACKEND = "direct";
            # (https://unix.stackexchange.com/a/596888)
            # https://wiki.archlinux.org/title/HiDPI#GDK_3_(GTK_3)
            MOZ_X11_EGL = "1";
            MOZ_USE_XINPUT2 = "1";
          };
          home.packages = [
            pkgs.geckodriver
            # firefox-nightly.packages.${pkgs.system}.firefox-nightly-bin
            # pkgs.firefox-devedition
          ];
          programs.browserpass.enable = true; # mkdir ~/.password-store/
          programs.firefox = {
            # nativeMessagingHosts.browserpass = true;
            enable = true;
            package = pkgs.firefox;
            # package = pkgs.firefox-devedition;
            # package = firefox-nightly.packages.${pkgs.system}.firefox-nightly-bin;
            profiles.root = {
              isDefault = true;
              extensions = with PKGS.nur.repos.rycee.firefox-addons; [
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
                browserpass
                # tab-session-manager # https://github.com/sienori/Tab-Session-Manager
                stylus
                # leechblock-ng
              ];
              bookmarks = [
                (import ./bookmarks_about.nix)
                (import ./bookmarks_nix.nix)
                (import ./bookmarks_.nix)
              ];
              settings = {
                # ~/.mozilla/firefox/root/user.js
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
                "browser.fixup.domainsuffixwhitelist.lan" = true;
                "browser.fixup.domainsuffixwhitelist.l" = true;
                "browser.fixup.domainsuffixwhitelist.containers" = true;
                "browser.fixup.domainsuffixwhitelist.c" = true;
                "browser.startup.firstrunSkipsHomepage" = false;
                "browser.newtabpage.pinned" = true;
                "browser.newtabpage.activity-stream.feeds.topsites" = false;
                "browser.newtabpage.activity-stream.section.highlights.rows" = 1;
                "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
                "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
                "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" = "DuckDuckGo";
                "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines" =
                  "DuckDuckGo";
                "browser.safebrowsing.downloads.remote.enabled" = false;
                "browser.search.suggest.enabled" = false;
                "browser.send_pings" = false;
                "browser.tabs.closeWindowWithLastTab" = false;
                "browser.tabs.loadDivertedInBackground" = true;
                "browser.tabs.loadInBackground" = true;
                "browser.tabs.loadBookmarksInTabs" = false;
                "browser.toolbars.bookmarks.visibility" = "always"; # "newtab"
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
                "privacy.firstparty.isolate" = false;
                "privacy.resistFingerprinting" = false;
                "privacy.trackingprotection.cryptomining.enabled" = true;
                "privacy.trackingprotection.enable" = true;
                "privacy.trackingprotection.fingerprinting.enabled" = true;
                "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
                "toolkit.zoomManager.zoomValues" = ".8,.95,1,1.1,1.2,1.3";
                "widget.use-xdg-desktop-portal.file-picker" = 1;
                # "widget.use-xdg-desktop-portal.location" = 2;
                # "widget.use-xdg-desktop-portal.mime-handler" = 2;
                # "widget.use-xdg-desktop-portal.open-uri" = 2;
                # "widget.use-xdg-desktop-portal.settings" = 2;
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
            engines = (import ./search_engines.nix);
          };
        };
    };
}
