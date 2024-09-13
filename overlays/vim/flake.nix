{
  inputs = {
    vim-log-highlighting = {
      url = "github:MTDL9/vim-log-highlighting";
      flake = false;
    };
    sxhkd-vim = {
      url = "github:kovetskiy/sxhkd-vim";
      flake = false;
    };
    vim-interestingwords = {
      url = "github:lfv89/vim-interestingwords";
      flake = false;
    };
    nvim-lsp-file-operations = {
      url = "github:antosha417/nvim-lsp-file-operations";
      flake = false;
    };
    nvim-dap-vscode-js = {
      url = "github:mxsdev/nvim-dap-vscode-js";
      flake = false;
    };
    neotest-playwright = {
      url = "github:thenbe/neotest-playwright";
      flake = false;
    };
    persistent-breakpoints = {
      url = "github:Weissle/persistent-breakpoints.nvim";
      flake = false;
    };
    smart-semicolon = {
      url = "github:iagotito/smart-semicolon.nvim";
      flake = false;
    };
  };
  outputs =
    { ... }@inputs:
    {
      home.default =
        { pkgs, ... }:
        {
          programs.neovim.plugins = with pkgs.vimPlugins; [
            # common
            vim-log-highlighting
            sxhkd-vim
            vim-interestingwords
            # nvim
            nvim-lsp-file-operations
            nvim-dap-vscode-js
            neotest-playwright
            persistent-breakpoints
            smart-semicolon
          ];
        };
      overlays.default = (
        _: prev:
        let
          inherit (prev.vimUtils) buildVimPlugin;
        in
        {
          vimPlugins =
            with inputs;
            prev.vimPlugins
            // {
              vim-log-highlighting = buildVimPlugin {
                name = "vim-log-highlighting";
                src = vim-log-highlighting;
                meta = {
                  homepage = "https://github.com/MTDL9/vim-log-highlighting";
                };
              };
              sxhkd-vim = buildVimPlugin {
                name = "sxhkd-vim";
                src = sxhkd-vim;
                meta = {
                  homepage = "https://github.com/kovetskiy/sxhkd-vim";
                };
              };
              vim-interestingwords = buildVimPlugin {
                name = "vim-interestingwords";
                src = vim-interestingwords;
                meta = {
                  homepage = "https://github.com/lfv89/vim-interestingwords";
                };
              };
              nvim-lsp-file-operations = buildVimPlugin {
                name = "nvim-lsp-file-operations";
                src = nvim-lsp-file-operations;
                meta = {
                  homepage = "https://github.com/antosha417/nvim-lsp-file-operations";
                };
              };
              nvim-dap-vscode-js = buildVimPlugin {
                name = "nvim-dap-vscode-js";
                src = nvim-dap-vscode-js;
                meta = {
                  homepage = "https://github.com/mxsdev/nvim-dap-vscode-js";
                };
              };
              neotest-playwright = buildVimPlugin {
                name = "neotest-playwright";
                src = neotest-playwright;
                meta = {
                  homepage = "https://github.com/thenbe/neotest-playwright";
                };
              };
              persistent-breakpoints = buildVimPlugin {
                name = "persistent-breakpoints";
                src = persistent-breakpoints;
                meta = {
                  homepage = "https://github.com/Weissle/persistent-breakpoints.nvim";
                };
              };
              smart-semicolon = buildVimPlugin {
                name = "smart-semicolon";
                src = smart-semicolon;
                meta = {
                  homepage = "https://github.com/iagotito/smart-semicolon.nvim";
                };
              };
            };
        }
      );

    };
}
