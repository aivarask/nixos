{ ... }:
{
  # home.shellAliases.pistol = "pistol -c /etc/nixos/config/programs_/pistol.conf";
  programs.pistol = {
    enable = true;
    associations = [
      {
        mime = "inode/directory";
        command = "eza --tree --level=3 --group --group-directories-first %pistol-filename%";
      }
      {
        mime = "application/json";
        command = "sh: jq '.' %pistol-filename% -C";
      }
      {
        mime = "application/pdf";
        command = "zathura %pistol-filename%";
      }
      {
        mime = "application/*";
        command = "bat --color=always --style=plain --pager=never %pistol-filename%";
      }
      {
        fpath = ".*.md$";
        command = "sh: bat --paging=never --color=always %pistol-filename% | head -8";
      }
      {
        mime = "text/html";
        command = "w3m -T text/html -dump_source %pistol-filename%";
      }
      {
        mime = "text/*";
        command = "bat --color=always --style=plain --pager=never %pistol-filename%";
      }
      {
        mime = "image/*";
        command = "chafa %pistol-filename%";
      }
    ];
  };
}
