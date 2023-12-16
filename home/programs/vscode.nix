{pkgs, ...}: {
  programs.vscode = {
    enable = true;
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
        ms-vscode-remote.remote-ssh
        svelte.svelte-vscode
        # vscodevim.vim
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "remote-ssh-edit";
          publisher = "ms-vscode-remote";
          version = "0.47.2";
          sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
        }
      ];
  };
}
