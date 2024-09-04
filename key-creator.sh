#!/bin/bash

# Check if the user provided enough arguments (uniqueIdentifier and email)
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Error: Missing arguments."
  echo "Usage: $0 <uniqueIdentifier> <email>"
  exit 1
fi

# Set the uniqueIdentifier and email variables from the input arguments
uniqueIdentifier="$1"
email="$2"

# Step 1: Generate the SSH key pair with ed25519 encryption
ssh-keygen -t ed25519 -C "$email" -N "" -f "$HOME/.ssh/$uniqueIdentifier"

# Step 2: Start the SSH agent if it's not already running
eval "$(ssh-agent -s)"

# Step 3: Add the generated SSH private key to the agent
ssh-add "$HOME/.ssh/$uniqueIdentifier"

# Step 4: Output the public key (so you can manually add it to GitHub)
echo "Your public key (add this to your GitHub SSH keys):"
cat "$HOME/.ssh/$uniqueIdentifier.pub"

# Step 5: Configure SSH config file for GitHub
sshConfigFile="$HOME/.ssh/config"

# Backup the SSH config file if it exists
if [ -f "$sshConfigFile" ]; then
  cp "$sshConfigFile" "$sshConfigFile.bak"
fi

# Check if the SSH config file already exists and is not empty
if [ -s "$sshConfigFile" ]; then
  # If the file exists and is not empty, add a new line before appending the new Host block
  echo "" >> "$sshConfigFile"
fi

# Append the new SSH configuration for the uniqueIdentifier host
echo "Host $uniqueIdentifier" >> "$sshConfigFile"
echo "    Hostname github.com" >> "$sshConfigFile"
echo "    IdentityFile ~/.ssh/$uniqueIdentifier" >> "$sshConfigFile"
echo "SSH configuration updated. You can now use 'git' with your new SSH key."

echo "Done! You have generated an SSH key with identifier '$uniqueIdentifier' and email '$email', and your SSH config has been updated."
