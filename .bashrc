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
export HISTCONTROL=ignoreboth:erasedups
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
if [[ "$OSTYPE" =~ "linux" ]];then
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

# aliases {{{
alias l='/bin/ls'
if [[ "$OSTYPE" =~ "linux" ]];then
  alias ls='ls --color=auto --show-control-char'
  alias la='ls -a --color=auto --show-control-char'
elif [[ "$OSTYPE" =~ "darwin" ]];then
  alias ls='ls -G'
  alias la='ls -a -G'
fi
alias badlink='find -L . -type l -ls'
alias targz="tar xzf"
alias tarbz2="tar jxf"
alias g='gmake'
alias gc="gmake clean"
alias ch="$HOME/usr/bin/change"
alias del="$HOME/usr/bin/trash"
alias bc="bc -l"
alias cl=". $HOME/usr/bin/clwrapper"
alias ssh="ssh -X"
alias svnHeadDiff="svn diff --revision=HEAD"
#alias vim="vim -X --startuptime $TMPDIR/vim.startup.log" # no X, write startup processes
alias vim="vim -X" # no X
alias vi="vim -X" # no X
#alias grep="grep --color=always"
#export GREP_OPTIONS='--color=auto'
#export LESS='-R'
alias gitupdate="git commit -a -m \"update from $OSTYPE\";git pull --rebase;git push"
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
# functions
source_file ~/.functions.sh
# local path
source_file ~/.localpath.sh
# }}}

# for screen {{{
if [[ "$TERM" =~ "screen" ]]; then
  if declare -F showdir >/dev/null;then
    export PROMPT_COMMAND="$PROMPT_COMMAND;showdir"
  fi
<<<<<<< HEAD
  # problem for long line command...
  #if declare -F face_prompt >/dev/null;then
  #  export PS1='$(face_prompt)'
  #fi
=======
  if declare -F face_prompt >/dev/null;then
    export PS1="\$(\
      if [ \$? -eq 0 ];then\
        printf '\[\e[m\](-_-)\[\e[m\] \$ ';\
      else\
        printf '\[\e[31m\](>_<)\[\e[m\] \$ ';\
      fi\
      )"
  fi
>>>>>>> 7e0c950133255d5303d59e013ec7820174c61b6b
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
# }}}
