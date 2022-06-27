{ config, ... }: {
  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/10 * * * *      root    rsync -r --delete /etc/nixos /srv"
      "@reboot            root    . /etc/profile; dig +short myip.opendns.com @resolver1.opendns.com > /etc/nixos/.ip.cache"
      "@hourly * * * *    root    . /etc/profile; dig +short myip.opendns.com @resolver1.opendns.com > /etc/nixos/.ip.cache"
      "@reboot            root    . /etc/profile; curl -s wttr.in/Vilnius?format=4 > /etc/nixos/.weather.cache"
      "*/30 * * * *       root    . /etc/profile; curl -s wttr.in/Vilnius?format=4 > /etc/nixos/.weather.cache"
      "@reboot            root    DISPLAY=:0 feh --bg-fill --randomize /etc/nixos/misc/wallpapers/abstract/*"
      "*/30 * * * *       root    DISPLAY=:0 feh --bg-fill --randomize /etc/nixos/misc/wallpapers/abstract/*"
    ];
  };
}
