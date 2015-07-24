#!/usr/bin/env bash

function debug () {
  if [ "$DEBUG" = "1" ];then
    echo "$*" >> ~/log
  fi
}
if [ "$DEBUG" = "1" ];then
  log=~/log
else
  log=/dev/null
fi

name=4-windows
set_layout=0
auto_save=on
win_prepare=1
n_win=4
n_create=$n_win
prepare=1

if [ $# -gt 0 ];then
  name=$1
  if [ $# -gt 1 ];then
    set_layout=$2
    if [ $# -gt 2 ];then
      auto_save=$3
      if [ $# -gt 3 ];then
        win_prepare=$4
        if [ $# -gt 4 ];then
          n_win=$5
          if [ $# -gt 5 ];then
            n_create=$6
          fi
        fi
      fi
    fi
  fi
fi

if [ $win_prepare -eq 1 ];then
  $HOME/.screen/win_prepare.sh $n_win $n_create
fi
if [ $set_layout -eq 1 ];then
  debug screen -X layout new $name
  screen -X layout new $name >>$log 2>&1
fi

debug screen -X source $HOME/.screen/${name}.layout
screen -X source $HOME/.screen/${name}.layout >>$log 2>&1

if [ $set_layout -eq 1 ];then
  debug screen -X layout save $name
  screen -X layout save $name
  debug screen -X layout autosave $auto_save
  screen -X layout autosave $auto_save >>$log 2>&1
  debug screen -X echo $name
  screen -X echo $name >>$log 2>&1
fi

#screen -wipe
