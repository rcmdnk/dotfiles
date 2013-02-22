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

# emacs wrapper {{{
#function emacs { command emacs $@ & }
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

# alias for popd {{{
alias bd="popd >/dev/null"

# move to actual pwd
function cdpwd {
  cd -P .
}
# }}}

# show output result with w3m {{{
function lw {
  sed -e 's/</\&lt;/g' |\
  sed -e 's/>/\&gt;/g' |\
  sed -e 's/\&/\&amp;/g' |\
  sed -e 's/[^:]*/<a href="\0">\0<\/a>/' |\
  sed -e 's/$/<br\/>/' |\
  EDITOR='vi' w3m -T text/html
}
# }}}

# copy to clipboard {{{
function putToClopboard {
  local clb="$HOME/.clipboard"
  local mycl=xclip
  if [ "$CLIPBOARD" != "" ];then
    clb=$CLIPBOARD
  fi
  if [ "$MYCL" != "" ];then
    mycl=$MYCL
  fi
  mkdir -p $clb
  touch $clb/clb.0
  cat $clb/clb.0
  echo
  cat $clb/clb.0 | $mycl
}
alias put=putToClopboard
# }}}

# editor wrapper {{{
function edit {
  if [ $# -eq 0 ];then
    echo "usage: edit file"
  else
    file=`basename $1`
    dir=`dirname $1`
    mkdir -p $TMPDIR/edit/$dir
    rm -rf $TMPDIR/edit/$dir/$file
    cp $dir/$file $TMPDIR/edit/$dir/$file
    vi $TMPDIR/edit/$dir/$file
    cp $TMPDIR/edit/$dir/$file $dir/$file
  fi
}
# }}}

# SimpleNote {{{
#alias sn='vim -c "call Sn()"'
# }}}

# screen wrapper {{{
function screen {
  # This setting keeps the host name in which screen is running
  # for a case in the cluster,
  # in which the host can be changed at every log in
  #
  #if [ $# = 0 ] || [ $1 = "-r" ] || [ $1 = "-R" ] || [ $1 = "x" ];then
  #  sed -i -e "/^$(hostname).*/d" .hostForScreen
  #  hostname >> ~/.hostForScreen
  #  #tail -n10 ~/.hostForScreen > ~/.hostForScreen.tmp
  #  #mv ~/.hostForScreen.tmp ~/.hostForScreen
  ## write out DISPLAY of current terminal
  #  echo "$DISPLAY"> ~/.display.txt
  #fi

  # launch screen
  command screen $@
}
# }}}

# set display if screen is attached in other host than previous host {{{
function setDisplay {
  if [ -f ~/.display.txt ];then
    #local d=`grep $HOSTNAME ~/.display.txt|awk '{print $2}'`
    local d=`cat ~/.display.txt`
    export DISPLAY=$d
  fi
}
# }}}

# ssh to the host which launched screen previously {{{
#alias sc='schost=`tail -n1 ~/.hostForScreen`;ssh $schost'
function sc {
  local n=1
  if [ $# -ne 0 ];then
    n=$1
  fi
  local schost=`tail -n$n ~/.hostForScreen|head -n1`
  if [ "$schost" == "" ];then
    echo "no host has remaining screen"
  else
    ssh $schost
  fi
}
# }}}

# for clipboard management with screen, Read from previous Clipboard {{{
#function rc {
#  myClPopSC
#}
alias rc=myClPopSC
# }}}

## pwd wrapper: myClPut/Pop sometime take too much time {{{
## even at .bashrc sourcing...
#if [[ "$TERM" =~ "screen" ]]; then
#  function pwd {
#    local curdir=`command pwd $@`
#    myClPut $curdir >/dev/null 2>&1
#    myClPopSC -n >/dev/null 2>&1
#    echo $curdir
#  }
#fi
# }}}

# path wrapper {{{
if [[ "$TERM" =~ "screen" ]]; then
  function path {
    local fullpath=`command path $@`
    myClPut $fullpath
    myClPopSC -n
    echo $fullpath
  }
fi
# }}}

# directory name for scren {{{
function showdir {
  maxlen=20
  dir="${PWD/#$HOME/~}"
  if [ ${#dir} -gt $maxlen ];then
    dir=!`echo $dir | cut -b $((${#dir}-$maxlen+2))-${#dir}`
  fi
  if [[ "$TERM" =~ "screen" ]]; then
    printf "\ek$dir\e\\"
    #printf "\eP\e]0;%s@%s:%s\a\e\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"
  else
    printf "$dir\n"
  fi
}
# }}}
