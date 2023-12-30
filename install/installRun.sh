#!/usr/bin/env bash
set -euo pipefail

nix-shell -p git nixFlakes --run "nixos-install --root /mnt --flake /mnt/etc/nixos#${HOST}"
