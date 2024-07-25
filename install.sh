#!/bin/bash

INSTALL_DIR="/usr/lib/cursor-chat-export"
SCRIPT_NAME="cursor-chat-export"

# Function to check if Python is installed
check_python() {
    if ! command -v python3 &> /dev/null; then
        echo "Error: Python 3 is not installed. Please install Python 3 and try again."
        exit 1
    fi
}

# Function to install dependencies
install_dependencies() {
    pip3 install -r requirements.txt --break-system-packages
}

# Function to create the installation directory and copy files
create_install_dir() {
    sudo mkdir -p "$INSTALL_DIR"
    sudo cp -r chat.py src/ config.yml README.md "$INSTALL_DIR"
}

# Function to create the wrapper script
create_wrapper_script() {
    sudo tee "/usr/bin/$SCRIPT_NAME" > /dev/null << EOF
#!/bin/bash
python3 $INSTALL_DIR/chat.py "\$@"
EOF
    sudo chmod +x "/usr/bin/$SCRIPT_NAME"
}

# Main installation process
main() {
    check_python
    install_dependencies
    create_install_dir
    create_wrapper_script
    echo "cursor-chat-export has been successfully installed!"
}

main