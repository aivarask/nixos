inputs: with inputs; [
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
]
