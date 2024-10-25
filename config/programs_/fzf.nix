# vim:nofoldenable
_: {
  programs.fzf = {
    # https://mynixos.com/home-manager/options/programs.fzf
    # https://github.com/junegunn/fzf
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    fileWidgetCommand = "fd -tf"; # Ctrl-t
    fileWidgetOptions = [ "--preview 'pistol {}'" ];
    changeDirWidgetCommand = "fd -td"; # Alt-c
    changeDirWidgetOptions = [ "--preview 'pistol {}'" ];
    defaultCommand = "fd -tf -H";
    defaultOptions = [
      "--layout=reverse"
      "--preview 'pistol {}'"
      "--preview-window up"
      "--bind ']:toggle-preview'"
      "--bind 'ctrl-]:change-preview-window(right|up)'"
      "--bind 'ctrl-f:reload(fd -tf)'"
      "--bind 'ctrl-F:reload(fd -tf -H)'"
      "--bind 'ctrl-d:reload(fd -td)'"
      "--bind 'ctrl-D:reload(fd -td -H)'"
      "--bind 'ctrl-i:execute(bat {})'"
      "--bind 'ctrl-y:execute-silent(echo {} | xclip -selection clipboard)+abort'"
      "--bind 'ctrl-e:become($EDITOR {})'"
      "--bind 'ctrl-o:become(xdg-open {})'"
    ];
  };
}
