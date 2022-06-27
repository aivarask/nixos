{ config, pkgs, libs, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      # # https://starship.rs/config
      # add_newline = false
      # [package]
      # disabled = true
      # [username]
      # style_user = "white bold"
      # style_root = "green bold"
      # format = " [$user]($style)"
      # disabled = false
      # show_always = true
      # [hostname]
      # ssh_only = false
      # format = "@[$hostname](bold green) in "
      # # trim_at = ".deta.lt"
      # disabled = false
    };
  };
  programs.direnv = {
    enable = false;
    nix-direnv.enable = false;
  };
  programs.nix-index.enable = true;
  programs.zsh = {
    autocd = true;
    cdpath = [ "/etc/nixos" ];
    completionInit = "autoload -U compinit && compinit"; # default value
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    history = {
      size = 10000;
    };
    initExtra = ''
      unalias run-help
      autoload -Uz run-help
      source /etc/nixos/functions.zsh
      source /etc/nixos/bindings.zsh
      # eval "$(direnv hook zsh)"
    '';
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.4.0";
          sha256 = "037wz9fqmx0ngcwl9az55fgkipb745rymznxnssr3rx9irb6apzg";
        };
      }
      {
        name = "forgit";
        file = "forgit.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "wfxr";
          repo = "forgit";
          rev = "810735294107ef1b1de66cf1cdfc358fc14049ac";
          sha256 = "foi5zb7oZOfxBmpYmDq30VCenKPS//nxKSzqi+hsvoY=";
          fetchSubmodules = true;
        };
      }
    ];
  };
}
