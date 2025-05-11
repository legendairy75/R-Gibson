#!/bin/bash

pkgs=(
  kitty
  zsh
  tmux
  neovim
  node
  bat
  btop
  eza
  git
  wget
  sway
  fastfetch
)
for pkg in ${pkgs[@]}; do
  sudo dnf -y install ${pkg}
done

# oh my zsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# oh my posh
curl -s https://ohmyposh.dev/install.sh | bash -s

# nerdfont
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/0xProto.zip &&
  cd ~/.local/share/fonts &&
  unzip 0xProto.zip &&
  rm 0xProto.zip &&
  fc-cache -fv

# lazyvim
git clone https://github.com/LazyVim/starter ~/.config/nvim

rm -rf ~/.config/nvim/.git

# vs code

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo >/dev/null

dnf check-update
sudo dnf install code # or code-insiders

# pnpm
sudo npm install -g pnpm@latest-10

# yazi
sudo dnf copr enable lihaohong/yazi
sudo dnf install yazi
