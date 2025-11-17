{
  system =
    { pkgs, ... }:
    {
      # https://www.youtube.com/watch?v=GuTcle5edjk
      environment.systemPackages = with pkgs; [
        obsidian
        litellm
        claude-code
        lmstudio
        # open-webui
        n8n

        python3Packages.huggingface-hub
        # python3Packages.transformers
        # python3Packages.trlib
        # cudatoolkit
        # python3Packages.llama-index-cli
        # python3Packages.llama-index-llms-ollama
      ];
      services.ollama.enable = false;
      services.ollama.package = pkgs.ollama-cuda;
      services.ollama.environmentVariables.OLLAMA_LLM_LIBRARY = "cuda";
      services.ollama.environmentVariables.LD_LIBRARY_PATH = "run/opengl-driver/lib";
      services.ollama.acceleration = "cuda"; # long build
      services.ollama.loadModels = [ ];
    };
}
