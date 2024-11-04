# Cursor Installation Script for Arch Linux

This script automates the installation and updating of the Cursor application on your Arch Linux system. It downloads the latest version of the Cursor AppImage, makes it executable, and creates a desktop entry for easy access from your application menu.

## Features

- Automatically fetches the latest version of Cursor.
- Checks for existing installations and updates if a new version is available.
- Creates a desktop entry for easy access.
- Downloads the application icon if not already present.

## Prerequisites

- **Arch Linux**: This script is designed for Arch Linux systems.
- **Curl**: The script requires `curl` to download files. If you don't have `curl` installed, you can install it using the following command:
  ```bash
  sudo pacman -S curl


## Installation Instructions

Follow these steps to install or update the Cursor application on your Arch Linux system:

1. **Clone the Repository** (if applicable) or download the script directly:
   ```bash
   git clone https://github.com/kosa12/cursor_update
   cd https://github.com/kosa12/cursor_update

2. **Make the Script Executable**: Open a terminal and run the following command to make the installation script executable:

    ```bash
    chmod +x cursor_update.sh

3. **Run the script**: Execute the script to install or update Cursor:
    ```bash
    ./cursor_update.sh

4. **Launch Cursor**: In the application menu on your computer should be the Cursor program now