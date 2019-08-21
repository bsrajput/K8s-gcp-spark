#!/bin/bash
# Author: Abhishek Anand Amralkar
# This script installs kops

unset CDPATH
CURDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
KOPS_BIN=${KOPS_BIN:-"/usr/local/bin/kops"}
set -e


install_kops() {
    if [ ! -e "$KOPS_BIN"];
    then
        echo "Installing kops..."
        curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64 && sudo chmod +x ./kops && sudo mv ./kops /usr/local/bin/
        echo "Done!"
    else
        echo "kops is installed"
    fi
}

main() {
    install_kops
}

main
