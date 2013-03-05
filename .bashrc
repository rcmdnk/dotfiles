# .bashrc

# check if this is first time to read bashrc or not {{{
# (subshell, screen, etc...)
if [ "$INIT_PATH" = "" ];then
  # set initial values of PATH, LD_LIBRARY_PATH, PYTHONPATH
  export INIT_PATH=$PATH
  export INIT_LD_LIBRARY_PATH=$LD_LIBRARY_PATH
  export INIT_PYTHONPATH=$PYTHONPATH
else
  # reset paths
  export PATH=$INIT_PATH
  export LD_LIBRARY_PATH=$INIT_LD_LIBRARY_PATH
  export PYTHONPATH=$INIT_PYTHONPATH
fi
# }}}

# function for sourcing with precheck of the file {{{
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
}
# }}}

# Source global definitions {{{
source_file /etc/bashrc
# }}}

# Environmental variables {{{
# prompt
#export PS1="[\u@\h \W]\$ "
export PS1="[\h \W]\$ "

# prompt command
export PROMPT_COMMAND='printf "\e]0;%s@%s:%s\a" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'

# XMODIFIERS
export XMODIFIERS="@im=kinput2"

# lang
#export LANG=C
export LANG="en_GB.UTF-8"
#export LANG="en_US.UTF-8"
#export LANG=ja_JP.eucJP
#export LANG=ja_JP.UTF-8

# editors
export VISUAL=vim
export EDITOR=vim
export PAGER=less

# less
#export LESSCHARSET=utf-8
#ascii,dos,ebcdic,IBM-1047,iso8859,koi8-r,latin1,next

# python
export PYTHONSTARTUP=~/.pythonstartup.py

# trash
export TRASH=~/.Trash
export MAXTRASHSIZE=1024 #MB
# }}}

# shopt {{{
shopt -s cdspell # minor error for cd is corrected
shopt -s checkhash # check hash before execute command in hash
#shopt -s dotglob # include dot files in the results of pathname expansion
shopt -s histreedit # enable to re-edit a failed history
#shopt -s histverify # allow further modification of history
shopt -s no_empty_cmd_completion # don't complete for an empty line
# }}}

# history {{{
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
# method to remove failed command {{{
#function histRemoveFail {
#  result=$?
#  if [ $result -ne 0 ];then
#    n=`history 1|awk '{print $1}'`
#    if [ "x$n" != "x" ];then
#      history -d $n
#    fi
#  fi
#}
#export PROMPT_COMMAND="$PROMPT_COMMAND;histRemoveFail"
# }}}

# method to share history at the same time,
# w/o failed command (bit too strong...) {{{
#shopt -u histappend # overwrite
#function share_history {
#  result=$?
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
#export PROMPT_COMMAND="$PROMPT_COMMAND;share_history"
# }}}

# simple method to add history everytime {{{
#export PROMPT_COMMAND="$PROMPT_COMMAND;history -a"
# }}}

# }}}

# for ls colour {{{
if [[ "$OSTYPE" =~ "linux" ]] || [[ "$OSTYPE" =~ "cygwin" ]];then
  # linux
  eval `dircolors ~/.colourrc`
  if [ "$LS_COLORS" = "" ];then
    source_file $HOME/.lscolors
  fi
elif [[ "$OSTYPE" =~ "darwin" ]];then
  # mac
  export LSCOLORS=DxgxcxdxCxegedabagacad
fi
# }}}

# alias, function {{{
alias l='/bin/ls'
if [[ "$OSTYPE" =~ "linux" ]] || [[ "$OSTYPE" =~ "cygwin" ]];then
  alias ls='ls --color=auto --show-control-char'
  alias la='ls -a --color=auto --show-control-char'
elif [[ "$OSTYPE" =~ "darwin" ]];then
  alias ls='ls -G'
  alias la='ls -a -G'
