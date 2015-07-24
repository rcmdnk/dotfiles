#!/usr/bin/env bash

MAX=20
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

n_windows=8
n_create=4
align=1
w_exist=()
w_non=()
if [ $# -gt 0 ];then
  n_windows=$1
  if [ $# -gt 1 ];then
    n_create=$2
    if [ $# -gt 2 ];then
      align=$3
    fi
  fi
fi

# Get first/last windows
# select doesn't work well in screen's commands...
# it seems that `screen -Q` makes very high load (at cygwin, screen -Q stops the terminal...)
#f_n=$(screen -X select - && screen -X next && screen -Q number|cut -d' ' -f1)
#l_n=$(screen -X select - && screen -X next && screen -X prev && screen -Q number|cut -d' ' -f1)
f_n=0
l_n=$((MAX-1))

n=0
non_exist=()

# version check if > 4.3.0 or not
version=$(screen -v|cut -d' ' -f3)
v=${version%%.*}
r=$(echo "$version"|cut -d. -f2)

if [ "$v" -ge 5 ] || [ "$v" -ge 4 -a "$r" -ge 3 ];then
  screen -X collapse
  l_n=${n_windows}
fi

screen -X register . win_test >> $log 2>&1
mkdir -p ~/.screen/
test_file=~/.screen/win_test.txt
rm -f $test_file
for i in $(seq $f_n $l_n);do
  #msg=$(screen -p $i -X echo test && screen -Q lastmsg)
  #if [ "$msg" = "test" ];then
  screen -p $i -X writebuf $test_file >>$log 2>&1
  #usleep 1
  date >/dev/null
  #while [ 1 ];do
  #  if ! ps -u$USER |grep "screen -p $i -X writebuf $test_file";then
  #    break
  #  fi
  #  debug writing buffer....
  #done
  debug check $i
  if [ -f $test_file ];then
    debug "*** found $i"
    rm -f $test_file
    screen -X setenv win$n $i >>$log 2>&1
    w_exist=(${w_exist[@]} $i)
    ((n++))
    if [ $n -ge $n_windows ];then
      break
    fi
  else
    non_exist=(${non_exist[@]} $i)
  fi
done

for i in "${non_exist[@]}";do
  debug try non_exist
  debug "i=$i, n=$n, n_windows=$n_windows"
  if [ $n -ge $n_windows ];then
    break
  fi
  if [ $n -lt $n_create ];then
    debug "create non_exist $i"
    screen -X screen >>$log 2>&1
    w_exist=(${w_exist[@]} $i)
  else
    debug "push non_exist $i"
    w_non=(${w_non[@]} $i)
  fi
  screen -X setenv win$n $i >>$log 2>&1
  ((n++))
done

if [ $align -eq 1 ];then
  n=0
  w_exist=($(for w in ${w_exist[@]};do echo $w;done|sort -n))
  w_non=($(for w in ${w_non[@]};do echo $w;done|sort -n))
  for i in ${w_exist[@]};do
    screen -X setenv win$n $i >>$log 2>&1
    ((n++))
  done
  for i in ${w_non[@]};do
    screen -X setenv win$n $i >>$log 2>&1
    ((n++))
  done
fi

#screen -wipe > /dev/null >>$log 2>&1
