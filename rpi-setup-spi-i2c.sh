#!/bin/bash

# Update package list
sudo apt update

# Install necessary packages
sudo apt install -y spi-tools i2c-tools

# Enable SPI by adding modules to /etc/modules
sudo tee -a /etc/modules << EOF
spi-bcm2835
spi-dev
EOF

# Enable I2C by adding modules to /etc/modules
sudo tee -a /etc/modules << EOF
i2c-dev
EOF

# Comment out the blacklist lines for SPI and I2C
sudo sed -i '/^blacklist spi-bcm2708/s/^/#/' /etc/modprobe.d/raspi-blacklist.conf
sudo sed -i '/^blacklist i2c-bcm2708/s/^/#/' /etc/modprobe.d/raspi-blacklist.conf

read -p "SPI and I2C enabled successfully. Do you want to reboot now? (y/n): " choice
if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
  echo "Rebooting..."
  sleep 3
  sudo reboot
else
  echo "Please reboot your system later to apply the changes."
fi
