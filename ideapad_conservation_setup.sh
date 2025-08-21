#!/bin/bash

# --- Function to check for the existence of files and directories ---
check_existence() {
    for path in "$@"; do
        if [ ! -e "$path" ]; then
            echo "Error: File or directory not found: $path"
            exit 1
        fi
    done
}

# --- Verification of files and directories ---
check_existence /sys/bus/platform/drivers/ideapad_acpi/VPC????\:??/conservation_mode
check_existence /etc/sudoers.d/
#check_existence /etc/modules-load.d/
#check_existence /etc/modules

# --- Check or creation of files ---
echo "Don't forget to replace %sudo with %wheel if needed!"
echo
echo "conservation_mode (0=off,1=on)"
cat /sys/bus/platform/drivers/ideapad_acpi/VPC????\:??/conservation_mode
echo
echo "%sudo ALL=(ALL) NOPASSWD: /usr/bin/tee /sys/bus/platform/drivers/ideapad_acpi/VPC????\:??/conservation_mode" | sudo tee /etc/sudoers.d/ideapad
echo "'ideapad' file created in dir /etc/sudoers.d/"
ls /etc/sudoers.d/
echo
#echo "ideapad_laptop" | sudo tee /etc/modules-load.d/ideapad_laptop.conf
#echo "'ideapad_laptop.conf' file created in dir /etc/modules-load.d/"
#ls /etc/modules-load.d/
#echo "ideapad_laptop" | sudo tee -a /etc/modules
#cat /etc/modules
echo
echo "Setup done"

exit 0
