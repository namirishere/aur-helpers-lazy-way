#!/bin/bash

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

clear
echo -e "${BLUE}==================================================${NC}"
echo -e "${BLUE}          AUR Helper (yay) Installer              ${NC}"
echo -e "${BLUE}==================================================${NC}"
echo "This script will install git, base-devel, and yay."
echo ""
echo "What would you like to do?"
echo -e " [${GREEN}1${NC}] Install the script now"
echo -e " [${YELLOW}2${NC}] View script details / info"
echo -e " [${RED}3${NC}] Exit / Cancel"
echo -e "${BLUE}==================================================${NC}"

read -p "Enter your choice (1-3): " choice

case $choice in
    1)
        echo -e "\n${YELLOW}Starting installation...${NC}"
        sudo pacman -S --needed git base-devel && \
        git clone https://archlinux.org /tmp/yay && \
        cd /tmp/yay && \
        makepkg -si --noconfirm && \
        cd - && \
        rm -rf /tmp/yay

        clear
        echo -e "${GREEN}==================================================${NC}"
        echo -e "${GREEN}      Installation Finished Successfully!         ${NC}"
        echo -e "${GREEN}==================================================${NC}"
        echo ""
        echo "  Thank you everybody for installing our script!"
        echo -e "  ${YELLOW}Contribute to us now.${NC}"
        echo ""
        echo -e "${GREEN}==================================================${NC}"
        ;;
    2)
        echo ""
        echo -e "${BLUE}ℹ️ INFO:${NC} This script automates the compilation of 'yay',"
        echo "a popular Arch User Repository (AUR) helper written in Go."
        echo ""
        read -p "Press [Enter] to return to the menu..."
        exec "$0"
        ;;
    3)
        echo -e "${RED}Installation canceled. Goodbye!${NC}"
        exit 0
        ;;
    *)
        echo -e "${RED}Invalid option. Exiting.${NC}"
        exit 1
        ;;
esac

read -p "Press [Enter] to close..."
