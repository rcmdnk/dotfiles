#!/usr/bin/env bash
# .bashrc

# Check if this is first time to read bashrc or not {{{
_reset_path () {
  local p
  for p in PATH LD_LIBRARY_PATH PYTHONPATH PKG_CONFIG_PATH;do
    local ip=$(eval echo "\$INIT_$p")
    if [ -z "$ip" ];then
      # Set initial values
      eval export INIT_$p="\$$p"
    else
      # Reset paths
      eval export $p=\""$ip"\"
    fi
  done
}
_reset_path
# }}} Check if this is first time to read bashrc or not

# Function for sourcing with precheck of the file {{{
source_file () {
  if [ $# -lt 1 ];then
    echo "ERROR!!! source_file is called w/o an argument"
    return
  fi
  arg="$1"
  shift
  if [ -r "$arg" ]; then
    source "$arg"
  fi
} # }}} Function for sourcing with precheck of the file

# Source global definitions {{{
PROMPT_COMMAND=""
# Most of systems have useful default bashrc
source_file /etc/bashrc
# Remove the last ";" from PROMPT_COMMAND
## Necessary for Mac Terminal.app
PROMPT_COMMAND="${PROMPT_COMMAND%;}"
if type busybox >& /dev/null;then
  PROMPT_COMMAND=""
fi
# }}}

## Local path {{{
# PATH, LD_LIBRARY_PATH under HOME
if uname -a|grep -q x86_64;then
  export x86_64=1
else
  export x86_64=0
fi
add_path () {
  if [ $# -lt 2 ];then
    echo "Usage: add_path <PATH, LD_LIBRARY_PATH or  etc..> <path> [1 to add in the last]"
    return 1
  fi
  local var="$1"
  local path="$2"
  local last=${3:-0}
  if [ ! -d "$path" ];then
    return 1
  fi
  if ! echo "\$$var"|grep -q -e "^${path}" -e ":${path}";then
    if [ "$last" = 1 ];then
      eval "export ${var}=\"\${$var:+\$$var:}${path}\""
    else
      eval "export ${var}=\"${path}\${$var:+:\$$var}\""
    fi
  fi
}

check_path () { # {{{
  if [ $# -eq 0 ];then
    echo "Usage: check_path <PATH, LD_LIBRARY_PATH or  etc..>"
    return 1
  fi
  local v=$1
  local LF=$'\\\x0A'
  #eval "echo "\$$v"| sed 's/:/'"$LF"'/g'"
  eval "echo \$$PATH"| sed 's/:/'"$LF"'/g'
}
# }}}

clean_path () { # {{{
  if [ $# -eq 0 ];then
    echo "Usage: clean_path <PATH, LD_LIBRARY_PATH or  etc..>"
    return 1
  fi
  local v=$(eval "echo \$$1")
  local orig_ifs=$IFS
  IFS=":"
  local p_orig=($v)
  IFS=$orig_ifs
  v_tmp=""
  for p in "${p_orig[@]}";do
    add_path v_tmp "$p" 1
  done
  #eval "export ${v}=\"\$${v_tmp}\""
  eval "echo ${v}=\"\$${v_tmp}\""
  unset v_tmp
}

for p in "" "/usr" "/usr/local" "$HOME" "$HOME/usr" "$HOME/usr/local";do
  add_path PATH "${p}/bin"
  add_path LD_LIBRARY_PATH "${p}/lib"
  add_path LD_LIBRARY_PATH "${p}/lib/pkgconfig"
  if [ "$x86_64" = 1 ];then
    add_path LD_LIBRARY_PATH "${p}/lib64"
    add_path LD_LIBRARY_PATH "${p}/lib64/pkgconfig"
  fi
done
export GOPATH=$HOME/.go
if [ -d "$GOPATH/bin" ];then
  add_path PATH "${GOPATH}/bin"
fi
if [ -n "$SSHHOME" ];then
  add_path PATH "${SSHHOME}/.sshrc"
fi
_set_ghq_path () {
  if type ghq >& /dev/null;then
    local root=$(ghq root)
    if [ -z "$root" ];then
      root="$HOME/.ghq"
    fi
    for d in $(ghq list);do
      local path="${root}/${d}/bin"
      if [ -d "$path" ];then
        add_path PATH "$path" 1
      fi
    done
  fi
}
_set_ghq_path
# }}} Local path

# Shell/Environmental variables {{{
# Prompt
PS1="[\\h \\W]\$ "

# XMODIFIERS
#export XMODIFIERS="@im=kinput2"

# Lang
#export LANG=C
#export LANG="en_GB.UTF-8"
export LANG="en_US.UTF-8"
#export LANG="ja_JP.eucJP"
#export LANG="ja_JP.UTF-8"
#export LC_ALL="ja_JP.UTF-8"
#export LC_ALL="en_GB.UTF-8"
export LC_ALL="en_US.UTF-8"
#export LC_MESSAGES="en_GB.UTF-8"
#export LC_DATE="en_GB.UTF-8"

# Editors
if type vim >& /dev/null;then
  export VISUAL=vim
  export EDITOR=vim
fi
export PAGER=less

# Terminfo
for d in "$HOME/.terminfo/" "$HOME/usr/share/terminfo/" \
         "$HOME/usr/share/lib/terminfo/" "/usr/share/terminfo/" \
         "/usr/share/lib/terminfo";do
  if [ -d "$d" ];then
    export TERMINFO="$d"
    break
  fi
done

# For less
export LESS='-I -R -M -W -x2'
if type source-highlight >& /dev/null;then
  if type my_lesspipe >& /dev/null;then
    export LESSOPEN='| my_lesspipe %s'
  elif type src-hilite-lesspipe.sh >& /dev/null;then
    export LESSOPEN='| src-hilite-lesspipe.sh %s'
  fi
fi

# TMPDIR fix, especially for Cygwin
if [ ! "$TMPDIR" ];then
  if [ "$TMP" ];then
    export TMPDIR=$TMP
  elif [ "$TEMP" ];then
    export TMPDIR=$TEMP
  elif [ -w "/tmp/$USER" ];then
    export TMPDIR=/tmp
  elif [ -w /tmp ];then
    mkdir -p "/tmp/$USER"
    export TMPDIR=/tmp/$USER
  else
    mkdir -p ~/tmp
    export TMPDIR=~/tmp
  fi
fi

# Python
export PYTHONSTARTUP=~/.pythonstartup.py

# Trash
export TRASHLIST=~/.trashlist # Where trash list is written
export TRASHBOX=~/.Trash # Where trash will be moved in
                         # (.Trash is Mac's trash box)
export MAXTRASHBOXSIZE=1024 # Max trash box size in MB
                            # Used for clean up
if type bc >& /dev/null;then
  export MAXTRASHSIZE=$(echo $MAXTRASHBOXSIZE "*" 0.1|bc -l|cut -d. -f1)
else
  export MAXTRASHSIZE=100
fi
# Trashes larger than MAXTRASHBOXSIZE will be removed by 'rm' directly

# For my clipboards
export CLMAXHIST=50

# }}} Environmental variables

# shopt {{{
shopt -s checkwinsize # Update the window size after each command
shopt -s dotglob # Include dot files in the results of pathname expansion
shopt -s extglob # Extended pattern matching is enabled.
shopt -s no_empty_cmd_completion # Don't complete for an empty line
shopt -s cdspell # Auto spell correction at cd
if [ "${BASH_VERSINFO[0]}" -ge 4 ];then
  shopt -s dirspell # Auto spell correction at tab-completion for cd
fi
# }}} shopt

# stty {{{
# Disable terminal lock
tty -s && stty stop undef
tty -s && stty start undef
[[ "$OSTYPE" =~ darwin ]] && tty -s && stty discard undef
# }}}

# History {{{
HISTSIZE=500000
HISTFILESIZE=100000
export HISTCONTROL="erasedups:ignoreboth"
export HISTIGNORE="cd:cd :cd -:cd ../:ls:sd:cl:pwd:history:exit:bg:fg:git st:git push:git update"
export HISTTIMEFORMAT='%y/%m/%d %H:%M:%S  ' # add time to history
PROMPT_COMMAND="${PROMPT_COMMAND:+${PROMPT_COMMAND};}history -a"
# }}} history

# For ls color {{{
if [[ "$OSTYPE" =~ linux ]] || [[ "$OSTYPE" =~ cygwin ]];then
  # Linux
  if type dircolors >& /dev/null;then
    eval "$(dircolors ~/.colourrc)"
  fi
  source_file "$HOME/.lscolors"
elif [[ "$OSTYPE" =~ darwin ]];then
  # Mac (LSCOLORS, instead of LS_COLORS)
  export LSCOLORS=DxgxcxdxCxegedabagacad
fi
# }}} For ls color

# Alias, Function {{{
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
alias lt='ls -altr'
alias badlink='find -L . -depth 1 -type l -ls'
alias badlinkall='find -L . -type l -ls'
alias g='make'
alias gc="make clean"
alias gcg="make clean && make"
alias bc="bc -l"
alias svnHeadDiff="svn diff --revision=HEAD"
#if type nvim >& /dev/null;then
#  alias svnd="svn diff | nvim -"
#  alias vi="nvim" # vi->vim
#  alias memo="nvim ~/.memo.md"
#  alias vid="nvim -d"
#  alias vinon="nvim -u NONE"
#elif type vim >& /dev/null;then
if type vim >& /dev/null;then
  alias svnd="svn diff | vim -"
  #alias vim="vim -X --startuptime $TMPDIR/vim.startup.log" # no X, write startup processes
  alias vim="vim -X" # no X
  alias vi="vim" # vi->vim
  alias memo="vim ~/.memo.md"
  alias vid="vim -d"
  alias vinon="vim -u NONE"
fi
alias put='multi_clipboard -x'
alias del="trash -r"
alias histcheck="history|awk '{print \$4}'|sort|uniq -c|sort -n"
alias histcheckarg="history|awk '{print \$4\" \"\$5\" \"\$6\" \"\$7\" \"\$8\" \"\$9\" \"\$10}'|sort|uniq -c|sort -n"
alias sort='LC_ALL=C sort'
alias uniq='LC_ALL=C uniq'
alias t='less -L +F'
alias iocheck='find /proc -name io |xargs egrep "write|read"|sort -n -k 2'
alias now='date +"%Y%m%d %T"'
alias pip_upgrade="pip list --outdated --format=legacy|cut -d' ' -f1|xargs pip install -U"
alias stow="stow --override='share/info/dir'"
type thefuck >& /dev/null &&  alias fuck='eval $(thefuck $(fc -ln -1))'
type hub >& /dev/null && eval "$(hub alias -s)" # Use GitHub wrapper for git
alias ssh="ssh -Y"
#type sshrc >& /dev/null && alias ssh="sshrc -Y"
#type moshrc >& /dev/null && alias mosh="moshrc"
type colordiff >& /dev/null && alias diff='colordiff'
if type ccat >& /dev/null;then
  alias cat='ccat --bg=dark -G String="fuchsia" -G Keyword="yellow" -G Plaintext="lightgray" -G Decimal="fuchsia" -G Punctuation="lightgray" -G Type="lightgray" -G Comment="turquoise"'
  #alias cat='ccat --bg=dark -G String="fuchsia" -G Keyword="yellow" -G Plaintext="lightgray" -G Decimal="fuchsia" -G Punctuation="lightgray"'
fi
type tree >& /dev/null || alias tree="pwd && find . | sort | sed '1d;s,[^/]*/,|    ,g;s/..//;s/[^ ]*$/|-- &/'" # pseudo tree

man () { # man with vim {{{
  if [ $# -ne 1 ] || [[ "$1" =~ ^- ]];then
    command man "$@"
    return $?
  fi

  unset PAGER
  unset MANPAGER
  var=$(command man "$@" 2>&1)
  ret=$?
  if [ $ret -eq 0 ];then
    if type vim >& /dev/null;then
      echo "$var"|col -bx|vim -R -c 'set ft=man' -
    else
      command man "$@"
    fi
  else
    echo "$var"
    return $ret
  fi
} # }}}

change () { # Change words in file by sed {{{
  case $# in
    0)
      echo "enter file name and words of before and after"
    ;;
    1)
      echo "enter words of before and after"
    ;;
    2)
      sed -i.bak "s!$2!!g" "$1"
      rm -f "$1".bak
    ;;
    3)
      sed -i.bak "s!$2!$3!g" "$1"
      rm -f "$1".bak
    ;;
    *)
      echo "enter file name and words of before and after"
    ;;
  esac
} # }}}

