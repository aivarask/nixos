{ inputs, lib, ... }: {
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nixpkgs.config.permittedInsecurePackages = [
    # "openssl-1.1.1v"
  ];
  nixpkgs.config.joypixels.acceptLicense = true;
  # nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      # audio
      "vital"
      "vital-1.5.5"
      "bitwig-studio"
      # --
      "unrar"
      "soulseekqt"
      "google-chrome"
      "google-chrome-dev"
      "nvidia-x11"
      "nvidia-settings"
      "joypixels"
      "ookla-speedtest"
      "vscode"
      "intelephense"
    ];
  nixpkgs.overlays =
    with inputs; [
      rust-overlay.overlays.default
      nur.overlay
      neovim-nightly-overlay.overlay
      st-flexipatch.overlays.default
      tabbed-flexipatch.overlays.default
      dwm-flexipatch.overlays.default
      dmenu-flexipatch.overlays.default

      # https://nixos.org/manual/nixpkgs/unstable/#ssec-language-go
      (_final: prev: with prev; {
        inherit LS_COLORS;
      })
      # vim.overlays.default
      (_final: prev:
        let
          inherit (prev.vimUtils) buildVimPlugin;
        in
        {
          vimPlugins = with inputs;
            prev.vimPlugins
            // {
              vim-log-highlighting = buildVimPlugin {
                name = "vim-log-highlighting";
                src = vim-log-highlighting;
              };
              pretty-fold = buildVimPlugin {
                name = "pretty-fold";
                src = pretty-fold;
              };
              fold-preview = buildVimPlugin {
                name = "fold-preview";
                src = fold-preview;
              };
              neotest-playwright = buildVimPlugin {
                name = "neotest-playwright";
                src = neotest-playwright;
              };
              neotest-vim-test = buildVimPlugin {
                name = "neotest-vim-test";
                src = neotest-vim-test;
              };
              refactoring-nvim = buildVimPlugin {
                name = "refactoring-nvim";
                src = refactoring-nvim;
              };
              vim-interestingwords = buildVimPlugin {
                name = "vim-interestingwords";
                src = vim-interestingwords;
              };
              nvim-lsp-file-operations = buildVimPlugin {
                name = "nvim-lsp-file-operations";
                src = nvim-lsp-file-operations;
              };
              # Session management
              persistence-nvim = buildVimPlugin {
                name = "persistence-nvim";
                src = persistence-nvim;
              };
              neovim-session-manager = buildVimPlugin {
                name = "neovim-session-manager";
                src = neovim-session-manager;
              };
              # DEBUGGING
              nvim-dap-vscode-js = buildVimPlugin {
                name = "nvim-dap-vscode-js";
                src = nvim-dap-vscode-js;
              };
              osv = buildVimPlugin {
                name = "osv";
                src = osv;
              };
            };
        })
    ];
}
