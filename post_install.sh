touch /root/log.log

# Setting up timezone.
ln -sf /usr/share/zoneinfo/$(curl -s http://ip-api.com/line?fields=timezone) /etc/localtime &>/dev/null

# Setting up clock.
hwclock --systohc

# Generating locales.
locale-gen &>/dev/null

# Generating a new initramfs.
mkinitcpio -P &>/dev/null >> /root/log.log

# Snapper configuration.
umount /.snapshots
rm -r /.snapshots
snapper --no-dbus -c root create-config /
btrfs subvolume delete /.snapshots &>/dev/null
mkdir /.snapshots
mount -a &>/dev/null
chmod 750 /.snapshots

# Installing systemd-boot.
bootctl --path=/boot install >> /root/log.log

touch /boot/loader/entries/arch.conf
echo "title Arch Linux" >> /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo "initrd /intel-ucode.img" >> /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" >> /boot/loader/entries/arch.conf
echo "options rd.luks.name=$(blkid -s UUID -o value /dev/nvme0n1p2)=cryptroot root=/dev/mapper/cryptroot rootflags=subvol=@ rd.luks.options=discard rw mem_sleep_default=deep >> /boot/loader/entries/arch.conf

touch /boot/loader/loader.conf
echo "default arch" >> /boot/loader/loader.conf

systemctl enable lxdm