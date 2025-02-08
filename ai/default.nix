{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # https://huggingface.co/docs/trl/main/en/installation
    python3Packages.huggingface-hub
    # python3Packages.transformers
    # python3Packages.trlib
  ];
}
