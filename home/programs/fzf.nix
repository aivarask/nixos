{ ... }: {
  # https://github.com/junegunn/fzf#usage
  # https://github.com/nix-community/home-manager/blob/master/modules/programs/fzf.nix
  # --ignore-file=$HOME/.config/git/ignore
  programs.fzf = {
    enable = true;
    defaultCommand = "fd -tf";
    defaultOptions = [
      "--layout=reverse"
      "--bind 'f1:execute(bat {})'"
      "--bind ']:toggle-preview'"
      "--bind 'ctrl-]:change-preview-window(up|right)'"
      "--bind 'ctrl-y:execute-silent(echo {} | xclip -selection clipboard)+abort'"
      "--bind 'ctrl-e:become(nvim {})'"
      "--bind 'ctrl-f:reload(fd -tf)'"
      "--bind 'ctrl-d:reload(fd -td)'"
    ];
    fileWidgetCommand = "fd --type f"; # Ctrl-t
    fileWidgetOptions = [ "--preview 'pistol {}'" ];
    changeDirWidgetCommand = "fd --type d"; # Alt-c
    changeDirWidgetOptions = [ "--preview 'pistol {}'" ];
  };
}
