{ pkgs, ... }: {
  imports = [
    ./go.nix
    ./json.nix
    ./lua.nix
    ./make.nix
    ./nix.nix
    ./svelte.nix
    ./toml.nix
    ./vim.nix
    ./yaml.nix
  ];
  environment.systemPackages = with pkgs; [
    vscode-langservers-extracted
  ];
}
