{pkgs, ...}: {
  environment.variables = {
    OPENAI_API_KEY = "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";
  };
  # https://search.nixos.org/packages#?type=packages&query=chatgpt
  environment.systemPackages = with pkgs; [
    chatgpt-cli
    chatblade
    shell_gpt #sgpt
    aichat
    tgpt # no API key needed
    yai
    #
    # https://github.com/mudler/LocalAI
    # https://github.com/eugeneyan/open-llms
    ollama
  ];
}
