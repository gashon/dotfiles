# Powerlevel10k instant prompt. 
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# disable ctrl-s and ctrl-q in terminal
stty -ixon

fastfetch

# manage history file size
HISTFILE=~/.histfile
HISTSIZE=10_000_000
SAVEHIST=100_000
setopt EXTENDED_HISTORY # Write to hist file in format ":start:elapsed;command"
setopt INC_APPEND_HISTORY # Write to history file immediately, not when shell exists

# auto cd if path isn't present + notify on job status changes
setopt autocd notify

# use vim keybindings
bindkey -v

export EDITOR=vim
export VISUAL=vim

autoload -Uz compinit
compinit

hash -d ghub="$HOME/Github"
hash -d ssh="$HOME/.ssh"
hash -d config="$HOME/.config"s

alias xclip="xclip -sel clip"
alias less="less -R -N"

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
antigen use oh-my-zsh > /dev/null
antigen bundle git > /dev/null
antigen bundle zsh-users/zsh-completions > /dev/null
antigen bundle zsh-users/zsh-syntax-highlighting > /dev/null
antigen bundle zsh-users/zsh-autosuggestions > /dev/null
antigen bundle ael-code/zsh-colored-man-pages > /dev/null
antigen apply

