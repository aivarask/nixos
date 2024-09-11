{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ xcompmgr xdotool xsel xclip sxiv unclutter-xfixes numlockx xautomation xbindkeys ]
    ++ (with pkgs.xorg; [ xbacklight xorgserver xdpyinfo xev xmodmap xmessage transset xwininfo xwd ]);
}
