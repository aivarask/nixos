{ pkgs, ... }:
{
  # https://www.youtube.com/watch?v=GH3kpsbbERo
  environment.shellAliases = {
    mc = "tmux split -h lf; lf";
  };
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.tmux-fzf
      tmuxPlugins.resurrect
    ];
    terminal = "xterm-256color";
    # keyMode = "vi";
    # extraConfig = ''
    #   unbind C-b
    #   set-option -g prefix M-`
    #   bind-key M-` send-prefix
    # '';
  };
}
