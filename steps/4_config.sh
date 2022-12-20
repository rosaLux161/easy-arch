locale="en_US.UTF-8"

# Setting up the hostname.
echo host01 > /mnt/etc/hostname

# Generating /etc/fstab.
genfstab -U /mnt >> /mnt/etc/fstab

# Configure selected locale and console keymap
sed -i "/^#$locale/s/^#//" /mnt/etc/locale.gen
echo "LANG=$locale" > /mnt/etc/locale.conf
echo "KEYMAP=$kblayout" > /mnt/etc/vconsole.conf

# Setting hosts file.
cat > /mnt/etc/hosts <<EOF
127.0.0.1   localhost
::1         localhost
127.0.1.1   host01.localdomain   host01
EOF

cp 8_chroot_install.sh /mnt/root/8_chroot_install.sh
