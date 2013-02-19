#!/bin/sh
exclude=('.' '..' '.git' 'README.md')
curdir=`pwd -P`
instdir=$HOM
for f in .*;do
  for e in ${exclude[*]};do
    flag=0
    if [ "$f" = "$e" ];then
      flag=1
      break
    fi
  done
  if [ $flag = 1 ];then
    continue
  fi
  echo "install $f to $instdir"
  if [ "`ls $instdir/$f 2>/dev/null`" != "" ];then
    echo "$f exists, make backup ${f}.bak"
    mv $instdir/$f $HOME/${f}.bak
  fi
  ln -s $curdir/$f $instdir/$f
done
