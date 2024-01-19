{ pkgs, ... }: {
  # https://nixos.org/manual/nixpkgs/unstable/#chap-language-support
  imports = [
    ./go.nix
    ./json.nix
    ./lua.nix
    ./make.nix
    ./nix.nix
    ./php.nix
    ./sql.nix
    ./svelte.nix
    ./toml.nix
    ./vim.nix
    ./yaml.nix
  ];
  environment.systemPackages = with pkgs; [
    vscode-langservers-extracted
  ];
}
