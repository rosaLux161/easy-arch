# Setting root password.
echo "root:1234" | arch-chroot /mnt chpasswd

# Setting user password.
echo "%wheel ALL=(ALL:ALL) ALL" > /mnt/etc/sudoers.d/wheel
arch-chroot /mnt useradd -m -G wheel -s /bin/bash jan
echo "jan:1234" | arch-chroot /mnt chpasswd
