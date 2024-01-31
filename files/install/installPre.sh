#!/usr/bin/env bash
set -euo pipefail

# On remote machine
# sudo -i
# systemctl start wpa_supplicant
# wpa_cli
# add_network
# set_network 0 ssid "hw"
# set_network 0 psk "laikinas"
# set_network 0 key_mgmt WPA-PSK or WPA2-PSK
# enable_network 0

# rsync -r /etc/nixos/ ${HOST}:/root --delete --progress
# export HOST=...
# export DISK=/dev/disk/by-id/...

# If fails
# umount -a 2> /dev/null
# zpool destroy zroot

if [ "$DISK" = "" ] || [ "$HOST" = "" ]; then
  echo "DISK or HOST variables are empty"
  exit 1
fi

sgdisk -Z "$DISK"
sgdisk -n3:1M:+512M -t3:EF00 "$DISK"
sgdisk -n1:0:0 -t1:BF01 "$DISK"

sleep 3

echo "Creating a ZFS setup on ${DISK}"
zpool create \
  -f \
  -o ashift=12 \
  -o altroot="/mnt" \
  -O mountpoint=none \
  -O atime=off \
  -O compression=lz4 \
  -O xattr=sa \
  zroot "$DISK"-part1
#-O encryption=aes-256-gcm \
#-O keyformat=passphrase \

zfs create -o mountpoint=legacy zroot/root
zfs create -o mountpoint=legacy zroot/root/nixos
zfs create -o mountpoint=legacy zroot/home

mount -t zfs zroot/root/nixos /mnt
mkdir /mnt/home
mount -t zfs zroot/home /mnt/home

mkfs.vfat "$DISK"-part3
mkdir /mnt/boot
mount "$DISK"-part3 /mnt/boot

mkdir /mnt/etc/nixos -p
nixos-generate-config --root /mnt --force

# cp . /mnt/etc/nixos -r
# nixos-generate-config --root /mnt --show-hardware-config
# echo "!!!DONT FORGET TO CHANGE /boot device /dev/disk/by-uuid"
