{ pkgs, ... }: {
  # https://www.youtube.com/watch?v=GH3kpsbbERo
  environment.shellAliases = {
    mc = "tmux split -h lf; lf";
    mcd = "tmux split -h nd; ndcw; ndtw";
  };
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.tmux-fzf
      tmuxPlugins.resurrect
    ];
    terminal = "xterm-256color";
    keyMode = "vi";
    extraConfig = ''
      unbind C-b
      set-option -g prefix M-`
      bind-key M-` send-prefix
    '';
  };
}
