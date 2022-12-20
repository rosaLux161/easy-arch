# Setting up the network.
pacstrap /mnt networkmanager network-manager-applet firefox
systemctl enable NetworkManager --root=/mnt
