_: {
  programs.ncmpcpp = {
    enable = true;
    settings = {
      # https://github.com/ncmpcpp/ncmpcpp/blob/master/doc/config
      # https://raw.githubusercontent.com/ncmpcpp/ncmpcpp/master/doc/config
      mpd_music_dir = "/var/music";

      ###
      "user_interface" = "alternative";
      "alternative_header_first_line_format" = "$b$5«« {%a}|{%t} »»$9$/b";
      alternative_header_second_line_format = "$b$5 {%b}|{%f} {%b} ({%y})$9$/b";
      song_columns_list_format = "(40)[blue]{a|f} (40)[green]{tE} (20)[blue]{bE}";

      ###
      display_bitrate = "yes";
      playlist_show_mpd_host = "no";
      allow_for_physical_item_deletion = "yes";
      connected_message_on_startup = "no";
    };
  };
}
