#!/usr/bin/env bash

# Remove current age key if it exists
chezmoi forget ~/.age

# Remove the old age key file if it exists
rm -rf ~/.age
mkdir -p ~/.age

# Generate a new age key and save it to ~/.age/key.txt.age
age-keygen | age -a -p >~/.age/key.txt.age

# Add the new age key to chezmoi
chezmoi add ~/.age
