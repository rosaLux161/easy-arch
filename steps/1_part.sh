DISK=/dev/nvme0n1
BTRFS="/dev/mapper/cryptroot"
ESP="/dev/disk/by-partlabel/ESP"
cryptroot="/dev/disk/by-partlabel/cryptroot"
subvols=(snapshots var_pkgs var_log home root srv)

wipefs -af "$DISK"
sgdisk -Zo "$DISK"

# Creating a new partition scheme.
parted -s "$DISK" \
    mklabel gpt \
    mkpart ESP fat32 1MiB 513MiB \
    set 1 esp on \
    mkpart cryptroot 513MiB 100% \

# Informing the Kernel of the changes.
partprobe "$DISK"

# Formatting the ESP as FAT32.
mkfs.fat -F 32 "$ESP"

# Creating a LUKS Container for the root partition.
echo -n "1234" | cryptsetup luksFormat "$cryptroot" -d - 
echo -n "1234" | cryptsetup open "$cryptroot" cryptroot -d - 

# Formatting the LUKS Container as BTRFS.
mkfs.btrfs "$BTRFS"
mount "$BTRFS" /mnt

# Creating BTRFS subvolumes.
for subvol in '' "${subvols[@]}"; do
    btrfs su cr /mnt/@"$subvol"
done

# Unmount the newly created subvolumes.
umount /mnt

cryptsetup luksClose cryptroot
