#!/bin/sh
backup="bak"
exclude=('.' '..' '.git' 'README.md')
overwrite=1
notinstalled=()
instdir=$HOME
curdir=`pwd -P`
# help
HELP="Usage: $0 [-n] [-b <backup file postfix>] [-e <exclude file>] [-i <install dir>]

Arguments:
      -b  Set backup postfix (default: make *.bak file)
          Set \"\" if backups are not necessary
      -e  Set additional exclude file (default: ${exclude[@]})
      -i  Set install directory (default: $instdir)
      -n  Don't overwrite if file is already exist
      -h  Print Help (this message) and exit
"
while getopts b:e:i:nh OPT;do
  OPTNUM=`expr $OPTNUM + 1`
  case $OPT in
    "b" ) backup=$OPTARG ;;
    "e" ) exclude=(${exclude[@]} $OPTARG) ;;
    "i" ) instdir=$OPTARG ;;
    "n" ) overwrite=0 ;;
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
  install=1
  if [ "`ls $instdir/$f 2>/dev/null`" != "" ];then
    if [ $overwrite -eq 0 ];then
      echo "$f exists, don't install"
      notinstalled=(${notinstalled[@]} $f)
      install=0
    elif [ "$backup" != "" ];then
      echo "$f exists, make backup ${f}.$backup"
      mv $instdir/$f $instdir/${f}.$backup
    else
      echo "$f exists, replace it"
      rm $instdir/$f
    fi
  fi
  if [ $install -eq 1 ];then
    ln -s $curdir/$f $instdir/$f
  fi
done
if [ $overwrite -eq 0 ];then
  if [ ${#notinstalled[@]} != 0 ];then
    echo "following files were not installed: ${notinstalled[@]}"
  fi
fi
