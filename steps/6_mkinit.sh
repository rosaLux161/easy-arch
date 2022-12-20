# Configuring /etc/mkinitcpio.conf.
cat > /mnt/etc/mkinitcpio.conf <<EOF
HOOKS=(base systemd autodetect keyboard sd-vconsole modconf kms block sd-encrypt filesystems fsck)
EOF
