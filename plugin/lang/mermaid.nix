{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      puppeteer-cli
      mermaid-cli
    ];
    shellAliases = {
      puppeteer = "puppeteer --no-sandbox";
      # mmdc = "mmdc -p ${builtins.toString ./.}/puppeteerConfigFile.json";
    };
  };
}
