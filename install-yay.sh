#!/bin/bash

# 1. Install prerequisites, clone yay, build and install it
sudo pacman -S --needed git base-devel && \
git clone https://aur.archlinux.org/yay.git /tmp/yay && \
cd /tmp/yay && \
makepkg -si --noconfirm && \
cd - && \
rm -rf /tmp/yay

# 2. Clear terminal and display the updated thank you screen
clear
echo "=================================================="
echo "      Installation Finished Successfully!         "
echo "=================================================="
echo ""
echo "  Thank you everybody for installing our script!"
echo "  Contribute to us now."
echo ""
echo "=================================================="

# Keep the terminal open so the user can read the message
read -p "Press [Enter] to exit..."
