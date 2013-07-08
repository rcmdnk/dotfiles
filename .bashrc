# .bashrc

# Check if this is first time to read bashrc or not {{{
# (subshell, screen, etc...)
if [ ! "$INIT_PATH" ];then
  # Set initial values of PATH, LD_LIBRARY_PATH, PYTHONPATH
  export INIT_PATH=$PATH
  export INIT_LD_LIBRARY_PATH=$LD_LIBRARY_PATH
  export INIT_PYTHONPATH=$PYTHONPATH
else
  # Reset paths
  export PATH=$INIT_PATH
  export LD_LIBRARY_PATH=$INIT_LD_LIBRARY_PATH
  export PYTHONPATH=$INIT_PYTHONPATH
fi
# }}} Check if this is first time to read bashrc or not

# Function for sourcing with precheck of the file {{{
function source_file() {
  if [ $# -lt 1 ];then
    echo "ERROR!!! source_file is called w/o an argument"
    return
  fi
  arg=$1
  shift
  if [ -r $arg ]; then
    source $arg
  fi
} # }}} Function for sourcing with precheck of the file

# Source global definitions {{{
#source_file /etc/bashrc
# Remove the last ";" from PROMPT_COMMAND
# Necessary for Mac Terminal.app
PROMPT_COMMAND=`echo ${PROMPT_COMMAND}|sed 's/;$//'`
# }}}

# Local path {{{
# PATH, LD_LIBRARY_PATH under HOME
export PATH=$HOME/usr/local/bin:$HOME/usr/bin:/usr/local/bin:/usr/bin:$PATH
export LD_LIBRARY_PATH=$HOME/usr/local/lib:$HOME/usr/lib:/usr/local/lib:/usr/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$HOME/usr/local/lib:$HOME/usr/lib/python:/usr/local/lib:/usr/lib/python:$PYTHONPATH
#export PYTHONHOME=$HOME/usr/lib/python:$HOME/usr/local/lib:$PYTHONPATH

#For MacVim
if [[ "$OSTYPE" =~ "darwin" ]] && [ -d /Applications/MacVim.app/Contents/MacOS ];then
  export PATH=/Applications/MacVim.app/Contents/MacOS:$PATH
fi

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# }}} Local path

# Shell/Environmental variables {{{
# Prompt
PS1="\[\e]0;\u@\h\w\a\][\h \W]\$ "

# XMODIFIERS
#export XMODIFIERS="@im=kinput2"

# Lang
#export LANG=C
export LANG="en_GB.UTF-8"
#export LANG="en_US.UTF-8"
#export LANG="ja_JP.eucJP"
#export LANG="ja_JP.UTF-8"
#export LC_ALL="ja_JP.UTF-8"
export LC_ALL="en_GB.UTF-8"
#export LC_MESSAGES="en_GB.UTF-8"
#export LC_DATE="en_GB.UTF-8"

# Editors
export VISUAL=vim
export EDITOR=vim
export PAGER=less

# Terminfo
export TERMINFO=/usr/share/terminfo

# For less
#export LESSCHARSET=utf-8
#ascii,dos,ebcdic,IBM-1047,iso8859,koi8-r,latin1,next

# Python
export PYTHONSTARTUP=~/.pythonstartup.py

# Trash
export TRASHLIST=~/.trashlist # Where trash list is written
export TRASHBOX=~/.Trash # Where trash will be moved in
                         # (.Trash is Mac's trash box)
export MAXTRASHBOXSIZE=1024 # Max trash box size in MB
                            # Used for clean up
if type bc >& /dev/null;then
  export MAXTRASHSIZE=`echo $MAXTRASHBOXSIZE "*" 0.1|bc -l|cut -d. -f1`
else
  export MAXTRASHSIZE=100
fi
# Trashes larger than MAXTRASHBOXSIZE will be removed by 'rm' directly

# For my clipboards
export CLIPBOARD=$HOME/.clipboard
export CLMAXHIST=20
export CLSEP="" # (C-v C-g) Use bell as a separator
export CLX="" #xsel/xclip
if [[ "$OSTYPE" =~ "linux" ]];then
  if type xsel >& /dev/null;then
    export CLXOS="xsel"
  elif type xsel >& /dev/null;then
    export CLXOS="xclip"
  fi
elif [[ "$OSTYPE" =~ "cygwin" ]];then
  if type putclip >& /dev/null;then
    export CLXOS="putclip"
  elif type xsel >& /dev/null;then
    export CLXOS="xsel"
  elif type xsel >& /dev/null;then
    export CLXOS="xclip"
  fi
elif [[ "$OSTYPE" =~ "darwin" ]];then
  if type pbcopy >& /dev/null;then
    export CLXOS="pbcopy"
    #export CLX=$CLXOS
  fi
fi

#export GREP_OPTIONS='--color=auto'
#export LESS='-R'

# }}} Environmental variables

# shopt {{{
shopt -s cdspell # Minor error for cd is corrected
shopt -s checkhash # Check hash before execute command in hash
#shopt -s dotglob # Include dot files in the results of pathname expansion
shopt -s histreedit # Enable to re-edit a failed history
#shopt -s histverify # Allow further modification of history
shopt -s no_empty_cmd_completion # Don't complete for an empty line
shopt -u checkwinsize # Disable to update the window size
# }}} shopt

# History {{{
HISTSIZE=10000
# HISTCONTROL:
# ignoredups # ignore duplication
# ignorespace # ignore command starting with space
# ignoreboth # ignore dups and space
# erasedups # erase a duplication in the past
export HISTCONTROL=ignoredups:erasedups
export HISTIGNORE="?:??:???:jobs:fg*:bg*:history:cd ../"
shopt -s histappend # append to hist (not overwrite),
                    # don't use with below share_history
export HISTTIMEFORMAT='%y/%m/%d %H:%M:%S  ' # add time to history
# Method to remove failed command {{{
#function histRemoveFail {
#  local result=$?
#  if [ $result -ne 0 ];then
#    local n=`history 1|awk '{print $1}'`
#    if [ "x$n" != "x" ];then
#      history -d $n
#    fi
#  fi
#}
#PROMPT_COMMAND="${PROMPT_COMMAND:+${PROMPT_COMMAND};}histRemoveFail"
# }}}

# Method to share history at the same time,
# w/o failed command (bit too strong...) {{{
#shopt -u histappend # Overwrite
#function share_history {
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
if [[ "$OSTYPE" =~ "linux" ]] || [[ "$OSTYPE" =~ "cygwin" ]];then
  # Linux
  eval `dircolors ~/.colourrc`
  if [ "$LS_COLORS" = "" ];then
    source_file $HOME/.lscolors
  fi
elif [[ "$OSTYPE" =~ "darwin" ]];then
  # Mac
  export LSCOLORS=DxgxcxdxCxegedabagacad
fi
# }}} For ls color

# Alias, Function {{{
alias l='/bin/ls'
if [[ "$OSTYPE" =~ "linux" ]] || [[ "$OSTYPE" =~ "cygwin" ]];then
  alias ls='ls --color=auto --show-control-char'
  alias la='ls -a --color=auto --show-control-char'
elif [[ "$OSTYPE" =~ "darwin" ]];then
  alias ls='ls -G'
  alias la='ls -a -G'
fi
alias badlink='find -L . -depth 1 -type l -ls'
#alias g='gmake'
alias g='make'
alias gc="make clean"
alias gcg="make clean && make"
alias bc="bc -l"
alias ssh="ssh -X"
alias svnHeadDiff="svn diff --revision=HEAD"
#alias vim="vim -X --startuptime $TMPDIR/vim.startup.log" # no X, write startup processes
alias vim="vim -X" # no X
alias vi="vim -X" # vi->vim,no X
alias memo="vim -X ~/.memo.md"
alias vid="vim -X -d"
#alias grep="grep --color=always"
alias c="multi_clipboards"
alias put='multi_clipboards -x'
alias del="trash -r"

# noglob helpers {{{
function mynoglob_helper {
  "$@"
  case $shopts in
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

# Change words in file by sed{{{
function change {
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

# Delete trailing white space {{{
function del_tail {
  sed -i.bak 's/ \+$//g' $1
  rm -f "$1".bak
}
# }}}

# File compression/decompression {{{
alias targz="tar xzf"
alias tarbz2="tar jxf"

function press {
  local remove=0
  local HELP="
  usage: press [-r] directory_name [package_name]

         -r for remove original directory
         if package_name is not given, it makes file:
         directory_name.tar.gz
"
  if [ $# -eq 0 ];then
    echo $help
  elif [ "$1" = "-d" ];then
    remove=1
    shift
  fi
  local dir=${1%/*}
  case "$#" in
          0)
    echo $HELP
    ;;
          1)
    echo ${dir}
    tar czf ${dir}.tar.gz ${dir}
    ;;
          2)
    tar czf ${2} ${dir}
    ;;
  esac
  if [ $remove -eq 1 ];then
    rm -rf ${dir}
  fi
}
# }}}

# cd wrapper to use pushd {{{
function cd {
  if [ "$1" = "-" ];then
    local opwd=$OLDPWD
    pushd . >/dev/null
    command cd $opwd
  elif [ -f "$1" ];then
    pushd . >/dev/null
    command cd $(dirname "$@")
  else
    pushd . >/dev/null
    command cd "$@"
  fi
}
# }}}

# Alias for popd {{{
alias bd="popd >/dev/null"
# }}}

# Move to actual pwd {{{
function cdpwd {
  cd -P .
}
# }}}

## Show output result with w3m {{{
#function lw {
#  sed -e 's/</\&lt;/g' |\
#  sed -e 's/>/\&gt;/g' |\
#  sed -e 's/\&/\&amp;/g' |\
#  sed -e 's/[^:]*/<a href="\0">\0<\/a>/' |\
#  sed -e 's/$/<br\/>/' |\
#  EDITOR='vi' w3m -T text/html
#}
# }}}

## emacs wrapper {{{
#function emacs { command emacs $@ & }
# }}}

## SimpleNote {{{
#alias sn='vim -c "call Sn()"'
## }}}

# path: function to get full path {{{
function path {
  if [ $# -eq 0 ];then
      echo "usage: path file/directory"
      return 1
  fi
  echo "$(cd "$(dirname $1)";pwd -P)/$(basename $1)"
} # }}}

## Directory save/move in different terminal {{{
# Directory store file
export LASTDIRFILE=$HOME/.lastDir
# Number of store directories
export NLASTDIR=20

function sd { # Save dir {{{
  # Set values
  local ldf=${LASTDIRFILE:-$HOME/.lastDir}
  local nld="${NLASTDIR:-20}"

  # Get last directories
  touch $ldf
  local orig_ifs=$IFS
  IFS=$'\n'
  local dirs=(`cat $ldf`)
  IFS=$orig_ifs
  local ld=${dirs[0]}

  # Push current directory
  local curdir=`pwd -P`
  if [ "$ld" != "$curdir" ];then
    dirs=("$curdir" "${dirs[@]}")
  fi

  # Store directories
  local i=0
  rm -f $ldf
  while [ $i -lt ${#dirs[@]} ] && [ $i -lt $NLASTDIR ];do
    echo ${dirs[$i]} >> $ldf
    i=$((i+1))
  done
} # }}}

function cl { # Change directory to the Last directory {{{
  local HELP="
  Usage: cl [-lch] [-n <number> ]
  If there are no arguments, you will move to the last saved dirctory

  Arguments:
     -l              Show saved directories
     -c              Show saved directories and choose a directory
     -n              Move to <number>-th last directory
     -h              Print this HELP and exit
"

  # Set values
  local ldf=${LASTDIRFILE:-$HOME/.lastDir}

  # Initialize variables
  local nth=0
  local list=0
  local choice=0

  # OPTIND must be reset in function
  local optind_tmp=$OPTIND
  OPTIND=1

  # Get option
  while getopts cln:h OPT;do
    case $OPT in
      "c" ) choice=1 ;;
      "l" ) list=1 ;;
      "n" ) nth="$OPTARG" ;;
      "h" ) echo "$HELP" 1>&2;OPTIND=$optind_tmp;return ;;
      * ) echo "$HELP" 1>&2;OPTIND=$optind_tmp;return ;;
    esac
  done
  shift $(($OPTIND - 1))
  OPTIND=$optind_tmp

  # Get last directories
  touch $ldf
  local orig_ifs=$IFS
  IFS=$'\n'
  local dirs=(`cat $ldf`)
  IFS=$orig_ifs
  local ld=${dirs[0]}

  # List up and choose directory
  if [ $choice -eq  1 ] || [ $list -eq 1 ];then
    # List up stored directories
    local listnum=${#dirs[@]}
    local i=$((listnum-1))
    while [ $i -ge 0 ];do
      printf "%4d %s %4d\n" $i ${dirs[$i]} $i
      i=$((i-1))
    done

    # Choose from STDIN
    if [ $choice -eq 1 ];then
      echo -n "choose directory number: "
      read nth
    fi
  fi

  # Check nth
  if ! echo $nth|grep -q "^[0-9]\+$" || [ "$nth" -ge "${#dirs[*]}" ];then
    echo "Wrong number was given"
    return 1
  fi

  # Change directory
  if [ $list != 1 ];then
    cd ${dirs[$nth]}
  fi
} # }}}
# }}}

# git functions {{{
function gitupdate {
  update=0
  difffiles=`git diff|grep diff|cut -d' ' -f4|cut -d'/' -f2`
  if [ "$difffiles" ];then
    pwd
    if [ -f ~/.gitavoid ];then
      #while read a;do
      #  if ret=`grep -i -q $a $difffiles`;then
      #    echo "avoid word $a is included!!!"
      #    echo $ret
      #    return
      #  fi
      #done < ~/.gitavoid
      for f in `git ls-files`;do
        if [ ! -f $f ];then
          continue
        fi
        while read a;do
          if ret=`grep -i -q $a $difffiles`;then
            echo "avoid word $a is included!!!"
            echo $ret
            return
          fi
        done
      done < ~/.gitavoid
    else
      echo "WARNING: There is no ~/.gitavoid file!"
    fi
    printf "\n"
    update=1
  fi
  ret=`git commit -a -m "$difffiles, from $OSTYPE"`
  if echo $ret|grep -q "changed";then
    if [ $update -eq 0 ];then
      pwd
    fi
    echo $ret
    update=1
  fi

  #ret=$(git pull --rebase)
  ret=$(git pull)
  if [ "$(echo $ret|grep "Already up-to-date")" == "" ] &&\
     [ "$(echo $ret|grep "is up to date")" == "" ];then
    if [ $update -eq 0 ];then
      pwd
    fi
    echo $ret
    update=1
  fi
  ret=$(git push 2>&1)
  if ! echo $ret|grep -q "Everything up-to-date";then
    if [ $update -eq 0 ];then
      pwd
    fi
    echo $ret
  fi

  git gc >& /dev/null
}
# }}}

# man wrapper{{{
function man {
  # Open man file with vim
  # col -b -x: remove backspace, replace tab->space
  # vim -R -: read only mode, read from stdin
  if [ $# -eq 0 ];then
    command man
  else
    # If there are any -* arguments,
    # use original man
    for m in $@;do
      if [[ $m =~ ^- ]];then
        command man $@
        return
      fi
    done
    # Then open each manual
    for m in $@;do
      if command man -W $m >&  /dev/null;then
        LANG=C command man $@|col -b -x|vim -R -
      else
        command man $@
      fi
    done
  fi
}
#alias man='LANG=C man'
# }}}

# Show 256 colors{{{
function col256 {
  for c in {0..255};do
    local num=`printf " %03d" $c`
    printf "\e[38;5;${c}m$num\e[m"
    printf "\e[48;5;${c}m$num\e[m"
    if [ $(($c%8)) -eq 7 ];then
      echo
    fi
  done
} # }}}

# Function to calculate with perl (for decimal, etc...) {{{
function calc {
  local HELP="
   usage: calc num1 (add, sub, mul or div) num2
      or: calc num1 rem num2 (num1%num2)
      or: calc num1 sqrt (root num1)
      or: calc num1 sqr (num1*num1)
      or: calc num1 comp num2 (retun->num1>num2:1,num1=num2:0,num1<num2:-1)
      or: calc num1 to num2 (num1^num2)
      or: calc num1 (+, -, \* or /) num2
  notice: you must use \"*\" or \* instead of asterisk only
"
  if [ "$#" -lt 2 ];then
    echo "$HELP"
    return
  fi

  case $2 in
    "add")
       echo -n '$xx = '$1' + '$3';print "$xx \n"'|perl
    ;;
    "+")
       echo -n '$xx = '$1' + '$3';print "$xx \n"'|perl
    ;;
    "sub")
       echo -n '$xx = '$1' - '$3';print "$xx \n"'|perl
    ;;
    "-")
       echo -n '$xx = '$1' - '$3';print "$xx \n"'|perl
    ;;
    "mul")
       echo -n '$xx = '$1' * '$3';print "$xx \n"'|perl
    ;;
    "*")
       echo -n '$xx = '$1' * '$3';print "$xx \n"'|perl
    ;;
    "div")
       echo -n '$xx = '$1' / '$3';print "$xx \n"'|perl
    ;;
    "/")
       echo -n '$xx = '$1' / '$3';print "$xx \n"'|perl
    ;;
    "sqrt")
       local flag=`echo '$xx = '$1' <=> 0;print "$xx \n"'|perl`
       if [ $flag -eq -1 ];then
         echo -n 0
       else
         echo -n '$xx = sqrt '$1';print "$xx \n"'|perl
       fi
    ;;
    "sqr")
       echo -n '$xx = '$1' ** '2';print "$xx \n"'|perl
    ;;
    "comp")
       echo -n '$xx = '$1' <=> '$3';print "$xx \n"'|perl
    ;;
    "to")
       echo -n '$xx = '$1' ** '$3';print "$xx \n"'|perl
    ;;
    "rem")
       echo -n '$xx = '$1' % '$3';print "$xx \n"'|perl
    ;;
    *)
       echo "$HELP"
    ;;
  esac
} # }}}

