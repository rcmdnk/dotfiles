if [ -f /etc/zshrc ];then
  source /etc/zshrc
fi

PS1="[%n@%m %~]\$ "

# Complement
autoload -U compinit
compinit
zstyle ':completion:*:default' menu select=1
zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt list_packed

# allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

# keep background processes at full speed
setopt NOBGNICE
# restart running processes on exit
setopt HUP

# history
setopt APPEND_HISTORY
# for sharing history between zsh processes
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# never ever beep ever
setopt NO_BEEP

# automatically decide when to page a list of completions
LISTMAX=0

# disable mail checking
MAILCHECK=0

# color
autoload -U colors
colors

# bindkey emacs mode
bindkey -e

# ls
alias l='/bin/ls'
if [[ "$OSTYPE" =~ linux ]] || [[ "$OSTYPE" =~ cygwin ]];then
  if ls --color=auto --show-control-char >/dev/null 2>&1;then
    alias ls='ls --color=auto --show-control-char'
    alias la='ls -A --color=auto --show-control-char'
  else
    alias ls='ls --color=auto'
    alias la='ls -A --color=auto'
  fi
elif [[ "$OSTYPE" =~ darwin ]];then
  alias ls='ls -G'
  alias la='ls -A -G'
fi

# sd_cl
if [ -f ~/usr/etc/sd_cl ];then
  SD_CL_NOCOMPINIT=1
  source ~/usr/etc/sd_cl
fi
