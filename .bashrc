#!/usr/bin/env bash
# .bashrc

# Check if this is first time to read bashrc or not {{{
# (subshell, screen, etc...)
function _reset_path () {
  local p
  #for p in PATH LD_LIBRARY_PATH PYTHONPATH PKG_CONFIG_PATH;do
  for p in PATH;do
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
function source_file () {
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
source_file /etc/bashrc
# Remove the last ";" from PROMPT_COMMAND
## Necessary for Mac Terminal.app
PROMPT_COMMAND="${PROMPT_COMMAND%;}"
if type -a busybox >& /dev/null;then
  PROMPT_COMMAND=""
fi
# }}}

## Local path {{{
# PATH, LD_LIBRARY_PATH under HOME
export x86_64=0
if uname -a|grep -q x86_64;then
  export x86_64=1
fi
for p in "" "/usr" "/usr/local" "$HOME" "$HOME/usr" "$HOME/usr/local";do
  if ! echo "$PATH"|grep -q -e "^$p/bin" -e ":$p/bin";then
    export PATH="$p/bin${PATH:+:$PATH}"
  fi
  if ! echo "$LD_LIBRARY_PATH"|grep -q -e "^$p/lib" -e ":$p/lib";then
    export LD_LIBRARY_PATH="$p/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
  fi
  if ! echo "$PYTHONPATH"|grep -q -e "^$p/lib" -e ":$p/lib";then
    export PYTHONPATH="$p/lib/python$p/lib:${PYTHONPATH:+:$PYTHONPATH}"
  fi
  if ! echo "$PKG_CONFIG_PATH"|grep -q -e "^$p/lib/pkgconfig" -e ":$p/lib/pkgconfig";then
    export PKG_CONFIG_PATH="$p/lib/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
  fi
  if [ "$x86_64" = 1 ];then
    if ! echo "$LD_LIBRARY_PATH"|grep -q -e "^$p/lib64" -e ":$p/lib64";then
      export LD_LIBRARY_PATH="$p/lib64${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
    fi
    if ! echo "$PKG_CONFIG_PATH"|grep -q -e "^$p/lib64/pkgconfig" -e ":$p/lib64/pkgconfig";then
      export PKG_CONFIG_PATH="$p/lib64/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
    fi
  fi
done
export GOPATH=$HOME/.go
# }}} Local path

# Shell/Environmental variables {{{
# Prompt
PS1="[\h \W]\$ "

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
if type -a vim >& /dev/null;then
  export VISUAL=vim
  export EDITOR=vim
fi
export PAGER=less

# Terminfo
if [ -d "$HOME/.terminfo/" ];then
  export TERMINFO=$HOME/.terminfo
elif [ -d "$HOME/usr/share/terminfo/" ];then
  export TERMINFO=$HOME/usr/share/terminfo
elif [ -d "$HOME/usr/share/lib/terminfo/" ];then
  export TERMINFO=$HOME/usr/share/lib/terminfo
elif [ -d /usr/share/terminfo/ ];then
  export TERMINFO=/usr/share/terminfo
elif [ -d /usr/share/lib/terminfo/ ];then
  export TERMINFO=/usr/share/lib/terminfo
fi

# For less
#export LESSCHARSET=utf-8
#ascii,dos,ebcdic,IBM-1047,iso8859,koi8-r,latin1,next

export LESS='-I -R -M -W -x2'
if type -a source-highlight >& /dev/null;then
  if type -a my_lesspipe >& /dev/null;then
    export LESSOPEN='| my_lesspipe %s'
  elif type -a src-hilite-lesspipe.sh >& /dev/null;then
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
if type -a bc >& /dev/null;then
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
# }}} shopt

# stty {{{
# Disable terminal lock
tty -s && stty stop undef
tty -s && stty start undef
[[ "$OSTYPE" =~ darwin ]] && tty -s && stty discard undef
# }}}

# History {{{
HISTSIZE=100000
HISTFILESIZE=100000
# HISTCONTROL:
# ignoredups # ignore duplication
# ignorespace # ignore command starting with space
# ignoreboth # ignore dups and space
# erasedups # erase a duplication in the past
export HISTCONTROL=erasedups
#export HISTIGNORE="?:??:???:????:history:cd ../"
export HISTIGNORE="cd:cd -:cd ../:ls:sd:cl*:pwd*:history"
#shopt -s histappend # append to hist (not overwrite),
                    # don't use with below share_history
export HISTTIMEFORMAT='%y/%m/%d %H:%M:%S  ' # add time to history
# Method to remove failed command {{{
#function history_remove_fail () {
#  local result=$?
#  if [ $result -ne 0 ];then
#    local n=`history 1|awk '{print $1}'`
#    if [ "x$n" != "x" ];then
#      history -d $n
#    fi
#  fi
#}
#PROMPT_COMMAND="${PROMPT_COMMAND:+${PROMPT_COMMAND};}history_remove_fail"
# }}}

# Method to share history at the same time,
# w/o failed command (bit too strong...) {{{
#shopt -u histappend # Overwrite
#function share_history () {
#  local result=$?
#  if [ $result -eq 0 ];then # put only when the command succeeded
#    history -a # append history to the file
#    history -c # remove current history
#    history -r # load history from the file
#  else
#    # don't put failed command
#    history -c
#    history -r
#  fi
#}
#PROMPT_COMMAND="${PROMPT_COMMAND:+${PROMPT_COMMAND};}share history"
# }}}

# Simple method to add history everytime {{{
PROMPT_COMMAND="${PROMPT_COMMAND:+${PROMPT_COMMAND};}history -a"
# }}}

# }}} history

# For ls color {{{
if [[ "$OSTYPE" =~ linux ]] || [[ "$OSTYPE" =~ cygwin ]];then
  # Linux
  if type -a dircolors >& /dev/null;then
    eval "$(dircolors ~/.colourrc)"
  fi
  if [ -z "$LS_COLORS" ];then
    source_file "$HOME/.lscolors"
  fi
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
if type -a colordiff >& /dev/null;then
  alias diff='colordiff'
fi
alias badlink='find -L . -depth 1 -type l -ls'
alias badlinkall='find -L . -type l -ls'
#alias g='gmake'
alias g='make'
alias gc="make clean"
alias gcg="make clean && make"
alias bc="bc -l"
alias ssh="ssh -Y"
alias svnHeadDiff="svn diff --revision=HEAD"
if type -a vim >& /dev/null;then
  alias svnd="svn diff | vim -"
  #alias vim="vim -X --startuptime $TMPDIR/vim.startup.log" # no X, write startup processes
  alias vim="vim -X" # no X
  alias vi="vim" # vi->vim
  alias memo="vim ~/.memo.md"
  alias vid="vim -d"
  alias vinon="vim -u NONE"
fi
alias grep="grep --color=auto -s"
#alias c="multi_clipboard -W"
alias put='multi_clipboard -x'
alias del="trash -r"
# shellcheck disable=SC2142
alias hischeck="history|awk '{print \$4}'|sort|uniq -c|sort -n"
# shellcheck disable=SC2142
alias hischeckarg="history|awk '{print \$4\" \"\$5\" \"\$6\" \"\$7\" \"\$8\" \"\$9\" \"\$10}'|sort|uniq -c|sort -n"
alias sort='LC_ALL=C sort'
alias uniq='LC_ALL=C uniq'
alias t='less -L +F'
alias iocheck='find /proc -name io |xargs egrep "write|read"|sort -n -k 2'
alias now='date +"%Y%m%d %T"'
alias pip_upgrade="pip list --outdated --format=legacy|cut -d' ' -f1|xargs pip install -U"
if type -a thefuck >& /dev/null;then
  alias fuck='eval $(thefuck $(fc -ln -1))'
fi
if type -a hub >& /dev/null;then
  eval "$(hub alias -s)" # Use GitHub wrapper for git
fi
#alias evernote_mail="evernote_mail -u"
alias stow="stow --override='share/info/dir'"

# pseudo tree
if ! type -a tree >& /dev/null;then
  alias tree="pwd && find . | sort | sed '1d;s,[^/]*/,|    ,g;s/..//;s/[^ ]*$/|-- &/'"
fi

function md2pdf () { # pandoc helper {{{
  if [[ "$OSTYPE" =~ darwin ]];then
    if ! type -a iconv >& /dev/null;then
      echo "Please install iconv"
      return 1
    fi
  fi
  if ! type -a pandoc >& /dev/null;then
    echo "Please install pandoc"
    return 1
  fi

  if [ $# -eq 0 ];then
    echo "usage mdtopdf [output.pdf] [-t <theme>] input.md "
    return 1
  fi
  input=""
  output=""
  theme="-V theme:Singapore"
  istheme=0
  for v in "$@";do
    if [ $istheme -eq 1 ];then
      theme="-V $v"
      istheme=0
    elif [ "$v" = "-t" ];then
      istheme=1
    elif [[ "$v" =~ \.md ]];then
      input=$v
    elif [[ "$v" =~ \.pdf ]];then
      output=$v
    else
      echo "usage mdtopdf [output.pdf] [-t <theme>] input.md "
      return 1
    fi
  done
  if [ -z "$input" ];then
    echo "usage mdtopdf [output.pdf] [-t <theme>] input.md "
    return 1
  fi
  output=${output:-${input%.md}.pdf}
  if [[ "$OSTYPE" =~ darwin ]];then
    cmd="iconv -t UTF-8 $input | \
      pandoc -t beamer -f markdown -o $output $theme --latex-engine=lualatex"
  else
    cmd="pandoc -t beamer $theme --latex-engine=lualatex \
      $input -o $output"
  fi
  echo "$cmd"
  eval "$cmd"
} # }}}

function mynoglob_helper () { # noglob helpers {{{
  "$@"
  case "$shopts" in
    *noglob*)
      ;;
    *)
      set +f
      ;;
  esac
  unset shopts
}
alias mynoglob='shopts="$SHELLOPTS";set -f;mynoglob_helper'
# }}}

function man () { # man wrapper {{{
  if [ $# -ne 1 ] || [[ "$1" =~ ^- ]];then
    command man "$@"
    return $?
  fi
  local p
  local m
  if [ "$PAGER" != "" ];then
    p="$PAGER"
  fi
  if [ "$MANPAGER" != "" ];then
    m="$MANPAGER"
  fi
  unset PAGER
  unset MANPAGER
  val=$(command man "$@" 2>&1)
  ret=$?
  if [ $ret -eq 0 ];then
    if type -a vim >& /dev/null;then
      echo "$val"|col -bx|vim -R -c 'set ft=man' -
    else
      command man "$@"
    fi
  else
    echo "$val"
  fi
  if [ "$p" != "" ];then
    export PAGER="$p"
  fi
  if [ "$m" != "" ];then
    export MANPAGER="$m"
  fi
  return $ret
} # }}}

function change () { # Change words in file by sed {{{
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
}
# }}}

function del_tail () { # Delete trailing white space {{{
  sed -i.bak 's/ \+$//g' "$1"
  rm -f "$1".bak
}
# }}}

# tar/press: File compression/decompression {{{
alias targz="tar zxf"
alias tarbz2="tar jxf"
alias tarxz="tar Jxf"
alias tarZ="tar zxf"

function press () {
  local remove=0
  local HELP="
  usage: press [-r] directory_name [package_name]

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

#function lw () {# Show output result with w3m {{{
#  sed -e 's/</\&lt;/g' |\
#  sed -e 's/>/\&gt;/g' |\
#  sed -e 's/\&/\&amp;/g' |\
#  sed -e 's/[^:]*/<a href="\0">\0<\/a>/' |\
#  sed -e 's/$/<br\/>/' |\
#  EDITOR='vi' w3m -T text/html
#}
# }}}

## emacs wrapper {{{
#function emacs () { command emacs $@ & }
# }}}

function path () { # path: function to get full path {{{
  if [ $# -eq 0 ];then
      echo "usage: path file/directory"
      return 1
  fi
  echo "$(cd "$(dirname "$1")";pwd -P)/$(basename "$1")"
} # }}}

## sd/cl: Directory save/move in different terminal {{{
source_file ~/usr/etc/sd_cl
# }}}

function col256 () { # Show 256 colors{{{
  for c in {0..255};do
    local num=$(printf " %03d" $c)
    printf "\e[38;5;%sm$num\e[m" "$c"
    printf "\e[48;5;%sm$num\e[m" "$c"
    if [ $((c%8)) -eq 7 ];then
      echo
    fi
  done
} # }}}

function calc () { # Function to calculate with perl (for decimal, etc...) {{{
  local eq=$(echo "$@"|sed "s/\^/**/g")
  printf "\$xx =%s;print \"\$xx \\n\"" "$eq"|perl
} # }}}

function linkcheck () { # Function to find the original file for the symbolic link {{{
  if [ "$#" -ne 1 ];then
    echo "Usage: linkcheck file/directory" >2
    return 1
  fi

  link="$1"
  while :;do
    if [ -L "$link" ];then
      link=$(readlink "$link")
    else
      echo "$link"
      return 0
    fi
  done
} # }}}

# dictionary {{{
function weblio () {
  if ! type -a w3m >& /dev/null;then
    echo "Please install w3m"
    return 1
  fi
  if [ "$#" -eq 0 ];then
    echo "usage: $0 [option] <word>"
    echo "options: -m (show meanings), -e (show examples)"
    echo "If no option is given, show the result page with w3m."
  fi
  local flag=""
  if [ "$#" -gt 1 ];then
    if [ "$1" = "-m" ];then
      flag="meaning"
      shift
    elif [ "$1" = "-e" ];then
      flag="example"
      shift
    fi
  fi
  if [ -z "$flag" ];then
    w3m "http://ejje.weblio.jp/content/$1"
    return $?
  fi
  local page=$(w3m "http://ejje.weblio.jp/content/$1")
  if [ "$flag" = "meaning" ];then
    local start=($(printf "$page"|grep -n "主な意"|cut -d: -f1))
    local end=($(printf "$page"|grep -n "イディオムやフレーズ"|cut -d: -f1))
    if [ -z "${start[0]}" ] || [ -z "${end[0]}" ];then
      echo "No result found (always no result for Japanese)."
      return 1
    fi
    printf "$page"|sed -n $((start[0]+3)),$((end[0]))p
  elif [ "$flag" = "example" ];then
    local start=($(printf "$page"|grep -n "を含む例文一覧"|cut -d: -f1))
    local end=($(printf "$page"|grep -n "例文の一覧を見る自分の例文帳を見る"|cut -d: -f1))
    if [ -z "${start[0]}" ] || [ -z "${end[0]}" ];then
      echo "No result found (always no result for Japanese)."
      return 1
    fi
    printf "$page"|sed -n $((start[0]+6)),$((end[0]-2))p|sed "s/ 例文帳に追加//g"
  fi
}
function alc () {
  if ! type -a w3m >& /dev/null;then
    echo "Please install w3m"
    return 1
  fi
  if [ "$#" -eq 0 ];then
    echo "usage: $0 [option] <word>"
    echo "options: -m (show meanings), -e (show examples)"
    echo "If no option is given, show the result page with w3m."
  fi
  local flag=""
  if [ "$#" -gt 1 ];then
    if [ "$1" = "-m" ];then
      flag="meaning"
      shift
    elif [ "$1" = "-e" ];then
      flag="example"
      shift
    fi
  fi
  if [ -z "$flag" ];then
    w3m "http://eow.alc.co.jp/search?q=$1"
    return $?
  fi
  local page=$(w3m "http://eow.alc.co.jp/search?q=$1")
  if printf "$page"|grep -q "該当する項目は見つかりませんでした。";then
    printf "$page"|grep "該当する項目は見つかりませんでした。"
    return 2
  fi
  local next_lines=($(printf "$page"|grep -n "次へ"|cut -d: -f1))
  local start=(${next_lines[0]})
  local end=(${next_lines[1]})
  if [ -z "${start[0]}" ];then
    local start=($(printf "$page"|grep -n "英辞郎データ提供元 EDP のサイトへ"|cut -d: -f1))
    if [ -z "${start[0]}" ];then
      echo "No result found."
      return 3
    fi
  fi
  if [ "$flag" = "meaning" ];then
    local lines2=($(printf "$page"|grep -n "単語帳"|cut -d: -f1))
    if [ -z "${lines2[0]}" ];then
      echo "No result found."
      return 4
    fi
    printf "$page"|sed -n $((start[0]+2)),$((lines2[0]-1))p
  elif [ "$flag" = "example" ];then
    if [ -z "${end[0]}" ];then
      printf "$page"|grep -n "単語帳"|tail -n1|cut -d: -f1
      local end=($(printf "$page"|grep -n "単語帳"|tail -n1|cut -d: -f1))
    fi
    if [ -z "${end[0]}" ];then
      echo "No result found."
      return 5
    fi
    printf "$page"|sed -n $((start[0]+2)),$((end[0]-1))p
  fi
}
function dic () {
  alc -e "$1"|less
}
# }}}

# For GNU-BSD compatibility {{{

# cp wraper for BSD cp (make it like GNU cp){{{
# Remove the end "/" and change -r to -R
if ! cp --version 2>/dev/null |grep -q GNU;then
  function cp () {
    local -a opt
    opt=()
    local -a vals
    vals=()
    while [ $# -gt 0 ];do
      if [[ "$1" == -* ]];then
        if [ "$1" == "-r" ];then
          opt=("${opt[@]}" -R)
        else
          opt=("${opt[@]}" $1)
        fi
      else
        vals=("${vals[@]}" ${1%/})
      fi
      shift
    done
    command cp "${opt[@]}" "${vals[@]}"
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
if ! type -a tac >& /dev/null;then
  if ! tail --version 2>/dev/null|grep -q GNU;then
    alias tac='tail -r'
  else
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
# }}}

# }}} For GNU-BSD compatibility

# Suffix aliases/auto cd {{{
if [ "${BASH_VERSINFO[0]}" -ge 4 ];then
  _suffix_vim=(md markdown txt text tex cc c C cxx h hh java py rb sh)
  alias_function() {
    eval "${1}() $(declare -f "${2}" | sed 1d)"
  }
  if ! type -a orig_command_not_found_handle >& /dev/null;then
    if type -a command_not_found_handle >& /dev/null;then
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
        if type -a vim >& /dev/null;then
          vim "${args[@]}"
          return $?
        fi
      elif [ "${cmd##*.}" = "ps1" ];then
        if type -a powershell >& /dev/null;then
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
