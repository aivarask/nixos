{ pkgs, ... }: {
  programs.firefox.profiles.root.search =
    {
      force = true;
      default = "DuckDuckGo";
      order = [ "DuckDuckGo" "Google" ];
      engines = {
        "Bing".metaData.hidden = true;
        "Google".metaData.alias = "@g";

        "ArchWiki @aw" = {
          definedAliases = [ "@aw" ];
          iconUpdateURL = "https://wiki.archlinux.org/favicon.ico";
          urls = [{ template = "https://wiki.archlinux.org/index.php?search={searchTerms}"; }];
        };

        "GitHub Code @gc" = {
          definedAliases = [ "@gc" ];
          iconUpdateURL = "https://github.githubassets.com/favicons/favicon.svg";
          urls = [{ template = "https://github.com/search?type=code&q={searchTerms}"; }];
        };
        "GitHub Issues @gi" = {
          definedAliases = [ "@gi" ];
          iconUpdateURL = "https://github.githubassets.com/favicons/favicon.svg";
          urls = [{ template = "https://github.com/search?type=issues&q={searchTerms}"; }];
        };
        "GitHub Repositories @gr" = {
          definedAliases = [ "@gr" ];
          iconUpdateURL = "https://github.githubassets.com/favicons/favicon.svg";
          urls = [{ template = "https://github.com/search?type=repositories&q={searchTerms}"; }];
        };
        "GitHub Users @gu" = {
          definedAliases = [ "@gu" ];
          iconUpdateURL = "https://github.githubassets.com/favicons/favicon.svg";
          urls = [{ template = "https://github.com/search?type=users&q={searchTerms}"; }];
        };

        "npm @npm" = {
          definedAliases = [ "@npm" ];
          iconUpdateURL = "https://static.npmjs.com/b0f1a8318363185cc2ea6a40ac23eeb2.png";
          urls = [{ template = "https://www.npmjs.com/search?q={searchTerms}"; }];
        };

        "Nix Manual @nm" = {
          definedAliases = [ "@nm" ];
          iconUpdateURL = "https://nixos.org/manual/nix/unstable/favicon.svg";
          urls = [{ template = "https://nixos.org/manual/nix/unstable/?search={searchTerms}"; }];
        };

        "NixOS Packages @np" = {
          definedAliases = [ "@np" ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                { name = "channel"; value = "unstable"; }
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }
          ];
        };

        "NixOS Options @no" = {
          definedAliases = [ "@no" ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          urls = [
            {
              template = "https://search.nixos.org/options";
              params = [
                { name = "channel"; value = "unstable"; }
                { name = "type"; value = "options"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }
          ];
        };

        "NixOS Wiki @nw" = {
          definedAliases = [ "@nw" ];
          iconUpdateURL = "https://nixos.wiki/favicon.png";
          updateInterval = 24 * 60 * 60 * 1000; # every day
          urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
        };

        "MyNixOS @mn" = {
          definedAliases = [ "@mn" ];
          iconUpdateURL = "https://mynixos.com/favicon.ico";
          updateInterval = 24 * 60 * 60 * 1000; # every day
          urls = [{ template = "https://mynixos.com/search?q={searchTerms}"; }];
        };

        "NixOS Discourse @nd" = {
          definedAliases = [ "@nd" ];
          iconUpdateURL = "https://discourse.nixos.org/uploads/default/optimized/1X/401be373869e12dfe689b9d7eb347f78b1a105f0_2_32x32.png";
          updateInterval = 24 * 60 * 60 * 1000; # every day
          urls = [{ template = "https://discourse.nixos.org/search?q={searchTerms}"; }];
        };

        "neovim discourse @vd" = {
          definedAliases = [ "@vd" ];
          # iconUpdateURL = "https://mynixos.com/favicon.ico";
          # updateInterval = 30 * 24 * 60 * 60 * 1000; # every month
          urls = [{ template = "https://neovim.discourse.group/search?q={searchTerms}"; }];
        };
      };
    };
}
