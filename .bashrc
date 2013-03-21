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
  if [ -f $arg ]; then
    source $arg
  fi
} # }}} Function for sourcing with precheck of the file

# Source global definitions {{{
source_file /etc/bashrc
# }}}

# Environmental variables {{{
# Prompt
#export PS1="[\u@\h \W]\$ "
export PS1="\[\e]0;\u@\h\w\a\][\h \W]\$ "

# XMODIFIERS
export XMODIFIERS="@im=kinput2"

# Lang
#export LANG=C
export LANG="en_GB.UTF-8"
#export LANG="en_US.UTF-8"
#export LANG=ja_JP.eucJP
#export LANG=ja_JP.UTF-8

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
export TRASH=~/.Trash
export MAXTRASHSIZE=1024 #MB

# For my clipboards
export CLIPBOARD=$HOME/.clipboard/
export CLMAXHIST=20
export MYCL="" #xsel/xclip

# }}} Environmental variables

# shopt {{{
shopt -s cdspell # minor error for cd is corrected
shopt -s checkhash # check hash before execute command in hash
#shopt -s dotglob # include dot files in the results of pathname expansion
shopt -s histreedit # enable to re-edit a failed history
#shopt -s histverify # allow further modification of history
shopt -s no_empty_cmd_completion # don't complete for an empty line
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
#export PROMPT_COMMAND="${PROMPT_COMMAND:+${PROMPT_COMMAND};}histRemoveFail"
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
#export PROMPT_COMMAND="${PROMPT_COMMAND:+${PROMPT_COMMAND};}share history"
# }}}

# Simple method to add history everytime {{{
#export PROMPT_COMMAND="${PROMPT_COMMAND:+${PROMPT_COMMAND};}history -a"
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
#alias grep="grep --color=always"
#export GREP_OPTIONS='--color=auto'
#export LESS='-R'

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

# Use trash box {{{
function trash {
  if [ ! "$TRASH" ];then
    echo "please set TRASH"
    return
  fi
  if [ "$#" -lt 1 ]
  then
    echo "enter junk files or directories"
  else
    if [ ! -d $TRASH ];
    then
      mkdir -p $TRASH
    fi

    while [ "$#" -gt 0 ];do
      local name=`echo $1 | sed -e "s|/$||" | sed -e "s|.*/||"`
      local trash_head=${TRASH}/${name}
      local trash_name=${trash_head}
      i=1
      while true;do
        if [ -s ${trash_name} ];then
          trash_name=${trash_head}.${i}
          i=`expr ${i} + 1`
        else
          break
        fi
      done

      mv -i $1 ${trash_name}
      echo $1 was moved to ${trash_name}
      shift
    done
  fi
}
alias del="trash"

function clean_trash {
  if [ ! "$TRASH" ];then
    echo "please set TRASH"
    return
  fi
  local flag="FALSE"
  while [ $flag = "FALSE" ];do
    local trash_box_size=`du -ms ${TRASH} |awk '{print $1}'`
    if [ ${trash_box_size} -gt ${MAXTRASHSIZE} ];then
      local delete_dir=`ls ${TRASH} | head -1`
      rm -rf ${TRASH}/${delete_dir}
    else
      flag="TRUE"
    fi
  done
}
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
      sed -i s!"$2"!!g "$1"
    ;;
    3)
      sed -i s!$2!$3!g "$1"
    ;;
    *)
      echo "enter file name and words of before and after"
    ;;
  esac
}
# }}}

