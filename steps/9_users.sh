DISK=/dev/nvme0n1
locale="en_US.UTF-8"
BTRFS="/dev/mapper/cryptroot"
ESP="/dev/disk/by-partlabel/ESP"
cryptroot="/dev/disk/by-partlabel/cryptroot"

# Setting up keyboard layout.
loadkeys de-latin1-nodeadkeys

# Setting root password.
info_print "Setting root password."
echo "root:1234" | arch-chroot /mnt chpasswd

# Setting user password.
echo "%wheel ALL=(ALL:ALL) ALL" > /mnt/etc/sudoers.d/wheel
info_print "Adding the user jan to the system with root privilege."
arch-chroot /mnt useradd -m -G wheel -s /bin/bash jan
info_print "Setting user password for jan."
echo "jan:1234" | arch-chroot /mnt chpasswd
