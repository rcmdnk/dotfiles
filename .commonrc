#!/usr/bin/env bash
# Common rc file for Bash/Zsh

_reset_path () { # Check if this is first time to read bashrc or not {{{
  local p
  for p in PATH LD_LIBRARY_PATH PYTHONPATH PKG_CONFIG_PATH;do
    eval "local ip=\$INIT_$p"
    if [[ -z "$ip" ]];then
      # Set initial values
      eval export INIT_$p="\$$p"
    else
      # Reset paths
      eval export $p=\""$ip"\"
    fi
  done
} # }}} Check if this is first time to read bashrc or not

_source_file () { # Function for sourcing with precheck of the file {{{
  if [[ $# -lt 1 ]];then
    echo "ERROR!!! Usage: _source_file <file>"
    return
  fi
  file="$1"
  if [[ -r "$file" ]]; then
    source "$file"
  fi
} # }}} Function for sourcing with precheck of the file

## PATH {{{
_add_path () { # {{{
  if [[ $# -lt 2 ]];then
    echo "Usage: _add_path <PATH, LD_LIBRARY_PATH or  etc..> <path> [1 to add in the last]"
    return 1
  fi
  local var="$1"
  local path="$2"
  local last=${3:-0}
  if [[ ! -d "$path" ]];then
    return 1
  fi
  eval local current=":\${$var}:"
  if [[ "$current" != *:${path}:* ]];then
    if [[ "$last" = 1 ]];then
      eval "export ${var}=\"\${$var:+\$$var:}${path}\""
    else
      eval "export ${var}=\"${path}\${$var:+:\$$var}\""
    fi
  fi
} # }}}

check_path () { # {{{
  if [[ $# -eq 0 ]];then
    echo "Usage: check_path <PATH, LD_LIBRARY_PATH or  etc..>"
    return 1
  fi
  local v=$1
  local LF=$'\\\x0A'
  eval "echo \$$v"| sed 's/:/'"$LF"'/g'
} # }}}

_clean_path () { # {{{
  if [[ $# -eq 0 ]];then
    echo "Usage: _clean_path <PATH, LD_LIBRARY_PATH or  etc..>"
    return 1
  fi
  local path_name=$1
  eval "local v=\$$path"
  local orig_ifs=$IFS
  IFS=":"
  local p_orig=($v)
  IFS=$orig_ifs
  v_tmp=""
  for p in "${p_orig[@]}";do
    _add_path v_tmp "$p" 1
  done
  #eval "export ${v}=\"\$${v_tmp}\""
  eval "echo ${v}=\"\$${v_tmp}\""
  unset v_tmp
} # }}}

_set_ghq_path () { # {{{
  if type ghq >& /dev/null;then
    local root=$(command ghq root)
    if [[ -z "$root" ]];then
      root="$HOME/.ghq"
    fi
    for d in $(command ghq list);do
      local path="${root}/${d}/bin"
      if [[ -d "$path" ]];then
        _add_path PATH "$path" 1
      fi
    done
  fi
} # }}}

_set_linuxbrew_path () { # {{{
  _add_path PATH $HOME/.linuxbrew/bin
  _add_path PATH $HOME/.linuxbrew/sbin
  _add_path PATH /home/linuxbrew/.linuxbrew/bin
  _add_path PATH /home/linuxbrew/.linuxbrew/sbin
} # }}}

_set_path () { # {{{
  local hardware=$(uname -m)
  for p in "" "/usr" "/usr/local" "$HOME" "$HOME/usr" "$HOME/usr/local";do
    _add_path PATH "${p}/bin"
    _add_path LD_LIBRARY_PATH "${p}/lib"
    _add_path LD_LIBRARY_PATH "${p}/lib/pkgconfig"
    if [[ "$hardware" == x86_64 ]];then
      _add_path LD_LIBRARY_PATH "${p}/lib64"
      _add_path LD_LIBRARY_PATH "${p}/lib64/pkgconfig"
    fi
  done
  export GOPATH=$HOME/.go
  if [[ -d "$GOPATH/bin" ]];then
    _add_path PATH "${GOPATH}/bin"
  fi
  if [[ -n "$SSHHOME" ]];then
    _add_path PATH "${SSHHOME}/.sshrc"
  fi
  _set_ghq_path
  _set_linuxbrew_path
} # }}}
# }}} PATH

_set_env () { # Shell/Environmental variables {{{
  # Lang
  export LANG="en_US.UTF-8"
  #export LANG="ja_JP.eucJP"
  #export LANG="ja_JP.UTF-8"
  #export LC_ALL="ja_JP.UTF-8"
  #export LC_ALL="en_GB.UTF-8"
  export LC_ALL="en_US.UTF-8"
  #export LC_MESSAGES="en_GB.UTF-8"
  #export LC_DATE="en_GB.UTF-8"

  # XMODIFIERS
  #export XMODIFIERS="@im=kinput2"

  # History
  HISTSIZE=500000
  HISTFILESIZE=100000
  export HISTCONTROL="erasedups:ignoreboth"
  export HISTIGNORE="cd:cd :cd -:cd ../:ls:sd:cl:pwd:history:exit:bg:fg:git st:git push:git update"
  export HISTTIMEFORMAT='%y/%m/%d %H:%M:%S  ' # add time to history

  # ls color
  if [[ "$OSTYPE" = linux* ]] || [[ "$OSTYPE" = cygwin* ]];then
    # Linux
    if type dircolors >& /dev/null;then
      eval "$(dircolors ~/.colourrc)"
    fi
    _source_file "$HOME/.lscolors"
  elif [[ "$OSTYPE" = darwin* ]];then
    # Mac (LSCOLORS, instead of LS_COLORS)
    export LSCOLORS=DxgxcxdxCxegedabagacad
  fi

  # Editors
  if type vim >& /dev/null;then
    export VISUAL=vim
    export EDITOR=vim
  fi
  if type less >& /dev/null;then
    export PAGER="less"
  fi

  # For less
  export LESS='-FXIRMW -x2'
  if type source-highlight >& /dev/null;then
    if type my_lesspipe >& /dev/null;then
      export LESSOPEN='| my_lesspipe %s'
    elif type src-hilite-lesspipe.sh >& /dev/null;then
      export LESSOPEN='| src-hilite-lesspipe.sh %s'
    fi
  fi

  # Terminfo
  for d in "$HOME/.terminfo/" "$HOME/usr/share/terminfo/" \
           "$HOME/usr/share/lib/terminfo/" "/usr/share/terminfo/" \
           "/usr/share/lib/terminfo";do
    if [[ -d "$d" ]];then
      export TERMINFO="$d"
      break
    fi
  done

  # TMPDIR fix, especially for Cygwin
  if [[ ! "$TMPDIR" ]];then
    if [[ "$TMP" ]];then
      export TMPDIR=$TMP
    elif [[ "$TEMP" ]];then
      export TMPDIR=$TEMP
    elif [[ -w "/tmp/$USER" ]];then
      export TMPDIR=/tmp
    elif [[ -w /tmp ]];then
      mkdir -p "/tmp/$USER"
      export TMPDIR=/tmp/$USER
    else
      mkdir -p ~/tmp
      export TMPDIR=~/tmp
    fi
  fi

  # Python
  if [[ -f "$HOME/.pythonstartup.py" ]];then
    export PYTHONSTARTUP="$HOME/.pythonstartup.py"
  fi

  # Trash
  export TRASHLIST=~/.trashlist # Where trash list is written
  export TRASHBOX=~/.Trash # Where trash will be moved in
                           # (.Trash is Mac's trash box)
  export MAXTRASHBOXSIZE=1024 # Max trash box size in MB
                              # Used for clean up
  export MAXTRASHSIZE=100 # Trashes larger than MAXTRASHBOXSIZE will be removed by 'rm' directly

  # For my clipboards
  export CLMAXHIST=50
} # }}} Shell/Environmental variables

_emotional_prompt () {
  PS1="\$(\
    ret=\$?;\
    rand=\$((RANDOM%36));\
    if [[ \$ret -eq 0 ]];then\
      if [[ \$rand -lt 3 ]];then\
        printf '\\[\\e[m\\](^_^)\\[\\e[m\\] \$ ';\
      elif [[ \$rand -lt 5 ]];then\
        printf '\\[\\e[m\\](^_-)\\[\\e[m\\] \$ ';\
      elif [[ \$rand -lt 6 ]];then\
        printf '\\[\\e[m\\](.^.)\\[\\e[m\\] \$ ';\
      else\
        printf '\\[\\e[m\\](-_-)\\[\\e[m\\] \$ ';\
      fi;\
    else\
      if [[ \$rand -lt 6 ]];then\
        printf '\\[\\e[31m\\](@o@)\\[\\e[m\\] \$ ';\
      elif [[ \$rand -lt 12 ]];then\
        printf '\\[\\e[31;1m\\](>_<)\\[\\e[m\\] \$ ';\
      elif [[ \$rand -lt 18 ]];then\
        printf '\\[\\e[35m\\](*_*)\\[\\e[m\\] \$ ';\
      elif [[ \$rand -lt 24 ]];then\
        printf '\\[\\e[34m\\](T_T)\\[\\e[m\\] \$ ';\
      elif [[ \$rand -eq 30 ]];then\
        printf '\\[\\e[34;1m\\](/_T)\\[\\e[m\\] \$ ';\
      else\
        printf '\\[\\e[31m\\](>_<)\\[\\e[m\\] \$ ';\
      fi\
    fi;\
    )"
}


_set_stty () { # stty, disable terminal lock {{{
  tty -s && stty stop undef
  tty -s && stty start undef
  [[ "$OSTYPE" = darwin* ]] && tty -s && stty discard undef
} # }}}

_set_alias () { # Alias {{{
  alias l='/bin/ls'
  if [[ "$OSTYPE" = linux* ]] || [[ "$OSTYPE" = cygwin* ]];then
    if ls --color=auto --show-control-char >/dev/null 2>&1;then
      alias ls='ls --color=auto --show-control-char'
      alias la='ls -A --color=auto --show-control-char'
    else
      alias ls='ls --color=auto'
      alias la='ls -A --color=auto'
    fi
  elif [[ "$OSTYPE" = darwin* ]];then
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
  type thefuck >& /dev/null &&  eval "$(thefuck --alias)"
  type hub >& /dev/null && eval "$(hub alias -s)" # Use GitHub wrapper for git
  alias ssh="ssh -Y"
  #type sshrc >& /dev/null && alias ssh="sshrc -Y"
  #type moshrc >& /dev/null && alias mosh="moshrc"
  type colordiff >& /dev/null && alias diff='colordiff'
#  if type bat >& /dev/null;then
#    alias cat='bat'
#  elif type ccat >& /dev/null;then
  if type ccat >& /dev/null;then
    alias cat='ccat --bg=dark -G String="fuchsia" -G Keyword="yellow" -G Plaintext="lightgray" -G Decimal="fuchsia" -G Punctuation="lightgray" -G Type="lightgray" -G Comment="turquoise"'
  fi
  type tree >& /dev/null || alias tree="find . | sort | sed '1d;s,[^/]*/,|    ,g;s/..//;s/[^ ]*$/|-- &/'" # pseudo tree
} # }}} Alias

_set_function () { # Functions
  man () { # man with vim {{{
    if [[ $# -ne 1 ||  "$1" =~ ^- ]] || ! type vim >&/dev/null;then
      command man "$@"
      return $?
    fi

    var=$(command man -P cat "$@" 2>&1)
    ret=$?
    if [[ $ret -eq 0 ]];then
      echo "$var"|col -bx|vim -R -c 'set ft=man' -
    else
      echo "$var"
      return $ret
    fi
  } # }}}

  # for ghq {{{
  if type ghq >& /dev/null;then
    ghqgo () {
      if [[ $# -gt 0 ]];then
        local repos="$*"
      else
        local repos=$(command ghq list|sentaku)
      fi
      if [[ -n "$repos" ]];then
        cd "$(command ghq root)/$repos"
      fi
    }

    ghqget () {
      if [[ $# -eq 0 ]];then
        command ghq --help
        return
      fi
      repo="$1"
      local n=$(echo "$repo"|awk '{n=split($1, tmp, "/")}{print n}')
      if [[ "$n" -eq 1 ]];then
        repo="$(git config  --get user.name)/$repo"
      fi
      command ghq get -p "$repo"
    }

    ghqrm () {
      if [[ $# -gt 0 ]];then
        local repos=("$@")
      else
        local repos=($(command ghq list|sentaku))
      fi
      for r in "${repos[@]}";do
        local n="$(echo "$r"|awk '{print split($0, tmp, "/")}')"
        if [[ "$n" -eq 1 ]];then
          local dir="$(ls -d "$(command ghq root)/"*/*"/$r")"
        elif [[ "$n" -eq 2 ]];then
          local dir="$(ls -d "$(command ghq root)/"*"/$r")"
        elif [[ "$n" -eq 3 ]];then
          local dir="$(ls -d "$(command ghq root)/$r")"
        else
          local dir="$r"
        fi
        if [[ -n "$dir" ]];then
          rm -rf "$dir"
        fi
      done
    }

    alias ghqlist="command ghq list"
    alias ghqls="command ghq list"

    ghq () {
      if [[ "$1" = "go" ]];then
        shift
        ghqgo "$@"
      elif [[ "$1" = "get" ]];then
        shift
        ghqget "$@"
      elif [[ "$1" = "rm" ]];then
        shift
        ghqrm "$@"
      elif [[ "$1" = "list" ]];then
        shift
        ghqlist "$@"
      elif [[ "$1" = "ls" ]];then
        shift
        ghqls "$@"
      else
        command ghq "$@"
      fi
    }
  fi
} # }}} Functions

_gnu_bsd_compatibility () { # GNU-BSD compatibility {{{
  gnu_bsd_check () {
    [[ $($1 --version 2>/dev/null) == *GNU* ]] && return 0
    return 1
  }

  # cp wraper for BSD cp (make it like GNU cp){{{
  # Remove the end "/" and change -r to -R
  if ! gnu_bsd_check cp;then
    cp () {
      local -a opt
      opt=()
      local -a vars
      vars=()
      while [[ $# -gt 0 ]];do
        if [[ "$1" == -* ]];then
          if [[ "$1" == "-r" ]];then
            opt=("${opt[@]}" -R)
          else
            opt=("${opt[@]}" "$1")
          fi
        else
          vars=("${vars[@]}" "${1%/}")
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
  if gnu_bsd_check sed;then
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
    if ! gnu_bsd_check tail;then
      alias tac='tail -r'
    else
      # need "function" to avoid error on alias,
      # even if this path is not used.
      function tac () {
        if [[ ! -f "$1" ]];then
          echo "usage: tac <file>"
          return 1
        fi
        sed -e '1!G;h;$!d' "$1"|while read -r line;do
          echo "$line"
        done
      }
    fi
  fi # }}} tac
} # }}} GNU-BSD compatibility

_source_files () {
  # completion files in ghq
  if type ghq >& /dev/null;then
    local root=$(command ghq root)
    if [[ -z "$root" ]];then
      root="$HOME/.ghq"
    fi
    for d in $(command ghq list);do
      if [ -n "$ZSH_VERSION" ];then
        local path="${root}/${d}/share/zsh/site-functions/"
      elif [ -n "$BASH_VERSION" ];then
        local path="${root}/${d}/etc/bash_completion.d/"
      else
        continue
      fi
      for f in "$path"/*;do
        _source_file "$f"
      done
    done
  fi

  ## sd/cl: Directory save/move in different terminal
  _source_file ~/usr/etc/sd_cl

  # Shell logger
  _source_file ~/usr/etc/shell-logger

  # added by travis gem
  _source_file ~/.travis/travis.sh

  # Load RVM into a shell session *as a function*
  _source_file ~/.rvm/scripts/rvm

  # For screen
  _source_file ~/.screen/setup.sh

  # File used in linux
  [[ "$OSTYPE" = linux* ]] && _source_file ~/.linuxrc

  # File used in mac
  [[ "$OSTYPE" = darwin* ]] && _source_file ~/.macrc

  # File used in windows (cygwin)
  [[ "$OSTYPE" = cygwin* ]] && _source_file ~/.winrc

  # File for special settings for each machine
  _source_file ~/.localrc
} # }}} _source_files

# {{{ Main part
_mainrc () {
  _reset_path
  _set_path
  _set_env
  _set_stty
  _set_alias
  _set_function
  _gnu_bsd_compatibility
  _source_files
}
# }}}
