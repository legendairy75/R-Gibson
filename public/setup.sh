#!/bin/bash

echo "Caraline Setup Script"
echo "Updating!"

sudo dnf -y upgrade

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
  node
  fastfetch
  curl
  stow
  figlet
  fortune
  zsh-syntax-highlighting
)
for pkg in ${pkgs[@]}; do
  sudo dnf -y install ${pkg}
  echo "${pkg} installed"
done

echo "This is where the fun begins"

echo "Installing ohmyzsh"
# oh my zsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

echo "Installing oh my posh and nerd font"
#zsh syntax highlighting

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# oh my posh
curl -s https://ohmyposh.dev/install.sh | bash -s

# nerdfont
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/0xProto.zip &&
  cd ~/.local/share/fonts &&
  unzip 0xProto.zip &&
  rm 0xProto.zip &&
  fc-cache -fv

echo "Installing lazyvim"
# lazyvim
git clone https://github.com/LazyVim/starter ~/.config/nvim

rm -rf ~/.config/nvim/.git

echo "Installing dotfiles"
# dotfiles

git clone https://github.com/legendairy75/.dotfiles.git ~/.dotfiles

cd ~/.dotfiles/
rm ~/.zshrc
stow zsh
stow zshconf
stow omp
stow tmux
stow tmuxPlugins
stow nvim
stow kitty
stow yazi

# vs code

# sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
# echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo >/dev/null
#
# dnf check-update
# sudo dnf install code # or code-insiders

echo "Installing homebrew"
# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo >>/home/$USER/.bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>/home/$USER/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

#echo "Installing vfox"
## vfox
#brew install vfox

#echo "Installing node & pnpm"
## node
#vfox add nodejs

#vfox install nodejs@latest

#vfox use nodejs@latest

# pnpm
sudo npm install -g pnpm@latest-10

pnpm add -g nodemon

echo "Installing yazi"
# yazi
sudo dnf copr enable -y lihaohong/yazi
sudo dnf install -y yazi

echo "choose default applications"
kcmshell6 componentchooser

echo "making zsh default shell"
chsh -s $(command -v zsh)

echo "All done! Rebooting in 5 seconds..."
sleep 5
sudo reboot
