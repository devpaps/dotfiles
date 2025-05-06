#!/bin/bash

case "$1" in
  "personal")
    git config --global user.name "Lars Jönsson"
    git config --global user.email "crymeat@gmail.com"
    echo "Switching to devpaps git account..."

    # Make devpaps active GitHub CLI account
    gh auth status | grep "devpaps" > /dev/null
    if [ $? -eq 0 ]; then
      gh auth switch -h github.com -u devpaps
    else
      echo "devpaps not logged in via gh. Logging in..."
      gh auth login --hostname github.com
    fi
    ;;
  "work")
    git config --global user.name "Lars Jönsson"
    git config --global user.email "info@noveris.se"
    echo "Switching to Noveris git account..."

    # Make noveris-hq active GitHub CLI account
    gh auth status | grep "noveris-hq" > /dev/null
    if [ $? -eq 0 ]; then
      gh auth switch -h github.com -u noveris-hq
    else
      echo "noveris-hq not logged in via gh. Logging in..."
      gh auth login --hostname github.com
    fi
    ;;
  *)
    echo "Usage: $0 {personal|work}"
    exit 1
    ;;
esac

# Show current Git user configuration
echo -e "\nCurrent Git configuration:"
echo "Name:  $(git config --global user.name)"
echo "Email: $(git config --global user.email)"

