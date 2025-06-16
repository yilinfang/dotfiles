#!/usr/bin/env bash

for encrypted_file in $(chezmoi managed --include encrypted --path-style absolute); do
	# optionally, add --force to avoid prompts
	chezmoi forget "$encrypted_file"

	# strip the .asc extension
	decrypted_file="${encrypted_file%.asc}"

	# Set the permissions of the decrypted file to read/write for the user only
	chmod 600 "$decrypted_file"

	chezmoi add --encrypt "$decrypted_file"
done
