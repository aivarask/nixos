{
  name = "about";
  toolbar = true;
  bookmarks = [
    {
      name = ":";
      bookmarks = [
        {
          name = "searchfox.org";
          tags = [
            "ff"
            "sf"
          ];
          url = "https://searchfox.org/mozilla-central/search?q=typeahead&path=&case=false&regexp=false";
        }
        {
          name = ":about";
          url = "about:about";
        }
        {
          name = ":addons";
          url = "about:addons";
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
          url = "about:policies";
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
