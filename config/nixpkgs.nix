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
      "vscode-extension-ms-vscode-remote-remote-ssh"
      "intelephense"
    ];
  nixpkgs.overlays =
    with inputs; [
      rust-overlay.overlays.default
      nur.overlay
      neovim-nightly-overlay.overlay
      slstatus.overlays.default
      st-flexipatch.overlays.default
      tabbed-flexipatch.overlays.default
      dwm-flexipatch.overlays.default
      dmenu-flexipatch.overlays.default

      # https://nixos.org/manual/nixpkgs/unstable/#ssec-language-go
      (final: prev: with prev; {
        inherit LS_COLORS;
      })
      vim.overlays.default
    ];
}
