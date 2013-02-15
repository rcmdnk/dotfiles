# .bashrc

# function for sourcing with precheck of the file {{{
function source_file() {
  arg=$1
  shift
  flag=`echo $arg|sed -e 's|/|_|g'|sed -e 's|\.|_|g'`
  if [ "`printenv $flag`" = 1 ];then
    return
  fi
  export $flag=1
  if [ -f $arg ]; then
    source $arg
  fi
} # }}}

# Source global definitions {{{
source_file /etc/bashrc
# }}}

# Environmental variables {{{
# prompt
#export PS1="[\u@\h \W]\$ "
export PS1="[\h \W]\$ "

# XMODIFIERS
export XMODIFIERS="@im=kinput2"

# lang
export LANG=C
#export LANG="en_US.UTF-8"
#export LANG=ja_JP.eucJP
#export LANG=ja_JP.UTF-8

# editors
export VISUAL=vim
export EDITOR=vim
export PAGER=less

# python
export PYTHONSTARTUP=~/.pythonstartup.py
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
#if [ "x$PROMPT_COMMAND" != "x" ];then
#  PROMPT_COMMAND="$PROMPT_COMMAND;histRemoveFail"
#else
#  PROMPT_COMMAND="histRemoveFail"
#fi
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
#if [ "x$PROMPT_COMMAND" != "x" ];then
#  PROMPT_COMMAND="$PROMPT_COMMAND;share_history"
#else
#  PROMPT_COMMAND="share_history"
#fi
# }}}

# simple method to add history everytime {{{
#export PROMPT_COMMAND="history -a"
# }}}

# }}}

# for ls colour {{{
eval `dircolors ~/.colourrc`
if [ "$LS_COLORS" = "" ];then source_file $HOME/.lscolors;fi
# }}}

# aliases {{{
alias l='/bin/ls'
alias ls='ls --color=auto --show-control-char'
alias la='ls -a --color=auto --show-control-char'
#alias targz="tar xzf" commented out to remember the command...
#alias tarbz2="tar jxf" same as targz
alias g='gmake'
alias gc="gmake clean"
alias ch="$HOME/usr/bin/change"
alias pmake='cmt make -s -j8 QUIET=1 PEDANTIC=1'
alias del="$HOME/usr/bin/trash"
alias bc="bc -l"
alias cl=". $HOME/usr/share/scripts/clwrapper.sh"
alias ssh="ssh -X"
alias svnHeadDiff="svn diff --revision=HEAD"
alias vim="vim -X --startuptime $TMPDIR/vim.startup.log" # no X
alias vi="vim -X" # no X
#alias grep="grep --color=always"
#export GREP_OPTIONS='--color=auto'
#export LESS='-R'
# }}}

# stty {{{
# disable terminal lock
tty -s && stty stop undef
# }}}

# for screen {{{
#if [[ "$TERM" =~ "screen" ]]; then
#  if [ "x$PROMPT_COMMAND" != "x" ];then
#    PROMPT_COMMAND="$PROMPT_COMMAND;$HOME/usr/bin/showdir"
#  else
#    PROMPT_COMMAND="$HOME/usr/bin/showdir"
#  fi
#  #export PROMPT_COMMAND='echo -ne "\ek[$(pwd)]\e\\"'
#fi
export SCREENEXCHANGE=$HOME/.screen-exchange

# terminfo
export TERMINFO=/usr/share/terminfo
# }}}

#for my clipboards {{{
export CLIPBOARD=$HOME/.clipboard/
export CLMAXHIST=20
export MYCL="" #xsel/xclip
# }}}

# include files {{{

# functions
source_file ~/.functions.sh

# file used in linux, working server
source_file ~/.work.sh

# local path
source_file ~/.localpath.sh
# }}}
