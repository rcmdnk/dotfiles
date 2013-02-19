#!/bin/sh
backup="bak"
exclude=('.' '..' '.git' 'README.md')
instdir=$HOME
curdir=`pwd -P`
# help
HELP="Usage: $0 [-b <backup file postfix>] [-e <exclude file>] [-i <install dir>]

Arguments:
      -b  Set backup postfix (default: make *.bak file)
          Set \"\" if backups are not necessary
      -e  Set additional exclude file (default: ${exclude[@]})
      -i  Set install directory (default: $instdir)
      -h  Print Help (this message) and exit
"
while getopts b:e:i:h OPT;do
  OPTNUM=`expr $OPTNUM + 1`
  case $OPT in
    "b" ) backup=$OPTARG ;;
    "e" ) exclude=(${exclude[@]} $OPTARG) ;;
    "i" ) instdir=$OPTARG ;;
    "h" ) echo "$HELP" 1>&2; exit ;;
    * ) echo "$HELP" 1>&2; exit ;;
  esac
done

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
    if [ "$backup" != "" ];then
      echo "$f exists, make backup ${f}.$backup"
      mv $instdir/$f $HOME/${f}.$backup
    else
      echo "$f exists, replace it"
      rm $instdir/$f
    fi
  fi
  ln -s $curdir/$f $instdir/$f
done
