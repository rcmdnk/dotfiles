#!/usr/bin/env bash
screen () { # Screen wrapper {{{
  # Tips of screen for a cluster
  # This setting keeps the host name in which screen is running
  # for a case in the cluster,
  # in which the host can be changed at every login

  #touch ~/.hostForScreen
  if [ $# = 0 ] || [ "$1" = "-r" ] || [ "$1" = "-R" ] || [ "$1" = "-x" ] || [ "$1" = "-n" ];then
    if sed --version 2>/dev/null |grep -q GNU;then
      alias sedi='sed -i"" '
    else
      alias sedi='sed -i "" '
    fi
    sedi -e "/^$(hostname).*/d" ~/.hostForScreen
    hostname >> ~/.hostForScreen
    # keep 10 histories
    tail -n10 ~/.hostForScreen > ~/.hostForScreen.tmp
    mv ~/.hostForScreen.tmp ~/.hostForScreen
    # write out DISPLAY of current terminal
    echo "export DISPLAY=$DISPLAY" > ~/.screen_update
    echo "export SSHHOME=$SSHHOME" >> ~/.screen_update
  fi

  local options=""
  if [ $# = 0 ];then
    sockets=$(command screen -ls|grep -e Attached -e Detached)
    n_sockets=$(printf "$sockets"|grep -c ^)
    if [ "$n_sockets" -ge 1 ];then
      # Don't make another screen session, if any session exists.
      if [ "$n_sockets" -gt 1 ];then
        if type -a sentaku >& /dev/null;then
          sockets=$(echo "$sockets"|sentaku -s $'\n')
          if [ "$sockets" = "" ];then
            return
          fi
        else
          n=1
          IFS_ORIG=$IFS
          IFS=$'\n'
          for s in $sockets;do
            printf "%-2s %s\\n" "$n" "$s"
            ((n++))
          done
          IFS=$IFS_ORIG
          printf "\\nChoose session: "
          read -r i
          if ! expr "$i" : '[0-9]*' >/dev/null || [ "$i" -ge "$n" ];then
            return
          fi
          session=$(echo "$sockets"|sed -n "${i},${i}p")
        fi
      fi
      session=$(echo "$sockets"|awk '{print $1}'|cut -d'.' -f1)
      options="-d -r $session"
    fi
  fi
  if [ "$1" == "-n" ];then
    shift
  fi
  options="$* $options"

  # launch screen
  command screen $options
}

clenaup_hostforscren () {
  if [ -f ~/.hostForScreen ];then
    if [ "$(ps -u$USER|grep screen)" = "" ];then
      if sed --version 2>/dev/null |grep -q GNU;then
        alias sedi='sed -i"" '
      else
        alias sedi='sed -i "" '
      fi
      sedi -e "/$(hostname)/d" ~/.hostForScreen
    fi
  fi
}


if type scutil >&/dev/null;then
  export SCREENDIR=$HOME/.screen_$(scutil --get ComputerName)
else
  export SCREENDIR=$HOME/.screen_$(hostname|cut -d. -f1)
fi
if [ ! -d "$SCREENDIR" ];then
  mkdir -p "$SCREENDIR"
fi
chmod 700 "$SCREENDIR"
# }}}

screen_check () { # Function to check remaining screen sessions in a cluster{{{
  touch .hostForScreen
  while read -r h;do
    echo "checking $h..."
    ping "$h" -c 2 -w2 >& /dev/null
    local ret=$?
    if [ $ret -eq 0 ];then
      local checklog="$(ssh -x "$h" "screen -ls")"
      echo "$checklog"
      if ! echo "$checklog"|grep -q "No Sockets found";then
        echo "$h" >> ~/.hostForScreen.tmp
      fi
    else
      echo "$h" seems not available
    fi
  done < <(cat ~/.hostForScreen)
  touch ~/.hostForScreen.tmp
  mv ~/.hostForScreen.tmp ~/.hostForScreen
}
# }}}

screen_last () { # ssh to the host which launched screen previously {{{
  touch .hostForScreen
  local n=1
  if [ $# -ne 0 ];then
    n=$1
  fi
  local host="$(tail -n"$n" ~/.hostForScreen|head -n1)"
  if [ "$host" == "" ];then
    echo "no host has remaining screen"
  else
    ssh "$host"
  fi
} # }}}

# screen exchange file
export SCREENEXCHANGE=$HOME/.screen-exchange

# functions/settings only for screen sessions {{{
if [[ "$TERM" =~ screen ]]; then

  # {{{

  # PS1 emotion
  # "\\" doesn't work well, use \134 instead

  # \ek ~ \e\134 : Screen's window title (`\t` in caption/hardstatus)
  # \e]0; ~ \a   : Screen's hardstatus, instead of terminal's title bar (`\h` in caption/hardstatus)
  # If you want to change terminal's title bar, use
  # \eP\e]0; ~ \a\e\134 (\eP ~ \e\134 will send the words out)
  PS1="\\[\\ek\\h \\W\\e\\134\\e]0;\\h \\w\\a\\]\$(\
    ret=\$?;\
    rand=\$((RANDOM%36));\
    if [ \$ret -eq 0 ];then\
      if [ \$rand -lt 3 ];then\
        printf '\\[\\e[m\\](^_^)\\[\\e[m\\] \$ ';\
      elif [ \$rand -lt 5 ];then\
        printf '\\[\\e[m\\](^_-)\\[\\e[m\\] \$ ';\
      elif [ \$rand -lt 6 ];then\
        printf '\\[\\e[m\\](.^.)\\[\\e[m\\] \$ ';\
      else\
        printf '\\[\\e[m\\](-_-)\\[\\e[m\\] \$ ';\
      fi;\
    else\
      if [ \$rand -lt 6 ];then\
        printf '\\[\\e[31m\\](@o@)\\[\\e[m\\] \$ ';\
      elif [ \$rand -lt 12 ];then\
        printf '\\[\\e[31;1m\\](>_<)\\[\\e[m\\] \$ ';\
      elif [ \$rand -lt 18 ];then\
        printf '\\[\\e[35m\\](*_*)\\[\\e[m\\] \$ ';\
      elif [ \$rand -lt 24 ];then\
        printf '\\[\\e[34m\\](T_T)\\[\\e[m\\] \$ ';\
      elif [ \$rand -eq 30 ];then\
        printf '\\[\\e[34;1m\\](/_T)\\[\\e[m\\] \$ ';\
      else\
        printf '\\[\\e[31m\\](>_<)\\[\\e[m\\] \$ ';\
      fi\
    fi;\
    )"

  PROMPT_COMMAND="${PROMPT_COMMAND:+${PROMPT_COMMAND};}touch ~/.screen_update;. ~/.screen_update"
  # }}}

  # Set display if screen is attached in other host than previous host {{{
  set_display () {
    if [ -f ~/.display.txt ];then
      #local d=`grep $HOSTNAME ~/.display.txt|awk '{print $2}'`
      local d=$(cat ~/.display.txt)
      export DISPLAY=$d
    fi
  }
  # }}}
fi # }}}
