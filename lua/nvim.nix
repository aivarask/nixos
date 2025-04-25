{ config, ... }:
{
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/lua";
  programs.neovim = {
    enable = true;
    # extraConfig = ''source $XDG_CONFIG_HOME/nvim/init.vim'';
    # extraLuaConfig = ''vim.loader.enable()'';
    vimdiffAlias = true;
    withPython3 = true;
    withNodeJs = true;
    withRuby = false;
  };
  programs.neovim.extraLuaPackages =
    ps: with ps; [
      penlight
      cjson
      http
      cqueues
      luaossl
      basexx
      lpeg
      lpeg_patterns
      binaryheap
      fifo # dep in neovim only
      lua-zlib
      compat53
      # lua-psl
    ];
}
