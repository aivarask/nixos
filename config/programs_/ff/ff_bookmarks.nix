{ ... }:
{
  programs.firefox.profiles.root.bookmarks = [
    {
      name = "pcl.local:9000";
      url = "http://pcl.local:9000/#pc";
    }
    {
      name = "pcw.local:9000";
      url = "http://pcw.local:9000/#pc";
    }
    {
      name = "ndn NixOS Discourse Notifications";
      url = "https://discourse.nixos.org/u/aivarask/notifications";
    }
    # Manuals
    {
      name = "nixos.org/manual/nix";
      url = "https://nixos.org/manual/nix/unstable/";
      tags = [ "nix" ];
    }
    {
      name = "nixos.org/manual/nixos";
      tags = [ "nixos" ];
      url = "https://nixos.org/manual/nixos/unstable/";
    }
    {
      name = "nixos.org/manual/nixpkgs";
      tags = [ "nixpkgs" ];
      url = "https://nixos.org/manual/nixpkgs/unstable";
    }
    {
      name = "nixos.org/manual/nixpkgs#chap-language-support";
      tags = [
        "nixpkgs"
        "lang"
      ];
      url = "https://nixos.org/manual/nixpkgs/unstable/#chap-language-support";
    }
    {
      name = "PHP";
      url = "https://nixos.org/manual/nixpkgs/unstable/#sec-php";
    }
    {
      name = "Home Manager Options";
      url = "https://nix-community.github.io/home-manager/nixos-options.xhtml";
    }

    # Sites
    {
      name = "Nix sites";
      bookmarks = [
        {
          name = "NixOS Home";
          url = "https://nixos.org";
        }
        {
          name = "NixOS Wiki";
          url = "https://nixos.wiki";
        }
        {
          name = "NixOS & Flakes Book";
          url = "https://nixos-and-flakes.thiscute.world";
        }
      ];
    }
    {
      name = "Sofascore Euroleague";
      url = "https://www.sofascore.com/tournament/basketball/international/euroleague/138";
    }
  ];
}
