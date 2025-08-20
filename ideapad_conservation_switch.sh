#!/bin/bash

# Define the path to the conservation mode file
CONSERVATION_FILE="/sys/bus/platform/drivers/ideapad_acpi/VPC????\:??/conservation_mode"

# Exit if the file is not found
if [ -z $CONSERVATION_FILE ]; then
    echo "Error: Conservation mode file not found. Your system may not be supported."
    exit 1
fi

# Function to check the current status
check_status() {
    status=$(cat $CONSERVATION_FILE)
    if [ "$status" = "1" ]; then
        echo "Conservation Mode is currently ON (1)"
    elif [ "$status" = "0" ]; then
        echo "Conservation Mode is currently OFF (0)"
    else
        echo "Conservation Mode status is unknown: $status"
    fi
}

# Check for arguments
if [ -z "$1" ]; then
    # No argument, so check the status
    check_status
else
    # An argument was provided
    case "$1" in
        1|on|ON|On|oN)
            echo "Enabling Conservation Mode..."
            echo "1" | sudo tee $CONSERVATION_FILE > /dev/null
            check_status
            ;;
        0|off|OFF|Off|OFf|oFF|oFf|ofF)
            echo "Disabling Conservation Mode..."
            echo "0" | sudo tee $CONSERVATION_FILE > /dev/null
            check_status
            ;;
        *)
            echo "Invalid argument. Usage: $0 [1|on|0|off]"
            exit 1
            ;;
    esac
fi

exit 0
