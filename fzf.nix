# [[ $(tput cols) -le 100 ]] && params+=(--preview-window=wrap:down:70%) || params+=(--preview-window=wrap:right:80)
{ config, ... }: {
  programs.fzf = {
    enable = true;
    defaultCommand = "fd --type f --ignore-file=$HOME/.config/git/ignore";
    defaultOptions = [
      "--layout=reverse"
      "--preview 'pistol {}'"
      "--bind 'ctrl-space:refresh-preview'"
      "--bind 'ctrl-e:execute($EDITOR {})'"
      "--bind 'ctrl-f:reload(fd --type f)'"
      "--bind 'ctrl-d:reload(fd --type d)'"
      "--bind 'ctrl-h:reload(fd --type f --hidden)'"
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
