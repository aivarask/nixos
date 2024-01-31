{ ... }: {
  programs.pistol = {
    enable = true;
    associations = [
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
      {
        mime = "inode/directory";
        command = "eza --git --group --tree --level=1 --long --icons --group-directories-first %pistol-filename%";
      }
    ];
  };
}
