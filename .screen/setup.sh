function screen () { # Screen wrapper {{{
  # Tips of screen for a cluster
  # This setting keeps the host name in which screen is running
  # for a case in the cluster,
  # in which the host can be changed at every login

  #touch ~/.hostForScreen
  if [ $# = 0 ] || [ "$1" = "-r" ] || [ "$1" = "-R" ] || [ "$1" = "-x" ] || [ "$1" = "-n" ];then
    #sed -i -e "/^$(hostname).*/d" ~/.hostForScreen
    #hostname >> ~/.hostForScreen
    ## keep 10 histories
    #tail -n10 ~/.hostForScreen > ~/.hostForScreen.tmp
    #mv ~/.hostForScreen.tmp ~/.hostForScreen
    # write out DISPLAY of current terminal
    echo "$DISPLAY"> ~/.display.txt
  fi

  local options=""
  if [ $# = 0 ];then
    sockets=$(command screen -ls|grep -e Attached -e Detached)
    n_sockets=$(printf "$sockets"|grep -c '')
    if [ $n_sockets -ge 1 ];then
      # Don't make another screen session, if any session exists.
      if [ $n_sockets -eq 1 ];then
        options="-d -r"
      else
        if type -a sentaku >& /dev/null;then
          session=$(echo "$sockets"|sentaku -s $'\n'|awk '{print $1}'|cut -d'.' -f1)
          if [ "$session" = "" ];then
            return
          fi
        else
          n=1
          while read -r s;do
            printf "%-2s %s\n" "$n" "$s"
            ((n++))
          done < <(echo "$sockets")
          printf "\nChoose session: "
          read i
          if ! expr "$i" : '[0-9]*' >/dev/null || [ "$i" -ge "$n" ];then
            return
          fi
          session=$(echo "$sockets"|sed -n "${i},${i}p"|awk '{print $1}'|cut -d'.' -f1)
        fi
        options="-d -r $session"
      fi
    fi
  fi
  if [ "$1" == "-n" ];then
    shift
  fi
  options="$* $options"

  # launch screen
  command screen $options
}

export SCREENDIR=$HOME/.screen_$(hostname|cut -d. -f1)
if [ ! -d "$SCREENDIR" ];then
  mkdir -p "$SCREENDIR"
fi
chmod 700 "$SCREENDIR"
# }}}


#function screen_check () { # Function to check remaining screen sessions in a cluster{{{
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

#function sc () { # ssh to the host which launched screen previously {{{
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

# functions/settings only for screen sessions {{{

if [[ "$TERM" =~ screen ]]; then # {{{

  #if [ -n "$STY" ] || [ -n "$TMUX" ];then # Only for the machine in which screen/tmux was launched
  if [ -n "$STY" ];then # Only for the machine in which screen was launched. {{{
    # Overwrite path to push to the clipboard list{{{
    function path () {
      if [ $# -eq 0 ];then
          echo "usage: path file/directory"
          return 1
      fi
      fullpath="$(cd "$(dirname "$1")";pwd -P)/$(basename "$1")"
      echo "$fullpath"
      multi_clipboard -s "$fullpath"
    } # }}}

    # pwd wrapper (named as wc) to push pwd to the clipboard list{{{
    function wd () {
      local curdir=$(pwd -P)
      multi_clipboard -s "$curdir"
      echo "$curdir"
    }
    # }}}
  fi # }}}

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
  function set_display () {
    if [ -f ~/.display.txt ];then
      #local d=`grep $HOSTNAME ~/.display.txt|awk '{print $2}'`
      local d=$(cat ~/.display.txt)
      export DISPLAY=$d
    fi
  }
  # }}}

fi # }}}
