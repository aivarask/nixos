_: {
  services.cron = {
    enable = false;
    systemCronJobs = [
      "@reboot root . /etc/profile; dig +short myip.opendns.com @resolver1.opendns.com > /tmp/ip"
      "@hourly root . /etc/profile; dig +short myip.opendns.com @resolver1.opendns.com > /tmp/ip"
      "@reboot root . /etc/profile; curl -s wttr.in/Vilnius?format=4 > /tmp/wttr"
      "*/30 * * * * root . /etc/profile; curl -s wttr.in/Vilnius?format=4 > /tmp/wttr"
      "@reboot root DISPLAY=:0 feh --bg-fill --randomize /etc/nixos/misc/wallpapers/abstract/*"
      "*/30 * * * * root DISPLAY=:0 feh --bg-fill --randomize /etc/nixos/misc/wallpapers/abstract/*"
    ];
  };
}
