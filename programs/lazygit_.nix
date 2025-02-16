{ ... }:
{
  home.shellAliases."\\l" = "lazygit";
  programs.lazygit.enable = true;
  # https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md
  programs.lazygit.settings = {
    os = {
      open = "xdg-open {{filename}} >/dev/null";
      openLink = "bash -C /path/to/your/shell-script.sh {{link}}";
      copyToClipboardCmd = ''
            if [[ "$TERM" =~ ^(screen|tmux) ]]; then
              printf "\033Ptmux;\033\033]52;c;$(printf {{text}} | base64 -w 0)\a\033\\" > /dev/tty
            else
              printf "\033]52;c;$(printf {{text}} | base64 -w 0)\a" > /dev/tty
            fi
        			'';
      readFromClipboardCmd = "";
      edit = "nvr {{filename}}";
      # editPreset = "nvim-remote";
      editAtLine = "nvr --line={{line}} {{filename}}";
      editAtLineAndWait = "nvr --block --line={{line}} {{filename}}";
      editInTerminal = true;
      openDirInEditor = "nvr {{dir}}";
    };
  };

}