del_tail () { # Delete trailing white space {{{
  sed -i.bak 's/ \+$//g' "$1"
  rm -f "$1".bak
} # }}}

# tar/press: File compression/decompression {{{
dec () {
  if echo "$1"|grep -q "tar.gz$";then
    tar zxf "$1"
  elif echo "$1"|grep -q "tgz$";then
    tar zxf "$1"
  elif echo "$1"|grep -q "gz$";then
    gzip -d "$1"
  elif echo "$1"|grep -q "tar.xz$";then
    tar Jxf "$1"
  elif echo "$1"|grep -q "tar.bz2$";then
    tar jxf "$1"
  elif echo "$1"|grep -q "tar.Z$";then
    tar zxf "$1"
  elif echo "$1"|grep -q "tar$";then
    tar xf "$1"
  elif echo "$1"|grep -q "zip$";then
    unzip "$1"
  else
    echo "$1 is not supported."
    return 1
  fi
}

comp () {
  local remove=0
  local HELP="
  usage: comp [-r] directory_name [package_name]

         -r for remove original directory
         if package_name is not given, it makes file:
         directory_name.tar.gz
"
  if [ $# -eq 0 ];then
    echo "$HELP"
  elif [ "$1" = "-d" ];then
    remove=1
    shift
  fi
  local dir=${1%/*}
  case "$#" in
          0)
    echo "$HELP"
    ;;
          1)
    echo "${dir}"
    tar czf "${dir}.tar.gz" "${dir}"
    ;;
          2)
    tar czf "${2}" "${dir}"
    ;;
  esac
  if [ $remove -eq 1 ];then
    rm -rf "${dir}"
  fi
}
# }}}

path () { # path: function to get full path {{{
  if [ $# -eq 0 ];then
      echo "usage: path file/directory"
      return 1
  fi
  echo "$(cd "$(dirname "$1")";pwd -P)/$(basename "$1")"
} # }}}

# }}}

## sd/cl: Directory save/move in different terminal {{{
source_file ~/usr/etc/sd_cl
# }}}

calc () { # Function to calculate with perl (for decimal, etc...) {{{
  local eq=$(echo "$@"|sed "s/\^/**/g")
  printf "\$xx =%s;print \"\$xx \\n\"" "$eq"|perl
} # }}}

linkcheck () { # Function to find the original file for the symbolic link {{{
  if [ "$#" -ne 1 ];then
    echo "Usage: linkcheck file/directory" >&2
    return 1
  fi

  local curdir="$(pwd)"
  local link="$1"
  local prelink="$1"
  while :;do
    if [ -L "$link" ];then
      echo "$link ->"
      prelink=$link
      link=$(readlink "$link")
      local dir="$(dirname "$prelink")"
      if [ -d "$dir" ];then
        cd "$dir"
      fi
    elif [ -e "$link" ];then
      echo "$link"
      cd "$curdir"
      return 0
    else
      echo "$link does not exist!" >&2
      cd "$curdir"
      return 2
    fi
  done
  cd "$curdir"
} # }}}

# For GNU-BSD compatibility {{{

# cp wraper for BSD cp (make it like GNU cp){{{
# Remove the end "/" and change -r to -R
if ! cp --version 2>/dev/null |grep -q GNU;then
  cp () {
    local -a opt
    opt=()
    local -a vars
    vars=()
    while [ $# -gt 0 ];do
      if [[ "$1" == -* ]];then
        if [ "$1" == "-r" ];then
          opt=("${opt[@]}" -R)
        else
          opt=("${opt[@]}" $1)
        fi
      else
        vars=("${vars[@]}" ${1%/})
      fi
      shift
    done
    command cp "${opt[@]}" "${vars[@]}"
  }
fi
# }}}

# sedi: Use common function in Mac/Unix for sed -i... w/o backup {{{
# Unix uses GNU sed
# Mac uses BSD sed
# BSD sed requires suffix for backup file when "-i" option is given
# (for no backup, need ""),
# while GNU sed can run w/o suffix and doesn't make backup file
if sed --version 2>/dev/null |grep -q GNU;then
  alias sedi='sed -i"" '
else
  alias sedi='sed -i "" '
fi
# }}}

# tac (use tail -r at BSD): Revert lines in the file/std input {{{
# Note: There is "rev" command which
#       reversing the order of characters in every line.
# Set reverse command as tac for BSD
if ! type tac >& /dev/null;then
  if ! tail --version 2>/dev/null|grep -q GNU;then
    alias tac='tail -r'
  else
    # need "function" to avoid error on alias,
    # even if this path is not used.
    function tac () {
      if [ ! -f "$1" ];then
        echo "usage: tac <file>"
        return 1
      fi
      sed -e '1!G;h;$!d' "$1"|while read -r line;do
        echo "$line"
      done
    }
  fi
fi

# mktemp
alias mktempdir="mktemp 2>/dev/null||mktemp -t tmp"
# }}}

# for ghq {{{
if type ghq >& /dev/null;then
  ghqgo () {
    if [ $# -gt 0 ];then
      local repos="$*"
    else
      local repos=$(ghq list|sentaku)
    fi
    if [ -n "$repos" ];then
      cd "$(ghq root)/$repos"
    fi
  }

  ghqget () {
    if [ $# -eq 0 ];then
      ghq --help
      return
    fi
    repo="$1"
    local n=$(echo "$repo"|awk '{n=split($1, tmp, "/")}{print n}')
    if [ "$n" -eq 1 ];then
      repo="$(git config  --get user.name)/$repo"
    fi
    ghq get -p "$repo"
  }

  ghqrm () {
    if [ $# -gt 0 ];then
      local repos=("$@")
    else
      local repos=($(ghq list|sentaku))
    fi
    for r in "${repos[@]}";do
      local n="$(echo "$r"|awk '{print split($0, tmp, "/")}')"
      if [ "$n" -eq 1 ];then
        local dir="$(ls -d "$(ghq root)/"*/*"/$r")"
      elif [ "$n" -eq 2 ];then
        local dir="$(ls -d "$(ghq root)/"*"/$r")"
      elif [ "$n" -eq 3 ];then
        local dir="$(ls -d "$(ghq root)/$r")"
      else
        local dir="$r"
      fi
      if [ -n "$dir" ];then
        rm -rf "$dir"
      fi
    done
  }

  alias ghqlist="ghq list"
  alias ghqls="ghq list"
fi
# }}}

# }}} For GNU-BSD compatibility

# Suffix aliases/auto cd {{{
if [ "${BASH_VERSINFO[0]}" -ge 4 ];then
  _suffix_vim=(md markdown txt text tex cc c C cxx h hh java py rb sh)
  alias_function() {
    eval "${1}() $(declare -f "${2}" | sed 1d)"
  }
  if ! type orig_command_not_found_handle >& /dev/null;then
    if type command_not_found_handle >& /dev/null;then
      alias_function orig_command_not_found_handle command_not_found_handle
    else
      orig_command_not_found_handle () {
        echo "bash: $1: command not found"
        return 127
      }
    fi
  fi
  command_not_found_handle() {
    cmd="$1"
    args=("$@")
    if [ -f "$cmd" ];then
      if echo " ${_suffix_vim[*]} "|grep -q "${cmd##*.}";then
        if type vim >& /dev/null;then
          vim "${args[@]}"
          return $?
        fi
      elif [ "${cmd##*.}" = "ps1" ];then
        if type powershell >& /dev/null;then
          powershell -F "${args[@]}"
          return $?
        fi
      fi
    fi
    orig_command_not_found_handle "${args[@]}"
  }
  shopt -s autocd # cd to the directory, if it is given as a command.
fi
#}}}
# }}} Alias, Function

# Setup for each environment {{{
# Note: such PATH setting should be placed
#       at above Local path settings (before alias/function definitions)

# Shell logger
source_file ~/usr/etc/shell-logger

# added by travis gem
source_file ~/.travis/travis.sh

# Load RVM into a shell session *as a function*
source_file ~/.rvm/scripts/rvm

# For screen
source_file ~/.screen/setup.sh

# File used in linux
[[ "$OSTYPE" =~ linux ]] && source_file ~/.linuxrc

# File used in mac
[[ "$OSTYPE" =~ darwin ]] && source_file ~/.macrc

# File used in windows (cygwin)
[[ "$OSTYPE" =~ cygwin ]] && source_file ~/.winrc

# File for special settings for each machine
source_file ~/.localrc

# }}} Setup for each environment
