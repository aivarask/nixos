{
  outputs = _: {
    nixosModules.default = { ... }: { };
    nixosModules.home =
      { pkgs, ... }:
      {
        xdg.configFile."tmux/tmux.conf" = ./tmux.conf;
        programs.tmux = {
          enable = true;
          plugins = with pkgs.tmuxPlugins; [
            resurrect
            tmux-fzf
            tmux-floax

            # tmux-fzf
            # fzf-tmux-url
            # tilish
            # sensible # https://github.com/tmux-plugins/tmux-sensible
          ];
          # terminal = "xterm-256color";
          # terminal = "tmux-direct";
          # keyMode = "vi";
          # extraConfig = ''
          #   unbind C-b
          #   set-option -g prefix M-`
          #   bind-key M-` send-prefix
          # '';
        };
      };
  };
}
