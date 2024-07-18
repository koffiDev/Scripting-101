#!/bin/bash

# Update and upgrade system packages
echo "Updating and upgrading system packages..."
apt update && apt upgrade -y

# Set the timezone
echo "Setting timezone..."
read -p "Enter the desired timezone (e.g., America/New_York): " timezone
timedatectl set-timezone "$timezone"

# Check the time
echo "Checking the current time..."
date

# Configure a custom hostname
read -p "Enter the desired hostname: " hostname
hostnamectl set-hostname "$hostname"
echo "127.0.0.1    localhost" > /etc/hosts
echo "127.0.1.1    $hostname" >> /etc/hosts

# Add a limited user account with sudo privileges
read -p "Enter the username for the new limited user: " username
adduser "$username"
usermod -aG sudo "$username"

echo "Basic Linode security setup part 1 is complete!"

