{ pkgs, config, ... }:
{
  # home.packages = [ pkgs.tmux ];
  xdg.configFile."tmux".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/tmux";
  programs.tmux.enable = true;
  programs.tmux.keyMode = "vi";
  programs.tmux.terminal = "screen-256color"; # xterm-256color tmux-direct
  programs.tmux.shell = "/${pkgs.zsh}/bin/zsh";
  programs.tmux.extraConfig = ''
    unbind C-b
    set-option -g prefix M-`
    bind-key M-` send-prefix
  '';
  programs.tmux.plugins = with pkgs; [
    {
      plugin = pkgs.tmuxPlugins.tmux-fzf;
      extraConfig = '''';
    }
    {
      plugin = pkgs.tmuxPlugins.tmux-floax;
      extraConfig = '''';
    }
    {
      plugin = pkgs.tmuxPlugins.cpu;
      extraConfig = '''';
    }
    {
      plugin = pkgs.tmuxPlugins.continuum;
      extraConfig = ''
        set -g @continuum-restore 'on'
        set -g @continuum-save-interval '60' # minutes
      '';
    }
    # {
    #   plugin = tmuxPlugins.resurrect;
    #   extraConfig = ''
    #     set -g @resurrect-strategy-nvim 'session'
    #   '';
    # }
  ];
}
