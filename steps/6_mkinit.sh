DISK=/dev/nvme0n1
locale="en_US.UTF-8"
BTRFS="/dev/mapper/cryptroot"
ESP="/dev/disk/by-partlabel/ESP"
cryptroot="/dev/disk/by-partlabel/cryptroot"

# Setting up keyboard layout.
loadkeys de-latin1-nodeadkeys

# Configuring /etc/mkinitcpio.conf.
cat > /mnt/etc/mkinitcpio.conf <<EOF
HOOKS=(base systemd autodetect keyboard sd-vconsole modconf kms block sd-encrypt filesystems fsck)
EOF
