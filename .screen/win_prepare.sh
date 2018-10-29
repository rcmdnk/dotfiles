#!/usr/bin/env bash

COLLAPSE=0
DEBUG=0

function debug () {
  if [[ "$DEBUG" = "1" ]];then
    echo "$*" >> ~/log
  fi
}
if [[ "$DEBUG" = "1" ]];then
  log=~/log
else
  log=/dev/null
fi

n_windows=8
n_create=4
align=0
w_exist=()
w_non=()
if [[ $# -gt 0 ]];then
  n_windows=$1
  if [[ $# -gt 1 ]];then
    n_create=$2
    if [[ $# -gt 2 ]];then
      align=$3
    fi
  fi
fi

n=0
non_exist=()

# Reordering window numbers
# version check if > 4.3.0 or not
if [[ $COLLAPSE -eq 1 ]];then
  version=$(screen -v|cut -d' ' -f3)
  v=${version%%.*}
  r=$(echo "$version"|cut -d. -f2)
  if [[ "$v" -ge 5 ]] || [[ "$v" -ge 4 && "$r" -ge 3 ]];then
    screen -X collapse
    l_n=${n_windows}
  fi
fi

w_exist=($(screen -Q windows '%n|'|sed 's/|/ /g'))
for w in "${w_exist[@]}";do
  screen -X setenv win$n "$w" >>$log 2>&1
  ((n++))
done

i=0
while [[ $n -lt "$n_windows" ]];do
  if [[ ! " ${w_exist[*]} " = *\ $i\ * ]];then
    if [ $n -lt "$n_create" ];then
      debug "create non_exist $i"
      screen -X screen >>$log 2>&1
      w_exist=("${w_exist[@]}" "$i")
    else
      debug "push non_exist $i"
      w_non=("${w_non[@]}" "$i")
    fi
    screen -X setenv win$n "$i" >>$log 2>&1
    ((n++))
  fi
  ((i++))
done

if [ "$align" -eq 1 ];then
  n=0
  w_exist=($(for w in "${w_exist[@]}";do echo "$w";done|sort -n))
  w_non=($(for w in "${w_non[@]}";do echo "$w";done|sort -n))
  for i in "${w_exist[@]}";do
    screen -X setenv win$n "$i" >>$log 2>&1
    ((n++))
  done
  for i in "${w_non[@]}";do
    screen -X setenv win$n "$i" >>$log 2>&1
    ((n++))
  done
fi

#screen -wipe > /dev/null >>$log 2>&1
