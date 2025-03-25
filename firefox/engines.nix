let
  reddit = "https://www.reddit.com";
  ddg = "https://duckduckgo.com/?q="; # https://duckduckgo.com/duckduckgo-help-pages/results/syntax/
  github = "https://github.com";
in
{
  "bing".metaData.hidden = true;
  "google".metaData.alias = "@g";
  "@ad httpd.apache.org/docs/2.4" = {
    definedAliases = [ "@ad" ];
    urls = [ { template = "${ddg}site:httpd.apache.org/docs/2.4+{searchTerms}"; } ];
  };
  "@ah askapache.com/htaccess" = {
    definedAliases = [ "@ah" ];
    urls = [ { template = "${ddg}site:askapache.com/htaccess+{searchTerms}"; } ];
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
  "@ex explainshell.com" = {
    definedAliases = [ "@ex" ];
    urls = [ { template = "https://explainshell.com/explain?cmd={searchTerms}"; } ];
  };
}
