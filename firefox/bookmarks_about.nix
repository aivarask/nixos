# vim: nofoldenable
{
  name = "about";
  toolbar = true;
  bookmarks = [
    {
      name = ":";
      bookmarks = [
        {
          name = ":about";
          url = "about:about";
        }
        {
          name = ":config";
          url = "about:config";
          # tags = [ ":config" ];
        }
        {
          name = ":logins";
          url = "about:logins";
        }
        {
          name = ":policies";
          url = "about:policies#documentation";
        }
        {
          name = ":support";
          url = "about:support";
        }
        {
          name = ":preferences";
          url = "about:preferences";
        }
      ];
    }
  ];
}
