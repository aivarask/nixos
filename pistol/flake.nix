# vim: nofoldenable
{
  description = "pistol";
  inputs = {
    nixpkgs.url = "nixpkgs";
    systems.url = "systems";
  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
    }:
    let
      forEachSupportedSystem =
        f:
        nixpkgs.lib.genAttrs systems (
          system:
          f {
            pkgs = import nixpkgs { inherit system; };
          }
        );
    in
    {
      nixosModules.default =
        { pkgs, ... }:
        {
          environment.systemPackages = with pkgs; [ pistol ];
          environment.profiles = [ "${./.}" ];
        };
      nixosModules.hm =
        { ... }:
        {
          programs.pistol = {
            enable = false;
            associations = [
              {
                mime = "inode/directory";
                command = "eza --tree --level=3 --group --group-directories-first %pistol-filename%";
              }
              {
                mime = "inode/x-empty";
                command = "echo inode/x-empty";
              }
              {
                mime = "application/json";
                command = "sh: jq '.' %pistol-filename% -C";
              }
              {
                mime = "application/pdf";
                command = "zathura %pistol-filename%";
              }
              {
                mime = "application/*";
                command = "bat --color=always --style=plain --pager=never %pistol-filename%";
              }
              {
                fpath = ".*.md$";
                command = "sh: bat --paging=never --color=always %pistol-filename% | head -8";
              }
              {
                mime = "text/html";
                command = "w3m -T text/html -dump_source %pistol-filename%";
              }
              {
                mime = "text/*";
                command = "bat --color=always --style=plain --pager=never %pistol-filename%";
              }
              # escape characters needed
              # inkview display chafa feh
              # {
              #   mime = "image/*";
              #   command = "pv %pistol-filename% %pistol-extra0% %pistol-extra1% %pistol-extra2% %pistol-extra3%";
              # }
              {
                mime = "image/*";
                command = "chafa %pistol-filename%";
              }
            ];
          };

        };
      devShells = forEachSupportedSystem (
        { pkgs }:
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              cachix
              lorri
              niv
              nixfmt-classic
              statix
              vulnix
              haskellPackages.dhall-nix
            ];
          };
        }
      );
    };
}
