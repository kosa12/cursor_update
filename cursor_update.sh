#!/bin/bash

# Set installation directory, app name, and download URL
INSTALL_DIR="$HOME/opt"
APP_NAME="Cursor"
APP_URL="https://downloader.cursor.sh/linux/appImage/x64"
USER_AGENT="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"

# Ensure curl is installed
if ! command -v curl &> /dev/null; then
    echo "Error: curl is required. Please install curl and try again."
    exit 1
fi

# Create install directory with permissions
mkdir -p "$INSTALL_DIR" || { echo "Error: Failed to create directory $INSTALL_DIR"; exit 1; }

existing_file=$(ls "$INSTALL_DIR"/*.AppImage 2>/dev/null | head -n 1)

echo -e "\n> Fetching the latest version of Cursor...\n"

# Download latest version of Cursor
latest_file="$INSTALL_DIR/cursor-latest.AppImage"
curl -L -A "$USER_AGENT" -o "$latest_file" "$APP_URL" || { echo "Error: Failed to download Cursor."; exit 1; }

if [[ -f "$latest_file" && -s "$latest_file" ]]; then
    echo "> Download complete."

    if [[ "$existing_file" ]] && cmp -s "$existing_file" "$latest_file"; then
        echo -e "\n> Already up to date. No new version available."
        rm "$latest_file"
        exit 0
    fi

    chmod +x "$latest_file"
    [[ "$existing_file" ]] && rm "$existing_file"
    mv "$latest_file" "$INSTALL_DIR/cursor.AppImage"
    echo -e "\n> Cursor has been updated successfully."

    echo -e "\n> Updating desktop entry..."
    icon_path="/opt/cursor.png"
    desktop_file="/usr/share/applications/$APP_NAME.desktop"

    if [[ ! -f "$icon_path" ]]; then
        sudo mkdir -p "$(dirname "$icon_path")"
        sudo curl -L -A "$USER_AGENT" -o "$icon_path" "https://www.cursor.so/brand/icon.svg"
    fi

    # Create or update desktop entry
    cat <<EOF | sudo tee "$desktop_file" > /dev/null
[Desktop Entry]
Name=Cursor
Exec=$INSTALL_DIR/cursor.AppImage
Terminal=false
Type=Application
Icon=$icon_path
StartupWMClass=Cursor
X-AppImage-Version=latest
Comment=Cursor is an AI-first coding environment.
MimeType=x-scheme-handler/cursor;
Categories=Utility;Development
EOF

    sudo chmod +x "$desktop_file"
    echo -e "\n> Desktop entry updated successfully. You can launch Cursor from your application menu."
else
    echo "Error: Failed to download Cursor. Please check your internet connection or try again."
    exit 1
fi
