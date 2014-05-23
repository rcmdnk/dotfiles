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
auto_save=on
win_prepare=1
n_win=4
n_create=$n_win

if [ $# -gt 0 ];then
  name=$1
  if [ $# -gt 1 ];then
    auto_save=$2
    if [ $# -gt 2 ];then
      win_prepare=$3
      if [ $# -gt 3 ];then
        n_win=$4
        if [ $# -gt 4 ];then
          n_create=$5
        fi
      fi
    fi
  fi
fi

if [ $win_prepare -eq 1 ];then
  $HOME/.screen/win_prepare.sh $n_win $n_create
fi
debug layout remove $name
screen -X layout remove $name >>$log 2>&1
debug screen -X layout new $name
screen -X layout new $name >>$log 2>&1
debug screen -X source $HOME/.screen/${name}.layout
screen -X source $HOME/.screen/${name}.layout >>$log 2>&1
debug screen -X layout save $name
screen -X layout save $name
debug screen -X layout autosave $auto_save
screen -X layout autosave $auto_save >>$log 2>&1
debug screen -X echo $name
screen -X echo $name >>$log 2>&1

#screen -wipe
