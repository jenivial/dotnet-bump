#!/bin/bash

# Accepts the XML file path as an argument
path="$1"

if [[ ! -f "$path" ]]; then
    echo "File not found!"
    exit 1
fi

# Read the current version from the XML file
currentVersion=$(xmllint --xpath "string(//Project/PropertyGroup/Version)" "$path")

# Split the version string using '.' as delimiter
IFS='.' read -ra splitedVersion <<< "$currentVersion"

# Get the minor version (second to last element of the version string)
minorIndex=$(( ${#splitedVersion[@]} - 2 ))
currentMinorVersion=${splitedVersion[$minorIndex]}

# Increment the minor version
updatedMinorVersion=$(( currentMinorVersion + 1 ))

# Update the version array with the new minor version
splitedVersion[$minorIndex]=$updatedMinorVersion

# Join the version array elements into a new version string
updatedVersion=$(IFS='.'; echo "${splitedVersion[*]}")

# Update the Version in the XML file
xmlstarlet ed --inplace -u "//Project/PropertyGroup/Version" -v "$updatedVersion" "$path"
