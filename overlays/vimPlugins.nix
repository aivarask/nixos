inputs: (self: super:
let
  inherit (super.vimUtils) buildVimPlugin;
in
{
  vimPlugins = with inputs;
    super.vimPlugins
    // {
      vim-log-highlighting = buildVimPlugin {
        name = "vim-log-highlighting";
        src = vim-log-highlighting;
        meta = { homepage = "https://github.com/MTDL9/vim-log-highlighting"; };
      };
      sxhkd-vim = buildVimPlugin {
        name = "sxhkd-vim";
        src = sxhkd-vim;
        meta = { homepage = "https://github.com/kovetskiy/sxhkd-vim"; };
      };
      vim-interestingwords = buildVimPlugin {
        name = "vim-interestingwords";
        src = vim-interestingwords;
        meta = { homepage = "https://github.com/lfv89/vim-interestingwords"; };
      };
      nvim-lsp-file-operations = buildVimPlugin {
        name = "nvim-lsp-file-operations";
        src = nvim-lsp-file-operations;
        meta = { homepage = "https://github.com/antosha417/nvim-lsp-file-operations"; };
      };
      nvim-dap-vscode-js = buildVimPlugin {
        name = "nvim-dap-vscode-js";
        src = nvim-dap-vscode-js;
        meta = { homepage = "https://github.com/mxsdev/nvim-dap-vscode-js"; };
      };
      neotest-playwright = buildVimPlugin {
        name = "neotest-playwright";
        src = neotest-playwright;
        meta = { homepage = "https://github.com/thenbe/neotest-playwright"; };
      };
      persistent-breakpoints = buildVimPlugin {
        name = "persistent-breakpoints";
        src = persistent-breakpoints;
        meta = { homepage = "https://github.com/Weissle/persistent-breakpoints.nvim"; };
      };
    };
})
