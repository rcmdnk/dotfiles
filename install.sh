#!/usr/bin/env bash

exclude=('.' '..' '.DS_Store' '.svn' '.git' 'LICENSE' 'README.md' '.gitignore' '.vimrc.not_used' '.vimrc.dein' '.vimrc.neobundle' '.subversion.config' '.dein.toml' '.dein_lazy.toml' '.w3m' '.config' '.rye' '.cursor')
only_inside=(.vim)
instdir="$HOME"

backup=""
overwrite=1
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
      -n  Don't overwrite if file is already exist
      -d  Dry run, don't install anything
      -c  Copy files, instead of making links.
      -s  Use 'pwd' instead of 'pwd -P' to make a symbolic link
      -h  Print Help (this message) and exit
"

while getopts b:e:i:ndcsh OPT;do
  case $OPT in
    "b" ) backup=$OPTARG ;;
    "e" ) exclude=("${exclude[@]}" "$OPTARG") ;;
    "i" ) instdir="$OPTARG" ;;
    "n" ) overwrite=0 ;;
    "d" ) dryrun=1 ;;
    "c" ) copy=1 ;;
    "s" ) curdir=$(pwd) ;;
    "h" ) echo "$HELP" 1>&2; exit;;
    * ) echo "$HELP" 1>&2; exit 1;;
  esac
done

myinstall () {
  local origin="$1"
  local target="$2"
  if [ -z "$origin" ] || [ -z "$target" ];then
    echo "Wrong args for myinstall: origin=$origin, target=$target"
    exit 1
  fi

  local install_check=1
  if [ $dryrun -eq 1 ];then
    install_check=0
  fi
  if [ "$(ls "$target" 2>/dev/null)" != "" ];then
    exist=("${exist[@]}" "${target/$instdir\//}")
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
    newlink=("${newlink[@]}" "${target/$instdir\//}")
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
  [[ -e "$f" ]] || continue
  for e in "${exclude[@]}";do
    flag=0
    if [ "$f" = "$e" ];then
      flag=1
      break
    fi
  done
  if [ "$flag" = 1 ];then
    continue
  fi

  for o in "${only_inside[@]}";do
    flag=0
    if [ "$f" = "$o" ];then
      flag=1
      break
    fi
  done
  files=()
  if [ "$flag" = 1 ];then
    mkdir -p "$instdir/$f"
    for ff in "$curdir/$f"/*;do
      [[ -e "$ff" ]] || continue
      files=("${files[@]}" "$f/$ff")
    done
  else
    files=("$f")
  fi
  for ff in "${files[@]}";do
    myinstall "$curdir/$ff" "$instdir/$ff"
  done
done

# subversion config
myinstall "$curdir/.subversion.config" "$instdir/.subversion/config"

# w3m
for f in .w3m/*;do
  [[ -e "$f" ]] || continue
  myinstall "$curdir/$f" "$instdir/$f"
done

# rye
myinstall "$curdir/.rye/config.toml" "$instdir/.rye/config.toml"

# cursor
if [[ "$OSTYPE" =~ darwin ]];then
  cursor_dir="$instdir/Library/Application Support/Cursor/User"
elif type cmd.exe  >& /dev/null;then
  winuser="$(cmd.exe /c echo %USERNAME% 2>/dev/null|tr -d '\r')"
  cursor_dir="/mnt/c/Users/$winuser/AppData/Roaming/Cursor/User"
else
  cursor_dir="$instdir/.config/Cursor/User"
fi
if [ -d "$cursor_dir" ];then
  myinstall "$curdir/.cursor/settings.json" "$cursor_dir/settings.json"
  myinstall "$curdir/.cursor/keybindings.json" "$cursor_dir/keybindings.json"
fi

# config
mkdir -p "$instdir/.config"
for f in .config/*;do
  [[ -e "$f" ]] || continue
  if [ -d "$f" ];then
    mkdir -p "$instdir/$f"
    for ff in "$f"/*;do
      [[ -e "$ff" ]] || continue
      myinstall "$curdir/$ff" "$instdir/$ff"
    done
  else
    myinstall "$curdir/$f" "$instdir/$f"
  fi
done

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
