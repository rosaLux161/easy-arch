touch /root/log.log

# Installing AUR packages
git clone https://aur.archlinux.org/yay-bin.git > /root/log.log
chown -R nobody yay-bin >> /root/log.log
cd yay-bin >> /root/log.log
sudo -u nobody makepkg >> /root/log.log
cd .. >> /root/log.log
pacman -U yay-bin/*.tar.zst >> /root/log.log

git clone https://aur.archlinux.org/plymouth.git >> /root/log.log
chown -R nobody plymouth >> /root/log.log
cd plymouth >> /root/log.log
sudo -u nobody makepkg >> /root/log.log
cd .. >> /root/log.log
pacman -U plymouth/*.tar.zst >> /root/log.log

git clone https://aur.archlinux.org/plymouth-theme-arch-charge.git >> /root/log.log
chown -R nobody plymouth-theme-arch-charge >> /root/log.log
cd plymouth-theme-arch-charge >> /root/log.log
sudo -u nobody makepkg >> /root/log.log
cd .. >> /root/log.log
pacman -U plymouth-theme-arch-charge/*.tar.zst >> /root/log.log

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
echo "options rd.luks.name=$(blkid -s UUID -o value /dev/nvme0n1p2)=cryptroot root=/dev/mapper/cryptroot rootflags=subvol=@ rd.luks.options=discard rw mem_sleep_default=deep quiet splash loglevel=3 rd.udev.log_priority=3 vt.global_cursor_default=0" >> /boot/loader/entries/arch.conf

touch /boot/loader/loader.conf
echo "default arch" >> /boot/loader/loader.conf

xfconf-query -c xsettings -p /Gdk/WindowScalingFactor -s 2
xfconf-query -c xfwm4 -p /general/theme -s Default-xhdpi

systemctl enable lxdm