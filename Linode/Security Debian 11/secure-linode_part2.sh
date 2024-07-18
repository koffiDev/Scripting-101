#!/bin/bash

# Create .ssh directory and set permissions
mkdir -p ~/.ssh
chmod -R 700 ~/.ssh/

echo "Please run the following command on your local computer to copy your SSH public key to the server:"
echo "scp ~/.ssh/id_rsa.pub $USER@$(hostname -I | awk '{print $1}'):~/.ssh/authorized_keys"

echo "After copying the SSH key, run this script again."

read -p "Press Enter to continue after copying the SSH key..."

# Set permissions for the public key directory and the key file itself
chmod 600 ~/.ssh/authorized_keys

# Edit SSH configuration file to disallow root login and disable password authentication
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config
sudo sed -i 's/#AddressFamily any/AddressFamily inet/' /etc/ssh/sshd_config

# Restart SSH service to apply changes
sudo systemctl restart sshd

echo "SSH hardening is complete!"

