# vim: nofoldenable
{ ... }:
{
  programs.firefox.profiles.root.bookmarks = [
    {
      name = "nix";
      toolbar = true;
      bookmarks = [
        {
          name = "nix";
          bookmarks = [
            {
              name = "nix.dev/";
              url = "https://nix.dev/";
            }
            {
              name = "nixos.org/manual/nixos/";
              url = "https://nixos.org/manual/nixos/unstable/";
            }
            {
              name = "nixos.org/manual/nixpkgs/";
              url = "https://nixos.org/manual/nixpkgs/unstable/";
            }
            {
              name = "wiki.nixos.org/wiki";
              url = "https://wiki.nixos.org/wiki/NixOS_Wiki";
            }
          ];
        }
      ];
    }
  ];
}
