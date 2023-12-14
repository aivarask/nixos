{...}: {
  programs.vscode = {
    enable = true;
    keybindings = [
      # {
      #   key = "ctrl+c";
      #   command = "editor.action.clipboardCopyAction";
      #   when = "textInputFocus";
      # }
      {
        key = "ctrl+s";
        command = "workbench.action.files.saveAll";
      }
    ];
  };
}
