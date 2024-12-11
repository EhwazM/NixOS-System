#!/bin/bash

_PartitionsNames=false
while [ "$_PartitionsNames" = false ]; do
    echo "Name your partitions after you created them:"
    read -p "EFI: " _EFI
    read -p "SWAP: " _SWAP
    read -p "FS: " _FS
    echo "Are you sure this is correct? EFI=$_EFI, SWAP=$_SWAP, FS=$_FS. (y/n)"
    read _YesNot1
    
    if [ "$_YesNot1" = "y" ]; then
        echo "Partition names are set."
        _PartitionsNames=true
    elif [ "$_YesNot1" = "n" ]; then
        echo "Restarting the process."
        continue
    else
        echo "Invalid input, please try again."
    fi
done

# Formatting partitions
mkfs.fat -F32 -n "UEFI" /dev/$_EFI
mkswap -L "SWAP" /dev/$_SWAP
swapon /dev/$_SWAP

read -p "root name:" _RootName
mkfs.ext4 -L $_RootName /dev/$_FS

echo "Partitions formatting done."

# Mounting
mount /dev/$_FS /mnt/
mkdir -p /mnt/boot/efi/
mount /dev/$_EFI /mnt/boot/efi/

echo "Partitions mounting done."
read -p "Do you have Laptop?: (y/n)" _YesNot2

if ["$_YesNot2" = "y"]; then
    pacstrap /mnt base base-devel neovim linux-zen linux-zen-headers linux-firmware mkinitcpio xf86-input-libinput
else
    pacstrap /mnt base base-devel neovim linux-zen linux-zen-headers linux-firmware mkinitcpio
fi

genfstab -p /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab

arch-chroot /mnt

nvim /etc/locale.gen
locale-gen
read -p "What locale did you choose?:" _LocaleGen
echo LANG=$_LocaleGen > /etc/locale.conf
export LANG=$_LocaleGen

pacman -Sy

ln -sf /usr/share/zoneinfo/America/Bogota /etc/localtime
hwclock -w

read -p "Kyemap:" _KeyMap
echo KEYMAP=$_KeyMap > /etc/vconsole.conf

read -p "PC Name:" _PCName
echo $_PCName > /etc/hostname

nvim /etc/hosts
# echo 
#     127.0.0.1     localhost
#
#     ::1           localhost
#
#     127.0.1.1     $_PCName.localdomain $PCName > /etc/hosts
#
# passwd

read -p "User Name:" _UserName
useradd -m -g users -G wheel -s /bin/bash $_UserName
passwd $_UserName

nvim /etc/sudoers

pacman -S dhcp dhcpcd networkmanager iwd bluez bluez-utils
systemctl enable dhcpcd NetworkManager
systemctl enable bluetooth

pacman -S grub efibootmgr os-prober
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch
grub-install --target=x86_64-efi --efi-directory=/boot/efi --removable

nvim /etc/default/grub

grub-mkconfig -o /boot/grub/grub.cfg

nvim /etc/pacman.conf
pacman -Syu

pacman -S xdg-user-dirs
xdg-user-dirs-update
su $_UserName -c "xdg-user-dirs-update"