# For GNU-BSD compatibility {{{

# cp wraper for BSD cp (make it like GNU cp){{{
# Remove the end "/" and change -r to -R
if ! cp --version 2>/dev/null |grep -q GNU;then
  function cp {
    local opt=""
    local source=""
    local dest=""
    while [ $# -gt 0 ];do
      if [[ "$1" == -* ]];then
        if [ "$1" == "-r" ];then
          opt="$opt -R"
        else
          opt="$opt $1"
        fi
      elif [ $# -eq 1 ];then
        dest="$1"
      else
        source="${source} ${1%/}"
      fi
      shift
    done
    command cp $opt $source $dest
  }
fi
# }}}

# Use common function in Mac/Unix for sed -i... w/o backup {{{
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

# Revert lines in the file/std input
# Note: There is "rev" command which
#       reversing the order of characters in every line.
# Set reverse command
if ! type tac >/dev/null 2>&1;then
  alias revlines="tac"
elif ! tail --version 2>/dev/null |grep -q GNU;then
  alias revlines="tail -r"
fi

# }}}

# }}} Alias, Function

# stty {{{
# Disable terminal lock
tty -s && stty stop undef
tty -s && stty start undef
if [[ "$OSTYPE" =~ "darwin" ]];then
  tty -s && stty discard undef
fi
# }}}

# For screen {{{
alias screenr="screen -r"

# Screen wrapper {{{
function screen {
  # Tips of screen for a cluster
  # This setting keeps the host name in which screen is running
  # for a case in the cluster,
  # in which the host can be changed at every login
  #
  #touch .hostForScreen
  #if [ $# = 0 ] || [ $1 = "-r" ] || [ $1 = "-R" ] || [ $1 = "-x" ];then
  #  sed -i -e "/^$(hostname).*/d" .hostForScreen
  #  hostname >> ~/.hostForScreen
  #  # keep 10 histories
  #  #tail -n10 ~/.hostForScreen > ~/.hostForScreen.tmp
  #  #mv ~/.hostForScreen.tmp ~/.hostForScreen
  ## write out DISPLAY of current terminal
  #  echo "$DISPLAY"> ~/.display.txt
  #fi

  options="$@"
  if [ $# = 0 ];then
    # Don't make another screen session
    options="-R"
  fi

  # launch screen
  command screen $options
}
# }}}

## Function to check remaining screen sessions in a cluster{{{
#function screen_check {
#  touch .hostForScreen
#  for h in `cat ~/.hostForScreen`;do
#    echo "checking $h..."
#    ping $h -c 2 -w2 >& /dev/null
#    if [ $? -eq 0 ];then
#      local checklog="$(ssh -x $h "screen -ls")"
#      echo $checklog
#      if ! echo $checklog|grep -q "No Sockets found";then
#        echo $h >> ~/.hostForScreen.tmp
#      fi
#    else
#      echo $h seems not available
#    fi
#  done
#  touch ~/.hostForScreen.tmp
#  mv ~/.hostForScreen.tmp ~/.hostForScreen
## }}}

## ssh to the host which launched screen previously {{{
#function sc {
#  touch .hostForScreen
#  local n=1
#  if [ $# -ne 0 ];then
#    n=$1
#  fi
#  local schost=`tail -n$n ~/.hostForScreen|head -n1`
#  if [ "$schost" == "" ];then
#    echo "no host has remaining screen"
#  else
#    ssh $schost
#  fi
#} # }}}

# screen exchange file
export SCREENEXCHANGE=$HOME/.screen-exchange

# Following functions/alias are also enabled before screen {{{

# Overwrite path to push to the clipboard list{{{
function path {
  if [ $# -eq 0 ];then
      echo "usage: path file/directory"
      return 1
  fi
  fullpath="$(cd "$(dirname $1)";pwd -P)/$(basename $1)"
  echo $fullpath
  multi_clipboards -s $fullpath
} # }}}

# pwd wrapper (named as wc) to push pwd to the clipboard list{{{
function wd {
  local curdir=`pwd`
  multi_clipboards -s $curdir
  echo $curdir
}
# }}}

# }}} Following functions/alias are also enabled before screen

# functions/settings only for screen sessions {{{

export SCREEN_PS1="(-_-) $ " # used for screen command in .screenrc
if [[ "$TERM" =~ "screen" ]]; then # {{{
  # "\\" doesn't work well, use \134 instead
  PS1="\[\ek\h \W\e\134\e]0;\h \w\a\]\$(\
    ret=\$?
    rand=\$((RANDOM%36));\
    if [ \$ret -eq 0 ];then\
      if [ \$rand -lt 3 ];then
        printf '\[\e[m\](^_^)\[\e[m\] \$ ';\
      elif [ \$rand -lt 5 ];then\
        printf '\[\e[m\](^_-)\[\e[m\] \$ ';\
      elif [ \$rand -lt 6 ];then\
        printf '\[\e[m\](.^.)\[\e[m\] \$ ';\
      else\
        printf '\[\e[m\](-_-)\[\e[m\] \$ ';\
      fi;\
    else\
      if [ \$rand -lt 6 ];then\
        printf '\[\e[31m\](@o@)\[\e[m\] \$ ';\
      elif [ \$rand -lt 12 ];then\
        printf '\[\e[31;1m\](>_<)\[\e[m\] \$ ';\
      elif [ \$rand -lt 18 ];then\
        printf '\[\e[35m\](*_*)\[\e[m\] \$ ';\
      elif [ \$rand -lt 24 ];then\
        printf '\[\e[34m\](T_T)\[\e[m\] \$ ';\
      elif [ \$rand -eq 30 ];then\
        printf '\[\e[34;1m\](/_T)\[\e[m\] \$ ';\
      else\
        printf '\[\e[31m\](>_<)\[\e[m\] \$ ';\
      fi\
    fi;\
    )"
  # }}}

  # Set display if screen is attached in other host than previous host {{{
  function set_display {
    if [ -f ~/.display.txt ];then
      #local d=`grep $HOSTNAME ~/.display.txt|awk '{print $2}'`
      local d=`cat ~/.display.txt`
      export DISPLAY=$d
    fi
  }
  # }}}

fi # }}}

# }}} For screen

# Setup for each environment {{{
# Note: such PATH setting should be placed
#       at above Local path settings (before alias/function definitions)

# File used in linux
if [[ "$OSTYPE" =~ "linux" ]];then
  source_file ~/.linux.sh
fi

# File used in mac
if [[ "$OSTYPE" =~ "darwin" ]];then
  source_file ~/.mac.sh
fi

# File used in windows (cygwin)
if [[ "$OSTYPE" =~ "cygwin" ]];then
  source_file ~/.win.sh
fi

# File used for working server
source_file ~/.work.sh

# File for special settings for each machine
source_file ~/.local.sh

# }}} Setup for each environment
