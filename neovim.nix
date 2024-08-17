{ pkgs, include, inputs, ... }:
let
  commonPlugins = with pkgs.vimPlugins; [
    fzf-vim
    switch-vim # switch.txt
  ];
in
{
  imports = [ ]
    ++ include ./tdd
    ++ include ./plugin
  ;
  programs.vim = {
    enable = true;
    plugins = commonPlugins ++ (with pkgs.vimPlugins; [
      # h local-additions
      # vim-repeat
      # vim-sensible
      # vim-matchit
      vim-surround
    ]);
    settings = { };
    extraConfig = ''
      let &runtimepath.=',/etc/nixos'
      let g:switch_mapping = ""
      nnoremap <silent> <Plug>(SwitchInLine) :<C-U>call SwitchLine(v:count1)<CR>
      nmap <M-s> <Plug>(SwitchInLine)
      imap <M-s> <C-O><M-s>
    '';
  };
  programs.neovim = {
    enable = true;
    plugins = commonPlugins;
    extraConfig = builtins.concatStringsSep "\n" [
      ''
        let &runtimepath.=',/etc/nixos'
      ''
    ];
    extraLuaConfig = builtins.concatStringsSep "\n" [

    ];
    # package = pkgs.neovim;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = false;
  };
}
