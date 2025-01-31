# vim: nofoldenable
{
  outputs = _: {
    nixosModules.default = _: {
      environment.profiles = [ "${./.}" ];
    };
    nixosModules.home = _: {
      programs.fzf = rec {
        enable = true;
        enableZshIntegration = true;
        enableBashIntegration = true;
        fileWidgetCommand = "fd -tf --exclude '*.drv'"; # Ctrl-t
        fileWidgetOptions = defaultOptions;
        changeDirWidgetCommand = "fd -td"; # Alt-c
        changeDirWidgetOptions = defaultOptions;
        defaultCommand = "fd -tf -H --exclude  '*.drv'"; # Ctrl-f
        defaultOptions = [
          "--style full"
          "--bind 'focus:transform-header:file --brief {}'"
          "--layout reverse"
          "--height 100%"
          "--preview 'pistol_ {}'"
          "--preview-window up"
          "--bind ']:toggle-preview'"
          "--bind 'ctrl-]:change-preview-window(right|up)'"
          "--bind 'ctrl-f:reload(fd -tf)'"
          "--bind 'ctrl-F:reload(fd -tf -H)'"
          "--bind 'ctrl-d:reload(fd -td)'"
          "--bind 'ctrl-D:reload(fd -td -H)'"
          "--bind 'ctrl-i:execute(bat {})'"
          "--bind 'ctrl-b:execute(file --mime-type {} | xargs notify-send)'"
          "--bind 'ctrl-y:execute-silent(echo {} | xclip -selection clipboard)+abort'"
          "--bind 'ctrl-e:become($EDITOR {})'"
          "--bind 'ctrl-o:become(xdg-open {})'"
        ];
      };
    };
  };
}
