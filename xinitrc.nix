{ config, ... }: {
  home.file.".xinitrc".text = ''
    # https://www.iodocs.com/how-to-enable-gpu-fan-settings-nvidia-in-linux/
    nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:0]/GPUTargetFanSpeed=40' --load-config-only;

    numlockx
    xset r rate 200 50

    unclutter &
    redshift &
    dunst &
    slstatus &
    sxhkd &
    imwheel -b 45 &

    XDG_SESSION_TYPE=x11 remote-touchpad -bind :9000 -secret pc &
    ssh-chat --bind 2022 &
    # wetty -b / -p 9999 &

    # sudo systemctl restart cron.service

    exec dwm;
  '';

}
