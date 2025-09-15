#!bin/bash
sudo dnf update
sudo dnf -y install ${web_package}
sudo systemctl enable ${web_package} --now