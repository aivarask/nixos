{ pkgs, ... }: {
  programs.vscode = {
    enable = false;
    package = pkgs.vscodium.fhs;
    userSettings = {
      "files.autoSave" = "afterDelay";
    };
    keybindings = [
      {
        key = "ctrl+c";
        command = "editor.action.clipboardCopyAction";
        when = "textInputFocus";
      }
      {
        key = "ctrl+s";
        command = "workbench.action.files.saveAll";
      }
    ];
    extensions = with pkgs.vscode-extensions;
      [
        bbenoist.nix
        ms-python.python
        # ms-azuretools.vscode-docker
        # vscodevim.vim
      ];
  };
}
