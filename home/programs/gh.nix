{ pkgs, ... }:
{
  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      gh-eco
      # gh-poi
      # gh-dash
      # sh-screensaver
      # gh-actions-cache
      gh-markdown-preview
    ];
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
    };

  };
}
