# Setting up timezone.
ln -sf /usr/share/zoneinfo/$(curl -s http://ip-api.com/line?fields=timezone) /etc/localtime

# Setting up clock.
hwclock --systohc

# Generating locales.
locale-gen

# Generating a new initramfs.
mkinitcpio -P

# Installing systemd-boot.
bootctl --path=/boot install >> /root/log.log

touch /boot/loader/entries/arch.conf
echo "title Arch Linux" >> /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo "initrd /intel-ucode.img" >> /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" >> /boot/loader/entries/arch.conf
echo "options rd.luks.name=$(blkid -s UUID -o value /dev/nvme0n1p2)=cryptroot root=/dev/mapper/cryptroot rootflags=subvol=@ rd.luks.options=discard rw mem_sleep_default=deep" >> /boot/loader/entries/arch.conf

touch /boot/loader/loader.conf
echo "default arch" >> /boot/loader/loader.conf

systemctl enable lxdm
