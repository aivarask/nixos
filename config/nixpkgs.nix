{ inputs, lib, pkgs, ... }: {
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nixpkgs.config.permittedInsecurePackages = [ ];
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
  environment.shellAliases = {
    ncl = "nix-channel --list";
    ncu = "nix-channel --update";
    nr = "nixos-rebuild";
    nrs = "nixos-rebuild switch";
    nrt = "nixos-rebuild test";
    nrl = "nix registry list";
    nfu = "nix flake update";
    nfl = "nix flake lock";
    ncg = "nix-collect-garbage";
  };
  environment.systemPackages = with pkgs; [
    nixpkgs-fmt
    nil
    nurl
    deadnix
    nixos-generators
  ];
  nixpkgs.overlays =
    with inputs; [
      nur.overlay
      neovim-nightly-overlay.overlay


      (_final: prev: with prev; {
        inherit LS_COLORS;
      })
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
                meta = { homepage = "https://github.com/MTDL9/vim-log-highlighting"; };
              };
              vim-interestingwords = buildVimPlugin {
                name = "vim-interestingwords";
                src = vim-interestingwords;
                meta = { homepage = "https://github.com/lfv89/vim-interestingwords"; };
              };
              nvim-lsp-file-operations = buildVimPlugin {
                name = "nvim-lsp-file-operations";
                src = nvim-lsp-file-operations;
                meta = { homepage = "https://github.com/antosha417/nvim-lsp-file-operations"; };
              };
              neovim-session-manager = buildVimPlugin {
                name = "neovim-session-manager";
                src = neovim-session-manager;
                meta = { homepage = "https://github.com/Shatur/neovim-session-manager"; };
              };
              nvim-dap-vscode-js = buildVimPlugin {
                name = "nvim-dap-vscode-js";
                src = nvim-dap-vscode-js;
                meta = { homepage = "https://github.com/mxsdev/nvim-dap-vscode-js"; };
              };
              osv = buildVimPlugin {
                name = "osv";
                src = osv;
                meta = { homepage = "https://github.com/jbyuki/one-small-step-for-vimkind"; };
              };
            };
        })
    ];
}
