{ config, ... }: {
  # https://github.com/doronbehar/pistol
  xdg.configFile."pistol/pistol.conf".text = ''
    inode/directory exa --git --group --tree --level=1 --long --icons --group-directories-first %pistol-filename%
    text/* bat --color=always --style=plain --pager=never %pistol-filename%
    application/* bat --color=always --style=plain --pager=never %pistol-filename%
    image/* chafa %pistol-filename%
    # application/json sh: jq '.' %pistol-filename%
    application/pdf zathura %pistol-filename%
    text/html w3m -T text/html -dump %pistol-filename%
  '';
}
