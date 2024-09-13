pkgs:
(final: prev: {
  gow = pkgs.buildGoModule {
    name = "gow";
    src = builtins.fetchGit {
      url = "https://github.com/mitranim/gow";
      rev = "af11a6e1e9ebccdcdace2a6df619355b85494d74";
    };
    vendorHash = "sha256-Xw9V7bYaSfu5kA2505wmef2Ns/Y0RHKbZHUkvCtVNSM=";
  };
})
