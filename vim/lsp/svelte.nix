{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nodePackages.svelte-language-server
  ];
}
