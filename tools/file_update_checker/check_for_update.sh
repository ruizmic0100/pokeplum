#!/bin/bash

# Specify the path to the file you want to monitor
file_path="./pokeemerald.gba"

# Specify the path to store the has (you can use a ahidden file in the same directory)
hash_file="./tools/file_update_checker/.pokeemeraldhashfile"

# Funcion to calculate the MD5 hash of the file
calculate_hash() {
    md5sum "$1" | awk '{print $1}'
}

# Check if the hash file exists
if [ -e "$hash_file" ]; then
    # Read the stored hash
    stored_hash=$(cat "$hash_file")

    # Calculate the current hash
    current_hash=$(calculate_hash "$file_path")

    # Compare the hashes
    if [ "$stored_hash" = "$current_hash" ]; then
        echo "File has not changed."
    else
        echo "File has changed."
        # Update the stored hash
        echo "$current_hash" > "$hash_file"
    fi
else
    # If the hash file doesn't exist, create it and store the initial hash
    calculate_hash "$file_path" > "$hash_file"
    echo "Initial hash has been recorded."
fi