{
  pkgs,
  config,
  xdgconf,
  ...
}:
let
  username = config.home.username;
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  xdg.configFile."mozilla/firefox/${username}/chrome" = {
    source = symlink "${xdgconf}/firefox/chrome";
    enable = true;
    force = true;
    recursive = true;
  };
  xdg.configFile."mozilla/firefox/${username}/user.js" = {
    source = symlink "${xdgconf}/firefox/user.js";
    enable = true;
    force = true;
  };

  programs.firefox.profiles."${username}" = {
    id = 0;
    isDefault = true;
    name = username;
    path = username;
    search = {
      force = true;
      default = "ddg";
      privateDefault = "ddg";
      engines =
        let
          reddit = "https://www.reddit.com";
          ddg = "https://duckduckgo.com/?q="; # https://duckduckgo.com/duckduckgo-help-pages/results/syntax/
          github = "https://github.com";
        in
        {
          "bing".metaData.hidden = true;
          "google".metaData.alias = "@g";
          # "" = {
          #   definedAliases = [ "" ];
          #   urls = [
          #     { template = ""; }
          #   ];
          # };
          "@nb https://nix-builtins-search.extranix.com" = {
            definedAliases = [
              "@nb"
              "@nix-builtins"
            ];
            urls = [
              { template = "https://nix-builtins-search.extranix.com/?query={searchTerms}&release=nix-v2.24"; }
            ];
          };
          "@hm home-manager-options.extranix.com" = {
            definedAliases = [
              "@hm"
              "@home-manager"
            ];
            urls = [
              {
                template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=release-24.11";
              }
            ];
          };
          "@yt youtube.com" = {
            definedAliases = [ "@yt" ];
            urls = [ { template = "https://www.youtube.com/results?search_query={searchTerms}"; } ];
          };
          "@ad httpd.apache.org/docs/2.4" = {
            definedAliases = [
              "@ad"
              "@apache"
            ];
            urls = [ { template = "${ddg}site:httpd.apache.org/docs/2.4+{searchTerms}"; } ];
          };
          "@ah askapache.com/htaccess" = {
            definedAliases = [
              "@ah"
              "@apache"
            ];
            urls = [ { template = "${ddg}site:askapache.com/htaccess+{searchTerms}"; } ];
          };
          "@ff searchfox.org" = {
            definedAliases = [
              "@ff"
              "@sf"
            ];
            urls = [
              {
                template = "https://searchfox.org/mozilla-central/search?q={searchTerms}&path=&case=false&regexp=false";
              }
            ];
          };
          "@php php.net" = {
            definedAliases = [ "@php" ];
            urls = [ { template = "${ddg}site:php.net+{searchTerms}"; } ];
          };
          "@nur" = {
            definedAliases = [ "@nur" ];
            urls = [ { template = "${ddg}site:nur.nix-community.org+{searchTerms}"; } ];
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
          "@reddit nixos" = {
            definedAliases = [ "@rnixos" ];
            urls = [ { template = "${reddit}/r/NixOS/search/?q={searchTerms}"; } ];
          };
          "@np search.nixos.org/packages" = {
            definedAliases = [ "@np" ];
            urls = [
              {
                template = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={searchTerms}";
              }
            ];
          };
          "@no search.nixos.org/options" = {
            definedAliases = [ "@no" ];
            urls = [
              { template = "https://search.nixos.org/options?channel=unstable&type=options&query={searchTerms}"; }
            ];
          };
          "@nm nixos.org/manual" = {
            definedAliases = [ "@nm" ];
            urls = [ { template = "https://nixos.org/manual/nix/unstable/?search={searchTerms}"; } ];
          };
          "@nw wiki.nixos.org" = {
            definedAliases = [ "@nw" ];
            urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
          };
          "@nd discourse.nixos.org" = {
            definedAliases = [ "@nd" ];
            urls = [ { template = "https://discourse.nixos.org/search?q={searchTerms}"; } ];
          };
          "@aw wiki.archlinux.org" = {
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
          "@ex explainshell.com" = {
            definedAliases = [ "@ex" ];
            urls = [ { template = "https://explainshell.com/explain?cmd={searchTerms}"; } ];
          };
        };
    };
  };
}
