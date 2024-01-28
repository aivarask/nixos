{ ... }: {
  home.sessionVariables = {
   FZF_COMPLETION_TRIGGER = "~~";
    FZF_COMPLETION_OPTS = "--border --info=inline";
  };

  # https://github.com/nix-community/home-manager/blob/master/modules/programs/fzf.nix
  # https://github.com/junegunn/fzf/wiki
  programs.fzf = {
    enable = true;
    defaultCommand = "fd --type f --ignore-file=$HOME/.config/git/ignore";
    defaultOptions = [
      "--layout=reverse"
      "--bind 'ctrl-space:refresh-preview'"
      "--bind 'ctrl-e:execute($EDITOR {})'"
      "--bind 'ctrl-f:reload(eval \"$FZF_DEFAULT_COMMAND\")'"
      "--bind 'ctrl-d:reload(fd --type d)'"
      "--bind 'ctrl-g:execute(eval \"fzl\")'"
      "--bind 'ctrl-h:reload(fd --type f --hidden)'"
      # "--bind 'ctrl-/:preview:pistol {}'"
      "--bind 'ctrl-/:toggle-preview'"
      "--preview 'pistol {}'"
      "--preview-window hidden"
    ];

    fileWidgetCommand = "fd --type f";
    # fileWidgetOptions = [ "--preview 'pistol {}'" ];

    changeDirWidgetCommand = "fd --type d";
    # changeDirWidgetOptions = [
    # "--height=90%"
    # "--preview='pistol {}'"
    # "--preview-window=wrap:down:70%"
    # ];

    historyWidgetOptions = [
      "--preview ''"
    ];
  };
}
