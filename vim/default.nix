{ config, pkgs, lib, ... }:
let
  pluginGit = ref: repo:
    pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        inherit ref;
      };
    };
  plugin = pluginGit "HEAD";
  vimPlugins = with pkgs.vimPlugins; [
    vim-devicons
    vim-hexokinase

    context_filetype-vim
    vim-cool
    vim-sensible
    vim-lastplace
    bclose-vim
    vim-commentary
    # auto-pairs
    vim-fugitive
    fugitive-gitlab-vim
    vim-autoformat
    vim-surround
    vim-expand-region
    vim-gitgutter
    vim-gutentags
    vim-floaterm
    fzf-vim

    lf-vim
    nerdtree
    vim-gruvbox8
    gruvbox-material
    nord-nvim
    onedark-vim
    vim-colors-solarized
    vim-monokai
    tokyonight-nvim
    nightfox-nvim
    # vim-airline
    # vim-airline-themes
    vim-highlightedyank

    # lightline-vim
    # lightline-bufferline
    # nvim-lightline-lsp
    # lightline-gruvbox-vim

    neoformat
    vim-pug

    vim-nix
    nim-vim
    vim-toml
    vim-yaml
    vim-json
    switch-vim
    vim-jsx-pretty
    lspkind-nvim
    vim-test
    vim-prisma
    # direnv-vim
    vim-matchup
    vim-auto-save
  ];
  nvimPlugins = with pkgs.vimPlugins; [
    # TOOLS:

    SchemaStore-nvim

    lualine-nvim
    lualine-lsp-progress
    tabline-nvim

    toggleterm-nvim
    todo-comments-nvim
    nvim-autopairs
    nvim-web-devicons
    plenary-nvim
    lazygit-nvim
    # UI:
    # bufferline-nvim
    neoscroll-nvim
    nvim-tree-lua
    nvim-colorizer-lua
    gitsigns-nvim
    # LSP:
    nvim-lspconfig
    nvim-lsp-ts-utils # NEW:
    nvim-ts-autotag
    nvim-treesitter-textobjects
    # nvim-treesitter-textsubjects
    null-ls-nvim
    symbols-outline-nvim
    # COMPLETION:
    # https://github.com/hrsh7th
    # ./lua/compl.lua
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    cmp-cmdline
    cmp-emoji
    cmp-treesitter
    nvim-cmp
    # VSNIP:
    cmp-vsnip
    vim-vsnip
    vim-vsnip-integ
    friendly-snippets # https://github.com/rafamadriz/friendly-snippets
    # LUSNIP:
    luasnip # https://github.com/L3MON4D3/LuaSnip
    cmp_luasnip # https://github.com/saadparwaiz1/cmp_luasnip
    # DEBUG:
    # ./lua/dmap.lua
    vimspector
    nvim-dap
    nvim-dap-ui
    nvim-dap-virtual-text

    telescope-nvim
    telescope-dap-nvim
    telescope-fzy-native-nvim
    # telescope-cheat-nvim
    telescope-symbols-nvim


    # TREE_SITTER:
    nvim-treesitter
    nvim-ts-context-commentstring
    nvim-ts-rainbow
  ];
in
{

  xdg.configFile."nvim/parser/bash.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-bash}/parser";
  xdg.configFile."nvim/parser/c-sharp.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-c-sharp}/parser";
  xdg.configFile."nvim/parser/c.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-c}/parser";
  xdg.configFile."nvim/parser/comment.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-comment}/parser";
  xdg.configFile."nvim/parser/cpp.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-cpp}/parser";
  xdg.configFile."nvim/parser/css.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-css}/parser";
  xdg.configFile."nvim/parser/dart.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-dart}/parser";
  xdg.configFile."nvim/parser/dockerfile.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-dockerfile}/parser";
  xdg.configFile."nvim/parser/elm.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-elm}/parser";
  xdg.configFile."nvim/parser/fish.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-fish}/parser";
  xdg.configFile."nvim/parser/go.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-go}/parser";
  xdg.configFile."nvim/parser/graphql.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-graphql}/parser";
  xdg.configFile."nvim/parser/haskell.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-haskell}/parser";
  xdg.configFile."nvim/parser/html.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-html}/parser";
  xdg.configFile."nvim/parser/http.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-http}/parser";
  xdg.configFile."nvim/parser/java.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-java}/parser";
  xdg.configFile."nvim/parser/javascript.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-javascript}/parser";
  xdg.configFile."nvim/parser/jsdoc.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-jsdoc}/parser";
  xdg.configFile."nvim/parser/json.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-json}/parser";
  xdg.configFile."nvim/parser/json5.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-json5}/parser";
  xdg.configFile."nvim/parser/lua.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-lua}/parser";
  xdg.configFile."nvim/parser/make.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-make}/parser";
  xdg.configFile."nvim/parser/markdown.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-markdown}/parser";
  xdg.configFile."nvim/parser/nix.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-nix}/parser";
  xdg.configFile."nvim/parser/perl.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-perl}/parser";
  xdg.configFile."nvim/parser/php.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-php}/parser";
  xdg.configFile."nvim/parser/python.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-python}/parser";
  xdg.configFile."nvim/parser/ql.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-ql}/parser";
  xdg.configFile."nvim/parser/query.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-query}/parser";
  xdg.configFile."nvim/parser/regex.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-regex}/parser";
  xdg.configFile."nvim/parser/rst.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-rst}/parser";
  xdg.configFile."nvim/parser/ruby.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-ruby}/parser";
  xdg.configFile."nvim/parser/rust.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-rust}/parser";
  xdg.configFile."nvim/parser/scss.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-scss}/parser";
  xdg.configFile."nvim/parser/svelte.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-svelte}/parser";
  # xdg.configFile."nvim/parser/swift.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-swift}/parser";
  xdg.configFile."nvim/parser/toml.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-toml}/parser";
  xdg.configFile."nvim/parser/tsx.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-tsx}/parser";
  xdg.configFile."nvim/parser/typescript.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-typescript}/parser";
  xdg.configFile."nvim/parser/vue.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-vue}/parser";
  xdg.configFile."nvim/parser/yaml.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-yaml}/parser";

  home.file.".vim/coc-settings.json".source = ./coc-settings.json;
  programs.vim = {
    enable = true;
    plugins = vimPlugins ++ import ./cocPlugins.nix pkgs;
    extraConfig = ''
      source /etc/nixos/vim/vimrc.vim
    '';
  };
  programs.neovim = {
    enable = true;
    extraConfig = builtins.concatStringsSep "\n" [
      ''
        lua << EOF
        dofile("/etc/nixos/vim/init.lua")
        EOF
      ''
    ];
    extraPackages = with pkgs; [ ];
    package = pkgs.neovim-nightly;
    plugins = vimPlugins ++ nvimPlugins;
    viAlias = true;
    vimAlias = false;
    vimdiffAlias = true;
    withNodeJs = true;
    # withPython2 = true;
    withPython3 = true;
    withRuby = true;
  };
}
