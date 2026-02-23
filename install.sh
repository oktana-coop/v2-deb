#!/bin/sh
set -e

KEYRING="/etc/apt/keyrings/v2-archive-keyring.gpg"
SOURCES="/etc/apt/sources.list.d/v2.list"
REPO="https://oktana-coop.github.io/v2-deb"

SUDO=""
if [ "$(id -u)" -ne 0 ]; then
  SUDO="sudo"
fi

if ! command -v curl > /dev/null; then
  echo "Error: curl is required. Install it with: ${SUDO:+sudo }apt install curl"
  exit 1
fi

echo "Adding v2 APT repository..."
$SUDO mkdir -p /etc/apt/keyrings
curl -fsSL "$REPO/public.key" | $SUDO tee "$KEYRING" > /dev/null
echo "deb [signed-by=$KEYRING] $REPO stable main" | $SUDO tee "$SOURCES" > /dev/null
$SUDO apt update
$SUDO apt install -y v2
echo "v2 installed successfully."
