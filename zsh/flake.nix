{
  inputs = { };
  outputs =
    { ... }@inputs:
    {
      nixosModules.default =
        { pkgs, ... }:
        {
          environment.profiles = [
            "${pkgs.zsh-abbr}"
          ];
        };
      hmModules.default =
        { pkgs, ... }:
        {
          programs.firefox.profiles.root.bookmarks = [
            # ~/.mozilla/firefox/root/user.js
            {
              name = "zsh-toolbar";
              toolbar = true;
              bookmarks = [
                {
                  name = "zsh"; # folder
                  bookmarks = [
                    {
                      name = "zsh-abbr";
                      url = "${pkgs.zsh-abbr.meta.homepage}";
                      # tags = [ "zsh-abbr" ];
                      # keyword = "";
                    }
                    {
                      name = "zsh-autosuggestions-abbreviations-strategy";
                      url = "${pkgs.zsh-autosuggestions-abbreviations-strategy.meta.homepage}";
                      # tags = [ "zsh-autosuggestions-abbreviations-strategy" ];
                      # keyword = "";
                    }
                  ];
                }
              ];
            }
          ];
        };
    };
}
