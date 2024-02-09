{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    vim-log-highlighting # https://github.com/MTDL9/vim-log-highlighting
    {
      plugin = vim-interestingwords; # https://github.com/lfv89/vim-interestingwords
      config = "let g:interestingWordsDefaultMappings = 1";
    }
    vim-highlightedyank
    vim-cursorword
    vim-devicons
    vim-cool
    vim-sensible
    vim-lastplace
    vim-commentary
    {
      plugin = bclose-vim;
      config = ''
        let g:bclose_no_plugin_maps=1
        nnoremap <silent> <M-q> :Bclose<CR>
        nnoremap <M-Q> :Bclose!<CR>
      '';
    }
    {
      plugin = vim-abolish;
      config = ''
        nmap <leader><leader>s :Subvert/<C-r><C-w>//g<Left><Left>
        nmap <leader><leader>S :%Subvert/<C-r><C-w>//g<Left><Left>
      '';
    }
    {
      plugin = vim-floaterm;
      config = ''
        let g:floaterm_autoclose = 2
        let g:floaterm_height = 0.7
        let g:floaterm_width = 0.8
        let g:floaterm_wintype = 'float'
        autocmd VimResized * FloatermUpdate
        if !has('nvim')
          nnoremap <F12> :FloatermToggle<CR>
          tnoremap <F12> <C-W>:FloatermToggle<CR>
        endif
      '';
    }
    {
      plugin = lf-vim;
      config = "let g:lf_map_keys = 0";
    }
    {
      plugin = gruvbox-material;
      config = ''
        if has('termguicolors')
          set termguicolors
        endif
        set background=dark
        let g:gruvbox_material_background = 'medium'
        let g:gruvbox_material_foreground = 'mix'
        colorscheme gruvbox-material
      '';
    }
    {
      plugin = switch-vim; # _switch.vim
      config = ''
        let g:switch_mapping = ""
        nnoremap <silent> <Plug>(SwitchInLine) :<C-U>call SwitchLine(v:count1)<CR>
        nmap <M-s> <Plug>(SwitchInLine)
        imap <M-s> <C-O><M-s>
      '';
    }
    fzf-vim # _fzf.vim
    # vimspector
    vim-matchup
    vim-surround # _surround.vim
    # {
    #   plugin = auto-pairs;
    #   config = ''
    #     let g:AutoPairsFlyMode = 1
    #     let g:AutoPairsShortcutBackInsert = '<C-b>'
    #   '';
    # }
  ];
}
