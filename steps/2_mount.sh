DISK=/dev/nvme0n1
locale="en_US.UTF-8"
BTRFS="/dev/mapper/cryptroot"
ESP="/dev/disk/by-partlabel/ESP"
cryptroot="/dev/disk/by-partlabel/cryptroot"
subvols=(snapshots var_pkgs var_log home root srv)

# Setting up keyboard layout.
loadkeys de-latin1-nodeadkeys

# Mounting the newly created subvolumes.
mountopts="ssd,noatime,compress-force=zstd:3,discard=async"
mount -o "$mountopts",subvol=@ "$BTRFS" /mnt
mkdir -p /mnt/{home,root,srv,.snapshots,var/{log,cache/pacman/pkg},boot}
for subvol in "${subvols[@]:2}"; do
    mount -o "$mountopts",subvol=@"$subvol" "$BTRFS" /mnt/"${subvol//_//}"
done
chmod 750 /mnt/root
mount -o "$mountopts",subvol=@snapshots "$BTRFS" /mnt/.snapshots
mount -o "$mountopts",subvol=@var_pkgs "$BTRFS" /mnt/var/cache/pacman/pkg
chattr +C /mnt/var/log
mount "$ESP" /mnt/boot/
