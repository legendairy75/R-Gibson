#!/bin/bash

sudo dnf update

pkgs=(
  kitty
  zsh
  tmux
  neovim
  bat
  btop
  eza
  git
  wget
  # sway
  fastfetch
  curl
  stow
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

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# vfox
brew install vfox

# github cli
brew install gh

# node
vfox add nodejs

vfox install nodejs@latest

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# vfox
brew install vfox

# github cli
brew install gh

# node
vfox add nodejs

vfox install nodejs@latest

# pnpm
sudo npm install -g pnpm@latest-10

# Dotfiles

git clone https://github.com/legendairy75/.dotfiles.git

cd .dotfiles/
stow zsh

# yazi
sudo dnf copr enable lihaohong/yazi
sudo dnf install yazi