fi
alias badlink='find -L . -depth 1 -type l -ls'
alias targz="tar xzf"
alias tarbz2="tar jxf"
#alias g='gmake'
alias g='make'
alias gc="make clean"
alias gcg="make clean && make"
alias ch="$HOME/usr/bin/change"
alias del="$HOME/usr/bin/trash"
alias bc="bc -l"
alias cl=". $HOME/usr/bin/clwrapper"
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
#function lw {
#  sed -e 's/</\&lt;/g' |\
#  sed -e 's/>/\&gt;/g' |\
#  sed -e 's/\&/\&amp;/g' |\
#  sed -e 's/[^:]*/<a href="\0">\0<\/a>/' |\
#  sed -e 's/$/<br\/>/' |\
#  EDITOR='vi' w3m -T text/html
#}
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

## screen wrapper {{{
#function screen {
#  # This setting keeps the host name in which screen is running
#  # for a case in the cluster,
#  # in which the host can be changed at every login
#  #
#  if [ $# = 0 ] || [ $1 = "-r" ] || [ $1 = "-R" ] || [ $1 = "x" ];then
#    sed -i -e "/^$(hostname).*/d" .hostForScreen
#    hostname >> ~/.hostForScreen
#    # keep 10 histories
#    #tail -n10 ~/.hostForScreen > ~/.hostForScreen.tmp
#    #mv ~/.hostForScreen.tmp ~/.hostForScreen
#  # write out DISPLAY of current terminal
#    echo "$DISPLAY"> ~/.display.txt
#  fi
#
#  # launch screen
#  command screen $@
#}
## }}}

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

# git{{{
function gitupdate {
  if [ -f ~/.gitavoid ];then
    local avoidword=(`cat ~/.gitavoid`)
    for a in ${avoidword[@]};do
      if grep -q $a .* *;then
        pwd
        echo "avoid word $a is included!!!"
        grep $a .* *
        return
      fi
    done
  fi
  update=0
  difffiles=`git diff|grep diff|cut -d' ' -f4|cut -d'/' -f2`
  if [ "$difffiles" != "" ];then
    pwd
    git commit -a -m "$difffiles, from $OSTYPE"
    update=1
  fi
  ret=$(git pull --rebase)
  if ! echo $ret|grep -q "is up to date";then
    if [ $update -eq 0 ];then
      pwd
    fi
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
  # open man file with vim
  # col -b -x: remove backspace, replace tab->space
  # vim -R -: read only mode, read from stdin
  command man $1|col -b -x|vim -R -
}
# }}}
#alias man='LANG=C man'
# }}}

# stty {{{
# disable terminal lock
tty -s && stty stop undef
# }}}

# terminfo {{{
export TERMINFO=/usr/share/terminfo
# }}}

#for my clipboards {{{
export CLIPBOARD=$HOME/.clipboard/
export CLMAXHIST=20
export MYCL="" #xsel/xclip
# }}}

# basic include files {{{
# local path
# PATH, LD_LIBRARY_PATH under HOME
export PATH=$HOME/usr/bin:$HOME/usr/local/bin:$PATH
export LD_LIBRARY_PATH=$HOME/usr/lib:$HOME/usr/local/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$HOME/usr/lib/python:$HOME/usr/local/lib:$PYTHONPATH
# }}}

# for screen {{{
if [[ "$TERM" =~ "screen" ]]; then
  if declare -F showdir >/dev/null;then
    export PROMPT_COMMAND="$PROMPT_COMMAND;showdir"
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
fi
export SCREENEXCHANGE=$HOME/.screen-exchange
# }}}

# setup for each environment {{{
# file used in linux, working server
if [[ "$OSTYPE" =~ "linux" ]];then
  source_file ~/.work.sh
fi

# file used in mac
if [[ "$OSTYPE" =~ "darwin" ]];then
  source_file ~/.mac.sh
fi

# file used in windows (cygwin)
if [[ "$OSTYPE" =~ "cygwin" ]];then
  source_file ~/.win.sh
fi
# }}}
