#!/bin/bash

setup_apt() {
  # setup apt repositories
  echo "Setting up apt repositories..."

  # Steam
  sudo dpkg --add-architecture i386
  sudo add-apt-repository -ys multiverse
  # Fastfetch
  sudo add-apt-repository -ys ppa:zhangsongcui3371/fastfetch
  # Solaar
  sudo add-apt-repository -ys ppa:solaar-unifying/stable
  # System76
  sudo apt-add-repository -ys ppa:system76-dev/stable

  # Add cloudflare gpg key
  #curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
  # Add cloudflare repo to apt repositories
  echo "deb [arch=amd64 trusted=yes] https://pkg.cloudflareclient.com/ jammy main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list

  # update
  sudo apt update
  sudo apt upgrade
  sudo apt dist-upgrade

  # install apt packages
  sudo apt install -y \
    curl \
    cloudflare-warp \
    fastfetch \
    htop \
    krita \
    psensor \
    solaar \
    steam \
    system76-wallpapers
}

setup_snaps() {
  echo "Installing snaps..."
  # Programming
  sudo snap install --classic code
  sudo snap install --classic go
  sudo snap install --classic intellij-idea-community
  sudo snap install --classic pycharm-community
  sudo snap install --classic ruby

  # JetBrains
  sudo snap install --classic clion --channel=2024.1/stable
  sudo snap install --classic datagrip --channel=2024.1/stable
  sudo snap install --classic dataspell --channel=2024.1/stable
  sudo snap install --classic goland --channel=2024.1/stable
  sudo snap install --classic intellij-idea-ultimate --channel=2024.1/stable
  sudo snap install --classic phpstorm --channel=2024.1/stable
  sudo snap install --classic pycharm-professional --channel=2024.1/stable
  sudo snap install --classic rider --channel=2024.1/stable
  sudo snap install --classic rubymine --channel=2024.1/stable
  sudo snap install --classic webstorm --channel=2024.1/stable
}

setup_cloudflare_warp () {
  # CloudFlare WARP client
  echo "Setting up CloudFlare WARP..."
  warp-cli registration delete
  echo y | warp-cli registration new
  warp-cli connect
}


setup_debs() {
  echo "Installing debs..."

  # discord
  #https://discord.com/api/download?platform=linux&format=deb
  curl -sL "https://discord.com/api/download?platform=linux&format=deb" -o /tmp/discord.deb
  sudo dpkg -i /tmp/discord.deb
}

setup_nvm() {
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
}

setup_ui() {
  echo "Setting up UI..."
  lookandfeeltool -a org.kde.breezedark.desktop
}

do_setup() {
  setup_apt
  setup_snaps
  setup_cloudflare_warp
  setup_nvm
  setup_debs
  setup_ui
}


# install
do_setup

