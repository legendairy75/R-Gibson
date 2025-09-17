#source /home/legendairy/.bashrc
#source ~/.local/share/omakub/defaults/bash/rc

# export PATH=/home/legendairy/.local/share/mise/installs/node/20.16.0/bin:$PATH
export PATH=$PATH:/home/legendairy/.local/bin:$PATH
# If you come from bash you might have to change y#our $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH="$PATH:/home/legendairy/.local/share/JetBrains/Toolbox/scripts:$PATH"

# export OPEN_WEATHER_API_KEY= "5bea91a1e11a0ffa65574e3d73d4097d"

# export PATH=$HOME/.cargo/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export EDITOR="nvim"
# export SUDO_EDITOR = "$EDITOR"

ZSH_THEME="robbyrussell"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

#plugins
plugins=(
  git 
  vscode 
  sudo 
  ubuntu
  hitchhiker
  vi-mode
  aliases
  tmux 
  copyfile 
  copypath 
  dotenv  
  emoji-clock
  extract
  kitty 
  last-working-dir
  man 
  magic-enter
  mongocli
  wd
  web-search
  dnf
  frontend-search
  docker
  tldr
)

source $ZSH/oh-my-zsh.sh

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.local/share/caroline/zsh/aliases
source ~/.local/share/caroline/zsh/prompt

# Start up prompt
CYAN="\e[36m"
STOP="\e[0m"
printf "${CYAN}"
hostname | figlet -c -f big
printf "${STOP}"
username=`hostname -i | awk '{print $3}'`
echo "User: $USER@$username"
uptime -p
# node Programming/JS/Today.js
########################################################

eval "$(oh-my-posh init zsh --config ~/ghost.omp.json)"

export OPEN_WEATHER_API_KEY='384b143e22f5f29ea6fd067aeca3b7f4'

# pnpm
export PNPM_HOME="/home/legendairy/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/legendairy/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/home/legendairy/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/legendairy/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/legendairy/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/legendairy/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/legendairy/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/legendairy/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/legendairy/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

eval "$(vfox activate zsh)"
