#!/usr/bin/env bash

exclude=('.' '..' '.DS_Store' '.svn' '.git' 'LICENSE' 'README.md' '.gitignore' '.vimrc.not_used' '.vimrc.dein' '.vimrc.neobundle' '.subversion.config' '.dein.toml' '.dein_lazy.toml' '.w3m')
instdir="$HOME"

backup=""
overwrite=1
relative=0
dryrun=0
copy=0
newlink=()
exist=()
curdir=$(pwd -P)

# help
HELP="Usage: $0 [-rndch] [-b <backup file postfix>] [-e <exclude file>] [-i <install dir>]

Make links of dot files in home directory (default:$instdir)

Arguments:
      -b  Set backup postfix, like \"bak\" (default: \"\": no back up is made)
      -e  Set additional exclude file (default: ${exclude[*]})
      -i  Set install directory (default: $instdir)
      -r  Use relative path (default: absolute path)
      -n  Don't overwrite if file is already exist
      -d  Dry run, don't install anything
      -c  Copy files, instead of making links.
      -h  Print Help (this message) and exit
"

while getopts b:e:i:rndch OPT;do
  case $OPT in
    "b" ) backup=$OPTARG ;;
    "e" ) exclude=("${exclude[@]}" "$OPTARG") ;;
    "i" ) instdir="$OPTARG" ;;
    "r" ) relative=1 ;;
    "n" ) overwrite=0 ;;
    "d" ) dryrun=1 ;;
    "c" ) copy=1 ;;
    "h" ) echo "$HELP" 1>&2; exit;;
    * ) echo "$HELP" 1>&2; exit 1;;
  esac
done

if [[ "$OSTYPE" =~ cygwin ]];then
  # ln wrapper{{{
  ln () {
    opt="/H"
    if [ "$1" = "-s" ];then
      opt=""
      shift
    fi
    target="$1"
    if [ -d "$target" ];then
      opt="/D $opt"
    fi
    if [ $# -eq 2 ];then
      link="$2"
    elif [ $# -eq 1 ];then
      link=$(basename "$target")
    else
      echo "usage: ln [-s] <target> [<link>]"
      echo "       -s for symbolic link, otherwise make hard link"
      return
    fi
    t_winpath=$(cygpath -w -a "$target")
    t_link=$(cygpath -w -a "$link")
    cmd /c mklink $opt "$t_link" "$t_winpath" > /dev/null
  } # }}}
fi


myinstall () {
  origin="$1"
  target="$2"
  if [ -z "$origin" ] || [ -z "$target" ];then
    echo "Wrong args for myinstall: origin=$origin, target=$target"
    exit 1
  fi

  install_check=1
  if [ $dryrun -eq 1 ];then
    install_check=0
  fi
  if [ "$(ls "$target" 2>/dev/null)" != "" ];then
    exist=("${exist[@]}" "$(basename "$target")")
    if [ $dryrun -eq 1 ];then
      echo -n ""
    elif [ $overwrite -eq 0 ];then
      install_check=0
    elif [ "$backup" != "" ];then
      mv "$target" "${target}.$backup"
    else
      rm "$target"
    fi
  else
    newlink=("${newlink[@]}" "$(basename "$target")")
  fi
  if [ $install_check -eq 1 ];then
    mkdir -p "$(dirname "$target")"
    if [ $copy -eq 1 ];then
      cp -r  "$origin" "$target"
    else
      ln -s  "$origin" "$target"
    fi
  fi
}

if [ $relative -eq 1 ];then
  curdir=$(pwd)
fi
echo "**********************************************"
echo "Install .X to $instdir"
echo "**********************************************"
echo
if [ $dryrun -ne 1 ];then
  mkdir -p "$instdir"
else
  echo "*** This is dry run, not install anything ***"
fi

for f in .*;do
  for e in "${exclude[@]}";do
    flag=0
    if [ "$f" = "$e" ];then
      flag=1
      break
    fi
  done
  if [ $flag = 1 ];then
    continue
  fi

  myinstall "$curdir/$f" "$instdir/$f"
done

# subversion config
myinstall "$curdir/.subversion.config" "$instdir/.subversion/config"

# w3m
for f in .w3m/*;do
  myinstall "$curdir/$f" "$instdir/$f"
done

# neovim
myinstall "$curdir/.vimrc" "$instdir/.config/nvim/init.vim"

# Summary
if [ $dryrun -eq 1 ];then
  echo "Following files don't exist:"
else
  echo "Following files were newly installed:"
fi
echo "  ${newlink[*]}"
echo
echo -n "Following files existed"
if [ $dryrun -eq 1 ];then
  echo "Following files exist:"
elif [ $overwrite -eq 0 ];then
  echo "Following files exist, remained as is:"
elif [ "$backup" != "" ];then
  echo "Following files existed, backups (*.$backup) were made:"
else
  echo "Following files existed, replaced old one:"
fi
echo "  ${exist[*]}"
echo
