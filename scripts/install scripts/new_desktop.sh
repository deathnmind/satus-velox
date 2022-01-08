#! /bin/bash
# a few prerequisite
sudo apt remove docker docker-engine docker.io containerd runc
sudo apt update
sudo apt install apt-transport-https ca-certificates curl gnupg lsb-release -yqq
#
# Get all the Keys
#
# docker
# # from: https://docs.docker.com/engine/install/ubuntu/
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# vivaldi
# from: https://help.vivaldi.com/desktop/install-update/manual-setup-vivaldi-linux-repositories/
#wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add -
#sudo add-apt-repository 'deb https://repo.vivaldi.com/archive/deb/ stable main'
# newer vivaldi install method without apt-key below --
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | gpg --dearmor > packages.vivaldi.gpg
sudo install -o root -g root -m 644 packages.vivaldi.gpg /etc/apt/trusted.gpg.d
sudo sh -c 'echo "deb [arch=amd64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.vivaldi.gpg] https://repo.vivaldi.com/archive/deb stable main" > /etc/apt/sources.list.d/vivaldi.list' 
rm -f packages.vivaldi.gpg
# vscode
# from: https://code.visualstudio.com/docs/setup/linux
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg 
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' 
rm -f packages.microsoft.gpg
#
# Install all the things
#
sudo apt-get update 
# main install line for all the things
sudo apt install openssh-server vivaldi-stable code nmap mmv keepass2 docker-ce docker-ce-cli containerd.io python3-pip gimp kpartx jq -yqq
sudo usermod -aG docker $USER
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
# cleanup
sudo apt autoremove -yqq && sudo apt autoclean -yqq
# added python-pip packages
pip install stormssh
# install vscode extensions
for extensions in hookyqr.beautify streetsidesoftware.code-spell-checker wheredoesyourmindgo.gruvbox-concoctis davidanson.vscode-markdownlint robertrossmann.remedy ms-vscode-remote.remote-ssh ms-vscode-remote.remote-ssh-edit ms-vscode-remote.remote-wsl ms-python.vscode-pylance ms-python.python github.vscode-pull-request-github eamodio.gitlens phplasma.csv-to-table yzhang.markdown-all-in-one mechatroner.rainbow-csv splunk.splunk visualstudioexptteam.vscodeintellicode redhat.vscode-yaml; do code --install-extension $extensions; done;
# start and enable ssh service
sudo systemctl start ssh
sudo systemctl enable ssh
