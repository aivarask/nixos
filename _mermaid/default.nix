{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      puppeteer-cli
      mermaid-cli
    ];
    variables = { };
    shellAliases = {
      puppeteer = "puppeteer --no-sandbox";
      mmdc = "mmdc -p ${builtins.toString ./.}/puppeteerConfigFile.json";
    };
  };
}
