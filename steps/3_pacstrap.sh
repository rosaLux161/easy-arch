# Pacstrap (setting up a base sytem onto the new root).
pacman-key --refresh-keys
pacstrap /mnt base linux intel-ucode base-devel linux-firmware linux-headers btrfs-progs rsync efibootmgr snapper reflector snap-pac zram-generator sudo xfce4 lxdm-gtk3 pipewire-jack git
