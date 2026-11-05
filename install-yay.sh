#!/bin/bash

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# STAGE 1: Block running the entire script as root/sudo
if [ "$EUID" -eq 0 ]; then
    echo -e "${RED}Error: Do not run this script with sudo or as root!${NC}"
    echo "The script will ask for your password automatically when needed."
    exit 1
fi

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
        
        # Sync databases and install base development tools cleanly
        sudo pacman -Sy --needed --noconfirm git base-devel
        
        # Clean up any leftover previous failed attempts
        rm -rf /tmp/yay
        
        # Clone and compile under normal user privileges
        git clone https://aur.archlinux.org/yay.git /tmp/yay && \
        cd /tmp/yay && \
        makepkg -si --noconfirm
        
        # Save the exit code of the build process
        BUILD_STATUS=$?
        
        cd - &>/dev/null
        rm -rf /tmp/yay

        # Verification check using the exact path or executable availability
        if [ $BUILD_STATUS -eq 0 ] && command -v yay &> /dev/null; then
            clear
            echo -e "${GREEN}==================================================${NC}"
            echo -e "${GREEN}      Installation Finished Successfully!         ${NC}"
            echo -e "${GREEN}==================================================${NC}"
            echo ""
            echo "  Thank you everybody for installing our script!"
            echo -e "  ${YELLOW}Contribute to us now.${NC}"
            echo ""
            echo -e "${GREEN}==================================================${NC}"
        else
            echo -e "\n${RED}==================================================${NC}"
            echo -e "${RED}              Installation Failed!                ${NC}"
            echo -e "${RED}==================================================${NC}"
            echo ""
            echo "  The compilation or package installation failed."
            echo "  Please look directly above this box to view the log errors."
            echo ""
            echo -e "${RED}==================================================${NC}"
        fi
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
