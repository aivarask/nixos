{ pkgs, ... }:
{
  environment = {

    profiles = [
      "${pkgs.zsh-completions}"
    ];
    variables = {
      EDITOR = "nvim";
      XINITRC = "/etc/nixos/files/xinitrc";
      SXHKDRC = "/etc/nixos/files/sxhkdrc";
    };
    shellAliases = {
      wol_pc = "wol b4:2e:99:61:09:cf";
      ".." = "cd ..";
      "..." = "../..";
      ls = "eza --icons";
      l = "ls -l --group-directories-first";
      oras = "curl wttr.in/Vilnius";
      x = "startx";
    };
    sessionVariables = rec {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
      XDG_BIN_HOME = "$HOME/.local/bin";

      PATH = [
        "${XDG_BIN_HOME}"
        "/etc/nixos/bin"
      ];

    };
  };
}
