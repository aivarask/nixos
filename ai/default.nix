{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # https://huggingface.co/docs/trl/main/en/installation
    python3Packages.huggingface-hub
    # python3Packages.transformers
    # python3Packages.trlib
    cudatoolkit
  ];
  # https://wiki.nixos.org/wiki/Ollama
  # https://ollama.com/library
  # https://mynixos.com/nixpkgs/options/services.ollama
  # https://wiki.nixos.org/wiki/CUDA
  services.ollama = {
    enable = true;
    # package = pkgs.ollama-cuda;
    environmentVariables = {
      OLLAMA_LLM_LIBRARY = "cuda";
      LD_LIBRARY_PATH = "run/opengl-driver/lib";
    };
    acceleration = "cuda"; # long build
    loadModels = [
      # "deepseek-r1"
      # "deepseek-r1:14b"
      "deepseek-r1:32b"
    ];
  };
}
