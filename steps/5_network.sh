DISK=/dev/nvme0n1
locale="en_US.UTF-8"
BTRFS="/dev/mapper/cryptroot"
ESP="/dev/disk/by-partlabel/ESP"
cryptroot="/dev/disk/by-partlabel/cryptroot"

# Setting up keyboard layout.
loadkeys de-latin1-nodeadkeys


# Setting up the network.
pacstrap /mnt networkmanager network-manager-applet firefox >/dev/null
systemctl enable NetworkManager --root=/mnt &>/dev/null
