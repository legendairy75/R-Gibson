# Dot Files

Install my dot files from my .dotfile repo and use stow to link them to the correct locations.
or use my setup script by pasting this command in your terminal:

```bash
wget -qO- https://ron-gibson.com/setup.sh | bash
```

## issues

currently I cant get zsh to automadicly become the default shell after running the setup script, so after the computer re starts you will need to run this command in the terminal:

```bash
chsh -s $(which zsh)
```

and reboot again.
