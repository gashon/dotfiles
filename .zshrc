# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
# source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Powerlevel10k instant prompt.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

[ -z "$TMUX" ] && tmux attach || tmux new-session

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# disable ctrl-s and ctrl-q in terminal
stty -ixon

command -v fastfetch &>/dev/null && fastfetch

pathadd() {
	if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
		PATH="${PATH:+"$PATH:"}$1"
	fi
}

pathadd "$HOME/.local/bin"
pathadd "$HOME/.crypto/bin"
command -v go &>/dev/null && pathadd "$(go env GOPATH)/bin"
command -v rustup &>/dev/null && pathadd "$HOME/.cargo/bin"

setopt NO_BG_NICE   # don't lower priority of background jobs
setopt NO_LIST_BEEP # don't beep on tab completion

HISTFILE=~/.zsh_history

# avg cmd hist line length is 30, 1_500_000 * 30 = 45MB
HISTSIZE=1_500_000
SAVEHIST=1_500_000

setopt EXTENDED_HISTORY   # Write to hist file in format ":start:elapsed;command"
setopt INC_APPEND_HISTORY # Write to history file immediately, not when shell exists
setopt HIST_REDUCE_BLANKS # Remove leading/trailing blanks from each hist line
setopt SHARE_HISTORY      # Share history between all sessions
setopt APPEND_HISTORY     # Append history to the history file (no overwriting)

# auto cd if path isn't present + notify on job status changes
setopt autocd notify

export EDITOR="nvim"
export VISUAL="nvim"

autoload -Uz compinit
compinit

# named directories
hash -d ghub="$HOME/Documents/github"
hash -d ssh="$HOME/.ssh"
hash -d config="$HOME/.config"

# antigen plugins
if ! [[ -f ~/.antigen/antigen.zsh ]]; then
	echo "Installing antigen"
	mkdir ~/.antigen
	wget git.io/antigen -O ~/.antigen/antigen.zsh ||
		curl -L git.io/antigen -o ~/.antigen/antigen.zsh ||
		print -P '%F{red}%B!!! Unable to install antigen via wget or curl !!!%b%f'
fi

source ~/.antigen/antigen.zsh

# antigen theme romkatv/powerlevel10k
antigen use oh-my-zsh >/dev/null
antigen bundle git >/dev/null
antigen bundle zsh-users/zsh-completions >/dev/null
antigen bundle zsh-users/zsh-syntax-highlighting >/dev/null
antigen bundle zsh-users/zsh-autosuggestions >/dev/null
antigen bundle ael-code/zsh-colored-man-pages >/dev/null
antigen apply

# initialize conda
if [[ -f /opt/miniforge3/bin/conda ]]; then
	eval "$(/opt/miniforge3/bin/conda shell.zsh hook)"
fi

# fzf history search
command -v fzf &>/dev/null && source <(fzf --zsh)

# zoxide
if command -v zoxide &>/dev/null; then
	eval "$(zoxide init zsh)"
fi

# enable vi mode
bindkey -v

# aliases
alias xclip="xclip -sel clip"
alias less="less -R -N"
alias open="nautilus"
alias ls="eza"
alias l="eza -laah"

[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# To customize prompt, run `p10k configure` or edit ~/Documents/github/dotfiles/.p10k.zsh.
[[ ! -f ~/Documents/github/dotfiles/.p10k.zsh ]] || source ~/Documents/github/dotfiles/.p10k.zsh

export PATH="$PATH:/home/gashon/Documents/github/screenpipe/target/debug"
