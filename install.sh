#!/bin/sh
exclude=('.' '..' '.svn')
curdir=`pwd -P`
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
  echo "install $f to HOME"
  if [ "`ls $HOME/$f 2>/dev/null`" != "" ];then
    echo "$f exists, make backup ${f}.bak"
    mv $HOME/$f $HOME/${f}.bak
  fi
  ln -s $curdir/$f $HOME/$f
done
