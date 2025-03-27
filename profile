# vim: ft=sh
# sed -i -E 's/^(ENABLED\s*=\s*)1$/\10/; t; s/^(ENABLED\s*=\s*)0$/\11/' profile
# ENABLED=1
export __ETC_PROFILE_SOURCED=
export __ETC_PROFILE_DONE=

export A=7

export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --info=inline"

# export CPATH=/run/current-systems/sw/include
# export C_INCLUDE_PATH=/run/current-systems/sw/include
export MPV_HOME=/etc/nixos/mpv
export WEZTERM_CONFIG_FILE=/etc/nixos/term/wezterm.lua

