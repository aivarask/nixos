{pkgs, ...}: {
  # https://github.com/nix-community/awesome-nix#command-line-tools
  environment.systemPackages = with pkgs; [
    nixos-generators
    # https://github.com/nix-community/awesome-nix#development
    alejandra
    # comma
    deadnix
    manix

    # nixfmt
    # nixpkgs-fmt
    # nixpkgs-hammering
    # nix-alien
    # nix-diff
    # nix-du
    nix-index
    # nix-init
    nix-prefetch
    nix-tree
    nurl
    # nvd
    statix
    nixdoc

    # https://github.com/nix-community/awesome-nix#development
    rnix-parser
    rnix-lsp
    nil
    niv

    # -- OTHER --
    # nix-prefetch-git
    # nix-prefetch-github
    # nix-template
    # nix-tour
  ];
}
