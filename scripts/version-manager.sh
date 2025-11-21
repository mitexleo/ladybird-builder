#!/bin/bash

# Ladybird Browser Version Manager
# This script helps manage versioning for automated builds

set -e

VERSION_FILE=".github/version.txt"
VERSION_BASE="v1.0"

# Function to get current version
get_current_version() {
    if [[ -f "$VERSION_FILE" ]]; then
        cat "$VERSION_FILE"
    else
        echo "${VERSION_BASE}.0"
    fi
}

# Function to increment version
increment_version() {
    local current_version=$(get_current_version)

    if [[ $current_version =~ ^v([0-9]+)\.([0-9]+)\.([0-9]+)$ ]]; then
        local major=${BASH_REMATCH[1]}
        local minor=${BASH_REMATCH[2]}
        local patch=${BASH_REMATCH[3]}

        local new_patch=$((patch + 1))
        echo "v${major}.${minor}.${new_patch}"
    else
        echo "v1.0.1"
    fi
}

# Function to update version file
update_version() {
    local new_version=$1
    echo "$new_version" > "$VERSION_FILE"
    echo "Updated version to: $new_version"
}

# Function to validate version format
validate_version() {
    local version=$1
    if [[ $version =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        return 0
    else
        return 1
    fi
}

# Function to show usage
usage() {
    cat << EOF
Ladybird Browser Version Manager

Usage: $0 [COMMAND]

Commands:
  current     - Show current version
  next        - Show next version (without updating)
  increment   - Increment version and update file
  set VERSION - Set specific version (format: vX.Y.Z)
  validate VERSION - Validate version format

Examples:
  $0 current
  $0 next
  $0 increment
  $0 set v1.2.3
  $0 validate v1.0.0

EOF
}

# Main script logic
case "${1:-}" in
    current)
        get_current_version
        ;;
    next)
        increment_version
        ;;
    increment)
        new_version=$(increment_version)
        update_version "$new_version"
        ;;
    set)
        if [[ -n "$2" ]]; then
            if validate_version "$2"; then
                update_version "$2"
            else
                echo "Error: Invalid version format. Use vX.Y.Z format."
                exit 1
            fi
        else
            echo "Error: No version specified for set command"
            exit 1
        fi
        ;;
    validate)
        if [[ -n "$2" ]]; then
            if validate_version "$2"; then
                echo "Valid version: $2"
            else
                echo "Invalid version format: $2"
                exit 1
            fi
        else
            echo "Error: No version specified for validate command"
            exit 1
        fi
        ;;
    -h|--help|help)
        usage
        ;;
    *)
        echo "Error: Unknown command '$1'"
        echo
        usage
        exit 1
        ;;
esac
