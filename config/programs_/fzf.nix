# vim:nofoldenable
{ ... }:
{
  programs.fzf = {
    # https://mynixos.com/home-manager/options/programs.fzf
    # https://github.com/junegunn/fzf
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    defaultCommand = "fd -tf";
    defaultOptions = [
      "--layout=reverse"
      "--preview-window up"
      "--bind ']:toggle-preview'"
      "--bind 'ctrl-]:change-preview-window(right|up)'"
      "--bind 'f1:execute(bat {})'"
      "--bind 'ctrl-y:execute-silent(echo {} | xclip -selection clipboard)+abort'"
      "--bind 'ctrl-e:become(nvim {})'"
      "--bind 'ctrl-f:reload(fd -tf)'"
      "--bind 'ctrl-d:reload(fd -td)'"
    ];
    fileWidgetCommand = "fd -tf"; # Ctrl-t
    fileWidgetOptions = [ "--preview 'pistol {}'" ];
    changeDirWidgetCommand = "fd --td"; # Alt-c
    changeDirWidgetOptions = [ "--preview 'pistol {}'" ];
  };
}
