# Load local machine's zshrc
if [ -f /etc/zshrc ];then
  source /etc/zshrc
fi

# zplug Preparation {{{
if [ -f ~/.zsh_no_zplug ];then
  return
fi

if [ -d /usr/local/opt/zplug ];then
  export ZPLUG_HOME=/usr/local/opt/zplug
elif [ -d "$HOME/zplug" ];then
  export ZPLUG_HOME="$HOME/.zplug"
elif [[ "$OSTYPE" =~ darwin ]];then
  if !type brew >&/dev/null;then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  brew install zplug
  if [ $? -eq 0 ];then
    export ZPLUG_HOME=/usr/local/opt/zplug
  fi
else
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
  if [ $? -eq 0 ];then
    export ZPLUG_HOME="$HOME/.zplug"
  fi
fi

# No setting if zlug is not available
if [ -z "$ZPLUG_HOME" ];then
  return
fi

source $ZPLUG_HOME/init.zsh
# }}}

# Plugins {{{
# Self management
zplug "zplug/zplug", hook-build:'zplug --self-manage'

# Completion {{{
zplug "zsh-users/zsh-completions"
zplug "plugins/git",   from:oh-my-zsh
zplug "peterhurford/git-aliases.zsh"
# }}}

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"
zplug "mafredri/zsh-async"

# {{{ fzf
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
zplug "mollifier/anyframe"
zplug "motemen/ghq", as:command, from:gh-r
# }}}

# {{{ after compinit (defer>=2)
zplug "zsh-users/zsh-syntax-highlighting", defer:2
# }}}
# }}} Plugins

# Check and install plugins {{{
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
# }}}

# Load plugins # {{{
zplug load --verbose >/dev/null
# }}}

# Other personal settings
PS1="[%n@%m %~]\$ "

# Complement
autoload -U compinit
compinit
zstyle ':completion:*:default' menu select=1
zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#setopt list_packed

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
