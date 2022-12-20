DISK=/dev/nvme0n1
locale="en_US.UTF-8"
BTRFS="/dev/mapper/cryptroot"
ESP="/dev/disk/by-partlabel/ESP"
cryptroot="/dev/disk/by-partlabel/cryptroot"

# Setting up keyboard layout.
loadkeys de-latin1-nodeadkeys

# Pacstrap (setting up a base sytem onto the new root).
#pacman-key --refresh-keys
pacstrap /mnt base linux intel-ucode base-devel linux-firmware linux-headers btrfs-progs rsync efibootmgr snapper reflector snap-pac zram-generator sudo xfce4 lxdm-gtk3 git &>/dev/null