# Delete trailing white space {{{
function del_tail {
  sed -i 's/ \+$//g' $1
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
  local dir=${$1%/*}
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

# Pop clip board {{{
function myclpop {
  # Set values
  local clb=${CLIPBOARD:-$HOMOE/.clipboard}
  local max=${CLMAXHIST:-10}
  local mycl=${MYCL:-""}

  ## Show stored words
  #cat -d -n $clb|sed '1!G;h;$!d'

  ## Choose buffer
  #echo ""
  #echo -n "choose buffer:"
  #local n
  #read n
  #local c=`sed -n '${n},${n}p' $clb`
  #sed -e '${n}d' $clb|sed '1i\$c'|tail -n $max > $clb

  ## Copy to clipboard of X
  #if [ "$mycl" ];then
  #  echo $c | $mycl
  #fi

  # Show stored words
  local i=$(($max-1))
  while [ $i -ge 0 ];do
    printf "%4d: " $i
    touch $clb/clb.$i
    cat $clb/clb.$i
    echo
    i=$(($i-1))
  done

  # Choose buffer
  echo ""
  echo -n "choose buffer:"
  local n
  read n
  local f="$clb/clb.$n"
  local j=$(($max-1))
  if [ ! -f $f ];then
    echo "$f doesn't exist"
    echo "use myclpop <0-$j>"
    return
  fi
  local c=`cat $f`

  # Align clipboards
  local i=$(($n-1))
  while [ $i -ge 0 ];do
    local j=$(($i+1))
    touch $clb/clb.$i
    mv $clb/clb.$i $clb/clb.$j
    i=$(($i-1))
  done
  echo -n $c > $clb/clb.0

  # Copy to clipboard of X
  if [ "$mycl" ];then
    cat $clb/clb.0 | $mycl
  fi
} # }}}

# Push clip board {{{
function myclput {
  # set values
  local clb=${CLIPBOARD:-$HOMOE/.clipboard}
  local max=${CLMAXHIST:-10}
  local mycl=${MYCL:-""}

  # check new words
  mkdir -p $clb
  touch $clb/clb.0
  local old=`cat $clb/clb.0`
  local new=`echo $*`
  if [ "$old" != "$new" ];then
    #add new words
    local i=$(($max-2))
    while [ $i -ge 0 ];do
      local j=$(($i+1))
      touch $clb/clb.$i
      mv $clb/clb.$i $clb/clb.$j
      i=$(($i-1))
    done
    echo -n $* > $clb/clb.0
  fi

  # Copy to clipboard of X
  if [ "$mycl" != "" ];then
    #echo "echo -n $* | $mycl"
    echo -n $* | $mycl
  fi
} # }}}

# Force to copy in clipboard of X {{{
function put_to_clopboard {
  local clb=${CLIPBOARD:-$HOME/.clipboard}
  local mycl=${MYCL:-xclip}
  mkdir -p $clb
  touch $clb/clb.0
  cat $clb/clb.0
  echo
  cat $clb/clb.0 | $mycl
}
alias put=put_to_clopboard
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
  fi
  echo "$(cd "$(dirname $1)";pwd -P)/$(basename $1)"
} # }}}

## Directory save/move in different terminal {{{
LASTDIRFILE=$HOME/.lastDir
function sd { # save dir {{{
  touch ${LASTDIRFILE:-$HOME/.lastDir}
  local lastdirfiletmp=${TMPDIR:-/tmp}/.lastDir.tmp
  tail -n19 $LASTDIRFILE > $lastdirfiletmp
  local lastdir=`tail -n1 $LASTDIRFILE`
  local curdir=`pwd -P`
  if [ "$lastdir" != $curdir ];then
    cat $lastdirfiletmp > $LASTDIRFILE
    echo $curdir >> $LASTDIRFILE
  fi
  rm -rf $lastdirfiletmp
} # }}}

# Change directory to lastdir {{{
function cl {
  local HELP="
  Usage: cl [-l] [-n <number> ]
  If there are no arguments, you move to the last saved dirctory

  Arguments:
     -l              Show saved directories
     -c              Show saved directories and choose a directory
     -n              Move to <number>-th last directory
     -h              Print this HELP and exit
"

  # Check LASTDIRFILE
  touch ${LASTDIRFILE:-$HOME/.lastDir}

  # Initialize variables
  local nth=1
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
      "h" ) echo "$HELP" 1>&2;return ;;
      * ) echo "$HELP" 1>&2;return ;;
    esac
  done
  OPTIND=$optind_tmp

  # List up and choose directory
  if [ $choice -eq  1 ] || [ $list -eq 1 ];then
    # List up stored directories
    local listnum=`wc $LASTDIRFILE|awk '{print $1}'`
    while read dir;do
      printf "%4d %s %4d\n" $listnum $dir $listnum
      listnum=`expr $listnum - 1`
    done < $LASTDIRFILE

    # Choose from STDIN
    if [ $choice -eq 1 ];then
      echo "choose directory number"
      read nth
    fi
  fi

  # Change directory
  if [ $list != 1 ];then
    cd "$(tail -n${nth} $LASTDIRFILE|head -n1)"
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
      local avoidword=(`cat ~/.gitavoid`)
      for a in ${avoidword[@]};do
        if grep -q $a $difffiles;then
          echo "avoid word $a is included!!!"
          grep $a $difffiles
          return
        fi
      done
    fi
    printf "\n\n"
    git commit -a -m "$difffiles, from $OSTYPE"
    update=1
  fi
  ret=$(git pull --rebase)
  if ! echo $ret|grep -q "is up to date";then
    if [ $update -eq 0 ];then
      pwd
    fi
    printf "\n\n"
    echo $ret
  fi
  if [ $update -eq 1 ];then
    git push
  fi
  git gc >/dev/null 2>&1
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
      if command man -d $m > /dev/null 2>&1;then
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

# }}} Alias, Function

# stty {{{
# Disable terminal lock
tty -s && stty stop undef
# }}}

# Local path {{{
# PATH, LD_LIBRARY_PATH under HOME
export PATH=$HOME/usr/bin:$HOME/usr/local/bin:$PATH
export LD_LIBRARY_PATH=$HOME/usr/lib:$HOME/usr/local/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$HOME/usr/lib/python:$HOME/usr/local/lib:$PYTHONPATH

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# }}} Local path

# For screen {{{
# Screen wrapper {{{
function screen {
  # Tips of screen for a cluster
  # This setting keeps the host name in which screen is running
  # for a case in the cluster,
  # in which the host can be changed at every login
  #
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
#  for h in `cat ~/.hostForScreen`;do
#    echo "checking $h..."
#    ping $h -c 2 -w2 >/dev/null 2>&1
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
##alias sc='schost=`tail -n1 ~/.hostForScreen`;ssh $schost'
#function sc {
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

# For clipboard management with screen, Read from previous Clipboard {{{
function myclpopsc {
  local scex=${SCREENEXCHANGE:-$HOME/.screen-exchange}
  local clb=${CLIPBOARD:-$HOME/.clipboard}
  if [ "$1" != "-n" ];then
    myclpop
  fi
  cp $clb/clb.0 $scex
  screen -X readbuf
}
alias rc=myclpopsc
# }}}

# Wrapper of path for screen {{{
function path {
  local fullpath=`command path $@`
  echo $fullpath
  myclput $fullpath
  myclpopsc -n
} # }}}

# For clipboard management with screen, put current screen's exchange to clipboard {{{
function myclputsc {
  local scex=${SCREENEXCHANGE:-$HOME/.screen-exchange}
  local c=`cat $scex`
  myclput $c
} # }}}

## pwd wrapper: myclput/pop sometime take too much time {{{
## even at .bashrc sourcing...
#if [[ "$TERM" =~ "screen" ]]; then
#  function pwd {
#    local curdir=`command pwd $@`
#    myclput $curdir >/dev/null 2>&1
#    myclpopsc -n >/dev/null 2>&1
#    echo $curdir
#  }
#fi
## }}}

# }}} Following functions/alias are also enabled before screen

# functions/settings only for screen sessions {{{
if [[ "$TERM" =~ "screen" ]]; then
  # PROMPT for screen {{{
  function showdir {
    local maxlen=60
    local dir="${PWD/#$HOME/~}"
    if [ ${#dir} -gt $maxlen ];then
      dir=!`echo $dir | cut -b $((${#dir}-$maxlen+2))-${#dir}`
    fi
    # Shown as window's title (\t) in screen
    printf "\ek$(basename $dir)\e\\"
    # Shown as hardstatus (\h) in screen
    printf "\e]0;$dir\a"
    # Send to external (to the title bar of terminal, normal)
    #printf "\eP\e]0;%s@%s:%s\a\e\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"
  }
  if declare -F showdir >/dev/null;then
    export PROMPT_COMMAND="${PROMPT_COMMAND:+${PROMPT_COMMAND};}showdir"
  fi
  export PS1="\$(\
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
# File used in linux, working server
if [[ "$OSTYPE" =~ "linux" ]];then
  source_file ~/.work.sh
fi

# File used in mac
if [[ "$OSTYPE" =~ "darwin" ]];then
  source_file ~/.mac.sh
fi

# File used in windows (cygwin)
if [[ "$OSTYPE" =~ "cygwin" ]];then
  source_file ~/.win.sh
fi
# }}} Setup for each environment
