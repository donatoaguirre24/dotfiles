#!/bin/bash

# Check if dark mode is enabled
if defaults read -g AppleInterfaceStyle &>/dev/null; then
    exec delta --dark "$@"
else
    exec delta --light "$@"
fi
