{ pkgs, lib, ... }: {
  system.extraDependencies = with pkgs; [ zlib ];
  environment.systemPackages = with pkgs; [
    clang
    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/development/tools/clang-tools/default.nix
    (clang-tools.override {
      enableLibcxx = true;
      # llvmPackages = llvmPackages;
    })

  ];
}




