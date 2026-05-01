{ pkgs, ... }:
{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
    loadModels = [ "qwen3.6" ];
  };
  environment.systemPackages = with pkgs; [
    openclaw
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "openclaw-2026.4.21"
  ];
}

