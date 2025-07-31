#!/bin/sh
set -e

# Create the directory for global npm packages
mkdir -p ~/.npm-global

# Configure npm to use the new directory
npm config set prefix '~/.npm-global'