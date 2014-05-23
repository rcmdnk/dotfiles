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

WINDOWS=8
CREATE=4
LAYOUTS=(only 4-windows 4-windows_2 3-win_1-top 3-win_1-left monitor)
AUTOSAVE=(on on off on on on)

$HOME/.screen/win_prepare.sh 8 4

# Remove all known layouts before creating any new layouts
# (need to start with 0, or first number in all w/o unknown layouts)
for l in ${LAYOUTS[@]};do
  debug screen -X layout remove $l
  screen -X layout remove $l >>$log 2>&1
done
for i in $(seq 0 $((${#LAYOUTS[@]}-1)));do
  $HOME/.screen/layout.sh ${LAYOUTS[$i]} ${AUTOSAVE[$i]} 0
done

screen -X layout select 4-windows >>$log 2>&1

#screen -wipe >/dev/null
