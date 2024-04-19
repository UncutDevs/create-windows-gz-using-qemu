#!/bin/bash

# Check the OS distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
elif type lsb_release >/dev/null 2>&1; then
    OS=$(lsb_release -si)
elif [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    OS=$DISTRIB_ID
elif [ -f /etc/debian_version ]; then
    OS="Debian"
elif [ -f /etc/redhat-release ]; then
    OS=$(cat /etc/redhat-release)
else
    OS=$(uname -s)
fi

# Check if OS is Ubuntu or Debian
if [[ $OS == "Ubuntu" || $OS == "Debian" ]]; then
    # Install updates and required packages
    User
    apt-get update
    apt-get install qemu -y
    apt install qemu-utils -y	 	 
    apt install qemu-system-x86-xen -y
    apt install qemu-system-x86 -y
    apt install qemu-kvm -y

    # Create QEMU IMG for Windows installation
    qemu-img create -f raw windows.img 16G

    # Ask which Windows Server version to download
    echo "Which Windows Server version do you want to download?"
    echo "[1] Windows Server 2019"
    echo "[2] Windows Server 2022"
    echo "[3] Custom URL"
    read -p "Enter your choice: " choice

    case $choice in
        1)
            wget -O windows.iso 'https://software-download.microsoft.com/download/pr/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso'
            ;;
        2)
            wget -O windows.iso 'https://software-static.download.prss.microsoft.com/sg/download/888969d5-f34g-4e03-ac9d-1f9786c66749/SERVER_EVAL_x64FRE_en-us.iso'
            ;;
        3)
            read -p "Enter the custom URL for the Windows ISO: " custom_url
            wget -O windows.iso "$custom_url"
            ;;
        *)
            echo "Invalid choice. Exiting."
            exit 1
            ;;
    esac

    # Download VIRTIO WIN Drivers
    wget -O virtio-win.iso 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.215-1/virtio-win-0.1.215.iso'
else
    echo "Operating system not supported. Please use Ubuntu or Debian."
fi
