{ pkgs, ... }: {
  environment.shellAliases = {
    ncl = "nix-channel --list";
    ncu = "nix-channel --update";
    mf = ''
      manix "" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --preview="manix '{}'" | xargs manix
    '';
  };
  environment.systemPackages = with pkgs; [
    statix
    deadnix
    nixpkgs-fmt
    nil
    nixd
    # manuals
    manix
    nix-doc
    nixdoc
    ###

    # https://github.com/nix-community/awesome-nix#command-line-tools
    nixos-generators

    # https://github.com/nix-community/awesome-nix#development
    # comma

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

    # https://github.com/nix-community/awesome-nix#development
    niv

    # -- OTHER --
    # nix-prefetch-git
    # nix-prefetch-github
    # nix-template
    # nix-tour
  ];
}
