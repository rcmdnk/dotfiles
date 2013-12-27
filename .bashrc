# .bashrc

# Check if this is first time to read bashrc or not {{{
# (subshell, screen, etc...)
function reset_path () {
  if [ ! "$INIT_PATH" ];then
    # Set initial values of PATH, LD_LIBRARY_PATH, PYTHONPATH
    export INIT_PATH=$PATH
    export INIT_LD_LIBRARY_PATH=$LD_LIBRARY_PATH
    export INIT_PYTHONPATH=$PYTHONPATH
  else
    # Reset paths
    export PATH=$INIT_PATH
    export LD_LIBRARY_PATH=$INIT_LD_LIBRARY_PATH
    export PYTHONPATH=$INIT_PYTHONPATH
  fi
}
reset_path
# }}} Check if this is first time to read bashrc or not

# Function for sourcing with precheck of the file {{{
function source_file() {
  if [ $# -lt 1 ];then
    echo "ERROR!!! source_file is called w/o an argument"
    return
  fi
  arg=$1
  shift
  if [ -r $arg ]; then
    source $arg
  fi
} # }}} Function for sourcing with precheck of the file

# Source global definitions {{{
source_file /etc/bashrc
# Remove the last ";" from PROMPT_COMMAND
# Necessary for Mac Terminal.app
PROMPT_COMMAND=`echo ${PROMPT_COMMAND}|sed 's/;$//'`
# }}}

# Local path {{{
# PATH, LD_LIBRARY_PATH under HOME
#For MacVim
if [[ "$OSTYPE" =~ "darwin" ]] && [ -d /Applications/MacVim.app/Contents/MacOS ];then
  export PATH=$HOME/usr/local/bin:$HOME/usr/bin:/Applications/MacVim.app/Contents/MacOS:/usr/local/bin:$PATH
else
  export PATH=$HOME/usr/local/bin:$HOME/usr/bin:/usr/local/bin:$PATH
fi
export LD_LIBRARY_PATH=$HOME/usr/local/lib:$HOME/usr/lib:/usr/local/lib:/usr/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$HOME/usr/local/lib:$HOME/usr/lib/python:/usr/local/lib:/usr/lib/python:$PYTHONPATH
#export PYTHONHOME=$HOME/usr/lib/python:$HOME/usr/local/lib:$PYTHONPATH

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# }}} Local path

# Shell/Environmental variables {{{
# Prompt
PS1="\[\e]0;\u@\h\w\a\][\h \W]\$ "

# XMODIFIERS
#export XMODIFIERS="@im=kinput2"

# Lang
#export LANG=C
export LANG="en_GB.UTF-8"
#export LANG="en_US.UTF-8"
#export LANG="ja_JP.eucJP"
#export LANG="ja_JP.UTF-8"
#export LC_ALL="ja_JP.UTF-8"
export LC_ALL="en_GB.UTF-8"
#export LC_MESSAGES="en_GB.UTF-8"
#export LC_DATE="en_GB.UTF-8"

# Editors
export VISUAL=vim
export EDITOR=vim
export PAGER=less

# Terminfo
if [ -d $HOME/.terminfo/ ];then
  export TERMINFO=$HOME/.terminfo
elif [ -d $HOME/usr/share/terminfo/ ];then
  export TERMINFO=$HOME/usr/share/terminfo
elif [ -d $HOME/usr/share/lib/terminfo/ ];then
  export TERMINFO=$HOME/usr/share/lib/terminfo
elif [ -d /usr/share/terminfo/ ];then
  export TERMINFO=/usr/share/terminfo
elif [ -d /usr/share/lib/terminfo/ ];then
  export TERMINFO=/usr/share/lib/terminfo
fi

# For less
#export LESSCHARSET=utf-8
#ascii,dos,ebcdic,IBM-1047,iso8859,koi8-r,latin1,next

#export GREP_OPTIONS='--color=auto'
#export LESS='-R'

# TMPDIR fix for Cygwin
if [ ! "$TMPDIR" ];then
  if [ "$TMP" ];then
    export TMPDIR=$TMP
  elif [ "$TEMP" ];then
    export TMPDIR=$TEMP
  elif [ -w /tmp/$USER ];then
    export TMPDIR=/tmp
  elif [ -w /tmp ];then
    mkdir -p /tmp/$USER
    export TMPDIR=/tmp/$USER
  else
    mkdir -p ~/tmp
    export TMPDIR=~/tmp
  fi
fi

# Python
export PYTHONSTARTUP=~/.pythonstartup.py

# Trash
export TRASHLIST=~/.trashlist # Where trash list is written
export TRASHBOX=~/.Trash # Where trash will be moved in
                         # (.Trash is Mac's trash box)
export MAXTRASHBOXSIZE=1024 # Max trash box size in MB
                            # Used for clean up
if type bc >& /dev/null;then
  export MAXTRASHSIZE=`echo $MAXTRASHBOXSIZE "*" 0.1|bc -l|cut -d. -f1`
else
  export MAXTRASHSIZE=100
fi
# Trashes larger than MAXTRASHBOXSIZE will be removed by 'rm' directly

# For my clipboards
export CLIPBOARD=$HOME/.clipboard
export CLMAXHIST=50
export CLSEP="" # (C-v C-g) Use bell as a separator
export CLX="" #xsel/xclip
if [[ "$OSTYPE" =~ "linux" ]];then
  if type xsel >& /dev/null;then
    export CLXOS="xsel"
  elif type xsel >& /dev/null;then
    export CLXOS="xclip"
  fi
elif [[ "$OSTYPE" =~ "cygwin" ]];then
  if type putclip >& /dev/null;then
    export CLXOS="putclip"
  elif type xsel >& /dev/null;then
    export CLXOS="xsel"
  elif type xsel >& /dev/null;then
    export CLXOS="xclip"
  fi
elif [[ "$OSTYPE" =~ "darwin" ]];then
  if type pbcopy >& /dev/null;then
    export CLXOS="pbcopy"
    #export CLX=$CLXOS
  fi
fi

# }}} Environmental variables

# shopt {{{
shopt -s cdspell # Minor error for cd is corrected
shopt -s checkhash # Check hash before execute command in hash
#shopt -s dotglob # Include dot files in the results of pathname expansion
shopt -s histreedit # Enable to re-edit a failed history
#shopt -s histverify # Allow further modification of history
shopt -s no_empty_cmd_completion # Don't complete for an empty line
shopt -u checkwinsize # Disable to update the window size
# }}} shopt

# History {{{
HISTSIZE=10000
# HISTCONTROL:
# ignoredups # ignore duplication
# ignorespace # ignore command starting with space
# ignoreboth # ignore dups and space
# erasedups # erase a duplication in the past
export HISTCONTROL=ignoredups
export HISTIGNORE="?:??:???:????:history:cd ../"
#shopt -s histappend # append to hist (not overwrite),
                    # don't use with below share_history
export HISTTIMEFORMAT='%y/%m/%d %H:%M:%S  ' # add time to history
# Method to remove failed command {{{
#function histRemoveFail () {
#  local result=$?
#  if [ $result -ne 0 ];then
#    local n=`history 1|awk '{print $1}'`
#    if [ "x$n" != "x" ];then
#      history -d $n
#    fi
#  fi
#}
#PROMPT_COMMAND="${PROMPT_COMMAND:+${PROMPT_COMMAND};}histRemoveFail"
# }}}

# Method to share history at the same time,
# w/o failed command (bit too strong...) {{{
#shopt -u histappend # Overwrite
#function share_history () {
#  local result=$?
#  if [ $result -eq 0 ];then # put only when the command succeeded
#    history -a # append history to the file
#    history -c # remove current history
#    history -r # load history from the file
#  else
#    # don't put failed command
#    history -c
#    history -r
#  fi
#}
#PROMPT_COMMAND="${PROMPT_COMMAND:+${PROMPT_COMMAND};}share history"
# }}}

# Simple method to add history everytime {{{
PROMPT_COMMAND="${PROMPT_COMMAND:+${PROMPT_COMMAND};}history -a"
# }}}

# }}} history

# For ls color {{{
if [[ "$OSTYPE" =~ "linux" ]] || [[ "$OSTYPE" =~ "cygwin" ]];then
  # Linux
  eval `dircolors ~/.colourrc`
  if [ "$LS_COLORS" = "" ];then
    source_file $HOME/.lscolors
  fi
elif [[ "$OSTYPE" =~ "darwin" ]];then
  # Mac
  export LSCOLORS=DxgxcxdxCxegedabagacad
fi
# }}} For ls color

# Alias, Function {{{
alias l='/bin/ls'
if [[ "$OSTYPE" =~ "linux" ]] || [[ "$OSTYPE" =~ "cygwin" ]];then
  alias ls='ls --color=auto --show-control-char'
  alias la='ls -a --color=auto --show-control-char'
elif [[ "$OSTYPE" =~ "darwin" ]];then
  alias ls='ls -G'
  alias la='ls -a -G'
fi
alias badlink='find -L . -depth 1 -type l -ls'
#alias g='gmake'
alias g='make'
alias gc="make clean"
alias gcg="make clean && make"
alias bc="bc -l"
alias ssh="ssh -XC"
alias svnHeadDiff="svn diff --revision=HEAD"
alias vim="vim -X --startuptime $TMPDIR/vim.startup.log" # no X, write startup processes
alias vim="vim -X" # no X
alias vi="vim" # vi->vim
alias memo="vim ~/.memo.md"
alias vid="vim -d"
alias vinon="vim -u NONE"
#alias grep="grep --color=always"
#alias grep="grep -i" # ignore cases
alias grep="grep -s" # suppress error message
alias c="multi_clipboard -W"
alias put='multi_clipboard -x'
alias del="trash -r"
alias hischeck="history|awk '{print \$4}'|sort|uniq -c|sort -n"
alias hischeckarg="history|awk '{print \$4\" \"\$5\" \"\$6\" \"\$7\" \"\$8\" \"\$9\" \"\$10}'|sort|uniq -c|sort -n"
alias sort='LC_ALL=C sort'
alias uniq='LC_ALL=C uniq'

# noglob helpers {{{
function mynoglob_helper () {
  "$@"
  case $shopts in
    *noglob*)
      ;;
    *)
      set +f
      ;;
  esac
  unset shopts
}
alias mynoglob='shopts="$SHELLOPTS";set -f;mynoglob_helper'
# }}}

# Change words in file by sed{{{
function change () {
  case $# in
    0)
      echo "enter file name and words of before and after"
    ;;
    1)
      echo "enter words of before and after"
    ;;
    2)
      sed -i.bak "s!$2!!g" "$1"
      rm -f "$1".bak
    ;;
    3)
      sed -i.bak "s!$2!$3!g" "$1"
      rm -f "$1".bak
    ;;
    *)
      echo "enter file name and words of before and after"
    ;;
  esac
}
# }}}

# Delete trailing white space {{{
function del_tail () {
  sed -i.bak 's/ \+$//g' $1
  rm -f "$1".bak
}
# }}}

# File compression/decompression {{{
alias targz="tar xzf"
alias tarbz2="tar jxf"

function press () {
  local remove=0
  local HELP="
  usage: press [-r] directory_name [package_name]

         -r for remove original directory
         if package_name is not given, it makes file:
         directory_name.tar.gz
"
  if [ $# -eq 0 ];then
    echo $help
  elif [ "$1" = "-d" ];then
    remove=1
    shift
  fi
  local dir=${1%/*}
  case "$#" in
          0)
    echo $HELP
    ;;
          1)
    echo ${dir}
    tar czf ${dir}.tar.gz ${dir}
    ;;
          2)
    tar czf ${2} ${dir}
    ;;
  esac
  if [ $remove -eq 1 ];then
    rm -rf ${dir}
  fi
}
# }}}

## Show output result with w3m {{{
#function lw () {
#  sed -e 's/</\&lt;/g' |\
#  sed -e 's/>/\&gt;/g' |\
#  sed -e 's/\&/\&amp;/g' |\
#  sed -e 's/[^:]*/<a href="\0">\0<\/a>/' |\
#  sed -e 's/$/<br\/>/' |\
#  EDITOR='vi' w3m -T text/html
#}
# }}}

## emacs wrapper {{{
#function emacs () { command emacs $@ & }
# }}}

## SimpleNote {{{
#alias sn='vim -c "call Sn()"'
## }}}

# path: function to get full path {{{
function path () {
  if [ $# -eq 0 ];then
      echo "usage: path file/directory"
      return 1
  fi
  echo "$(cd "$(dirname $1)";pwd -P)/$(basename $1)"
} # }}}

## Directory save/move in different terminal {{{
# Directory store file
export LASTDIRFILE=$HOME/.lastDir
export PREDEFDIRFILE=$HOME/.predefDir
export WINDOWDIRFILE=$HOME/.windowDir
# Number of store directories
export NLASTDIR=20

function sd () { # Save dir {{{
  # Edit predefined dir
  if [ $# -eq 1 ] && [ "$1" = "-e" ];then
    ${EDITOR:-"vim"} ${PREDEFDIRFILE:-$HOME/.predefDir}
    return 0
  fi

  # Fix array index for ZSH
  if [ "$ZSH_VERSION" != "" ];then
    setopt localoptions ksharrays
  fi

  # Set values
  local ldf=${LASTDIRFILE:-$HOME/.lastDir}
  local nld="${NLASTDIR:-20}"

  # Set Save Dir
  local curdir="$1"
  if [ $# -eq 0 ];then
    # Current directory
    curdir=$(pwd -P)
  fi

  # Renew last directories
  touch "$ldf"
  local -a dirs
  dirs=("$curdir")
  local ndirs=${#dirs[@]}
  while read d;do
    if [ "$d" != "$curdir" ];then
      dirs=("${dirs[@]}" "$d")
    fi
  done < "$ldf"

  # Store directories
  local i=0
  rm -f "$ldf"
  while [ $i -lt $ndirs ] && [ $i -lt $NLASTDIR ];do
    echo "${dirs[$i]}" >> "$ldf"
    i=$((i+1))
  done
} # }}}

function cl () { # Change directory to the Last directory {{{
  # Fix array index for ZSH
  if [ "$ZSH_VERSION" != "" ];then
    setopt localoptions ksharrays
  fi

  # Set values
  local ldf=${LASTDIRFILE:-$HOME/.lastDir}
  touch $ldf

  # Change to the last dir
  if [ $# -eq 0 ];then
    local ld=$(head -n1 $ldf)
    if [ "$ld" != "" ];then
      cd "$ld"
      return 0
    else
      echo "There is no saved directory."
      return 1
    fi
  fi

  local HELP="
  Usage: cl [-lcph] [-n <number> ]
  If there are no arguments, you will move to the last saved directory by sd command

  Arguments:
     -l              Show saved directories
     -c              Show saved directories and choose a directory
     -C              Clear directories
     -n              Move to <number>-th last directory
     -p              Move to pre-defiend dirctory in $PREDEFDIRFILE
     -w              Move to other window's (screen/tmux) dirctory in $WINDOWDIRFILE
     -v              Move from current directory, like Vim
     -h              Print this HELP and exit
"

  # Initialize variables
  local nth=-1
  local list=0
  local choice=0
  local predef=0
  local window=0
  local vim=0
  local cleardir=0

  # OPTIND must be reset in function
  local optind_tmp=$OPTIND
  OPTIND=1

  # Get option
  while getopts clpwvCn:h OPT;do
    case $OPT in
      "l" ) list=1 ;;
      "c" ) choice=1 ;;
      "n" ) nth="$OPTARG" ;;
      "p" ) predef=1; window=0; vim=0;;
      "w" ) window=1; predef=0; vim=0;;
      "v" ) vim=1; predef=0; window=0;;
      "C" ) cleardir=1 ;;
      "h" ) echo "$HELP" 1>&2;OPTIND=$optind_tmp;return ;;
      * ) echo "$HELP" 1>&2;OPTIND=$optind_tmp;return ;;
    esac
  done
  shift $(($OPTIND - 1))
  OPTIND=$optind_tmp

  # Change to given directory
  if [ $# -gt 0 ];then
    local d="${1/#\~/${HOME}}"
    cd "$d"
    return 0
  fi

  # Use pre-defined directory file
  if [ $predef -eq 1 ];then
    ldf=${PREDEFDIRFILE:-$HOME/.predefDir}
    if [ $choice -eq 0 ] && [ $list -eq 0 ] && [ $nth -eq -1 ];then
      local ld=$(head -n1 "$ldf"|sed "s|^~|${HOME}|")
      if [ "$ld" != "" ];then
        cd "$ld"
        return 0
      else
        echo "There is no saved directory."
        return 1
      fi
    fi
  elif [ $window -eq 1 ];then
    ldf=${WINDOWDIRFILE:-$HOME/.windowDir}
  fi

  # Clear
  if [ $cleardir -eq 1 ];then
    echo > $ldf
    return 0
  fi

  # Get last directories
  local cols="$(tput cols)"
  local max_width="$((cols-8))"
  touch $ldf
  local -a dirs
  local -a dirs_show
  local ndirs
  if [ $vim -ne 1 ];then
    while read d;do
      d_show="${d/#${HOME}/~}"
      dirs=("${dirs[@]}" "${d/#\~/${HOME}}")
      if [ ${#d_show} -ge $max_width ];then
        dirs_show=("${dirs_show[@]}" "...${d_show: $((${#d_show}-$max_width+3))}")
      else
        dirs_show=("${dirs_show[@]}" "${d_show}")
      fi
      ndirs=${#dirs[@]}
    done < $ldf
  else
    IFS=$'\n'
    dirs=($(ls -d */ 2>/dev/null))
    unset IFS
    if [ "$(pwd)" != "/" ];then
      dirs=("../" "${dirs[@]}")
    fi
    dirs_show=("${dirs[@]}")
    ndirs=${#dirs[@]}
  fi

  # Check dirs
  if [ $ndirs -eq 0 ];then
    echo "There is no saved directory."
    return 1
  fi

  # Change to nth
  if [ $nth != -1 ];then
    if ! echo $nth|grep -q "^[0-9]\+$";then
      echo "Wrong number? was given: $nth"
      return 1
    elif [ $nth -gt $ndirs ];then
      echo "$ndirs (< $nth) directories are stored."
      return 1
    fi
    cd "${dirs[$((nth-1))]}"
    if [ $predef -ne 1 ];then
      sd "${dirs[$((nth-1))]}"
    fi
    return 0
  fi

  # List up
  if [ $list -eq 1 ];then
    local pager=${PAGER:-less}
    {
      local i
      for ((i=0; i<$ndirs; i++));do
        printf "%3d %-${max_width}s %3d\n" $((i+1)) "${dirs_show[$i]}" $((i+1))
      done
    } | less
    return 0
  fi

  # Set trap
  trap "clear; tput cnorm; stty echo; return 1" 1 2 3 11 15

  # Hide cursor
  tput civis 2>/dev/null || tput vi 2>/dev/null

  # Save current display
  tput smcup 2>/dev/null || tput ti 2>/dev/null

  # Hide any input
  stty -echo

  # List up and choose directory
  local header
  local ext_row
  local lines
  local max_show
  function cl_setheader () {
    if [ $vim -eq 1 ];then
      header=" Current: $(pwd)
 [n]j(down), [n]k(up), gg(top), G(bottom), [n]gg/G(go to n)
 Enter(move), q(exit)
"
    elif [ $predef -eq 0 ];then
      header=" $ndirs directories in total
 [n]j(down), [n]k(up), d(delete), p(put to pre-defined)
 gg(top), G(bottom), [n]gg/G, (go to n), Enter(select), q(exit)
"
    else
      header=" $ndirs directories in total
 [n]j(down), [n]k(up), d(delete), gg(top), G(bottom), [n]gg/G(go to n)
 Enter(select), q(exit)
"
    fi
    ext_row="$(echo "$header"|wc -l)"
    lines="$(tput lines)"
    max_show="$ndirs"
    if [ $ndirs -gt $((lines-ext_row)) ];then
      max_show=$((lines-ext_row))
    fi
  }
  cl_setheader

  function cl_printline () {
    tput cup $(($2)) 0
    local i="$(($3+1))"
    if [ $1 -eq 1 ];then
      printf "\e[7m%3d %-${max_width}s %3d\e[m" $i "${dirs_show[$3]}" $i
    else
      printf "%3d %-${max_width}s %3d" $i "${dirs_show[$3]}" $i
    fi
    tput cup $(($2)) 0
  }

  function cl_printall () {
    local offset=0
    local select=0
    if [ $# -gt 0 ];then
      offset=$1
      if [ $# -gt 1 ];then
        select=$2
      fi
    fi

    clear

    # Header
    echo "$header"

    local i
    for ((i=0; i<$((max_show)); i++));do
      if [ $((i+offset)) -eq $select ];then
        cl_printline 1 $((i+ext_row)) $((i+offset))
      else
        cl_printline 0 $((i+ext_row)) $((i+offset))
      fi
    done
  }

  # First view
  cl_printall

  # Select
  local n=0
  local n_offset=0
  local cursor_r="$ext_row"
  local ret=0
  local g=0
  local n_move=0
  tput cup $cursor_r 0

  while : ;do
    local c=""
    if [ "$ZSH_VERSION" != "" ];then
      read -s -k 1 c
    else
      read -s -n 1 c
    fi
    case $c in
      "j" )
        if [ $n_move -eq 0 ];then
          n_move=1
        fi
        for((i=0; i<n_move; i++));do
          if [ $n -eq $((ndirs-1)) ];then
            break
          elif [ $cursor_r -eq $((lines-1)) ];then
            ((n_offset++));((n++))
            cl_printall $n_offset $n
          else
            cl_printline 0 $((cursor_r)) $n
            ((cursor_r++));((n++))
            cl_printline 1 $((cursor_r)) $n
          fi
        done
        g=0
        n_move=0
        continue
        ;;
      "k" )
        if [ $n_move -eq 0 ];then
          n_move=1
        fi
        for((i=0; i<n_move; i++));do
          if [ $cursor_r -ne $ext_row ];then
            cl_printline 0 $((cursor_r)) $n
            ((cursor_r--));((n--))
            cl_printline 1 $((cursor_r)) $n
          elif [ $n_offset -gt 0 ];then
            ((n_offset--));((n--))
            cl_printall $n_offset $n
          else
            break
          fi
        done
        g=0
        n_move=0
        continue
        ;;
      "g" )
        if [ $g -eq 0 ];then
          g=1
          continue
        fi

        if [ $n_move -eq 0 ];then
          n=0
          n_offset=0
          cursor_r="$ext_row"
        elif [ $n_move -gt $ndirs ];then
          :
        elif [ $n_move -le $n_offset ];then
          n=$((n_move-1))
          n_offset=$n
          cursor_r=$ext_row
        elif [ $((n_move)) -gt $((n_offset+max_show)) ];then
          n=$((n_move-1))
          n_offset=$((n-max_show+1))
          cursor_r=$((lines-1))
        else
          n=$((n_move-1))
          cursor_r=$((ext_row+n-n_offset))
        fi
        cl_printall $n_offset $n
        n_move=0
        g=0
        continue
        ;;
      "G" )
        if [ $n_move -eq 0 ];then
          n=$((ndirs-1))
          if [ $n -ge $max_show ];then
            n_offset=$((ndirs-max_show))
            cursor_r=$((lines-1))
          else
            n_offset=0
            cursor_r=$((ext_row+n))
          fi
        elif [ $n_move -gt $ndirs ];then
          :
        elif [ $n_move -le $n_offset ];then
          n=$((n_move-1))
          n_offset=$n
          cursor_r=$ext_row
        elif [ $n_move -gt $((n_offset+max_show)) ];then
          n=$((n_move-1))
          n_offset=$((n-max_show+1))
          cursor_r=$((lines-1))
        else
          n=$((n_move-1))
          cursor_r=$((ext_row+n-n_offset))
        fi
        cl_printall $n_offset $n
        n_move=0
        continue
        ;;
      "d" )
        if [ $vim -eq 1 ];then
          continue
        fi
        unset dirs[$n];dirs=("${dirs[@]}")
        unset dirs_show[$n];dirs_show=("${dirs_show[@]}")
        ndirs=${#dirs[@]}
        sed -i ".bak" "$((n+1))d" $ldf
        rm -f ${ldf}.bak
        if [ $ndirs -eq 0 ];then
          break
        fi
        if [ $n -eq $ndirs ];then
          if [ $n_offset -gt 0 ];then
            ((n_offset--));((n--))
          else
            ((cursor_r--));((n--))
          fi
        fi
        cl_setheader
        cl_printall $n_offset $n
        continue
        ;;
      "p" )
        if [ $predef -eq 1 ] || [ $vim -eq 1 ];then
          continue
        fi
        local pdf=${PREDEFDIRFILE:-$HOME/.predefDir}
        touch $pdf
        if ! grep -q "^${dirs[$n]}$" "$pdf";then
          echo "${dirs[$n]}" >> "$pdf"
        fi
        continue
        ;;
      "q" ) break;;
      # Choose, for bash|zsh
      ""|"
")
        if [ $vim -eq 0 ];then
          d=`sh -c "echo ${dirs[$n]}"`
          if [ -d "${d}" ];then
            cd "${d}"
            if [ $predef -ne 1 ];then
              sd "${d}"
            fi
          else
            ret=1
          fi
          break
        fi
        cd "${dirs[$n]}"
        IFS=$'\n'
        dirs=($(ls -d */ 2>/dev/null))
        unset IFS
        if [ "$(pwd)" != "/" ];then
          dirs=("../" "${dirs[@]}")
        fi
        dirs_show=("${dirs[@]}")
        ndirs=${#dirs[@]}
        n=0
        n_offset=0
        cursor_r="$ext_row"
        cl_setheader
        cl_printall $n_offset $n
        continue
        ;;
      [0-9])
        if [ $n_move -gt 0 ];then
          n_move="$n_move""$c"
        else
          n_move=$c
        fi
        continue
        ;;
      "*" )
        g=0
        n_move=0
        continue;;
    esac
  done

  clear

  # Show cursor
  tput cnorm 2>/dev/null || tput vs 2>/dev/null

  # Restore display
  tput rmcup 2>/dev/null || tput te 2>/dev/null

  # Enable echo input
  stty echo

  if [ $ret -eq 1 ];then
    echo "${dirs[$n]} doesn't exist"
    return $ret
  fi
  return $ret

} # }}}

function _cl () { # {{{
  COMPREPLY=()
  local cur=${COMP_WORDS[COMP_CWORD]}
  local prev=${COMP_WORDS[COMP_CWORD-1]}
  local ldf=${LASTDIRFILE:-$HOME/.lastDir}
  if [[ $prev = -p ]];then
    ldf=${PREDEFDIRFILE:-$HOME/.predefDir}
  fi
  IFS=$'\n'
  if [[ "$cur" != -* && ( "$prev" == $1 || "$prev" == -p ) ]];then
    COMPREPLY=($( compgen -W "$(cat $ldf)" -- $cur))
  fi
  unset IFS
} # }}}
complete -F _cl cl

# }}}

# cd wrapper to use pushd {{{
function cd () {
  if [ $# = 0 ];then
    command cd
  elif [ "$1" = "-" ];then
    local opwd=$OLDPWD
    pushd . >/dev/null
    command cd $opwd
  elif [ -f "$1" ];then
    pushd . >/dev/null
    command cd $(dirname "$@")
  else
    pushd . >/dev/null
    command cd "$@"
  fi
}
# }}}

# Alias for popd {{{
alias bd="popd >/dev/null"
# }}}

# Move to actual pwd {{{
function cdpwd () {
  cd -P .
}
# }}}

# git functions {{{
function gitupdate () {
  update=0
  difffiles=`git status|grep -e "new file" -e "modified"|cut -d":" -f2`
  if [ "$difffiles" ];then
    pwd
    if [ -f ~/.gitavoid ];then
      #for f in `echo $difffiles`;do
      for f in `git ls-files`;do
        if [ ! -f $f ];then
          continue
        fi
        while read a;do
          if ret=`grep -i -q $a $f`;then
            echo "avoid word $a is included in $f!!!"
            echo $ret
            return
          fi
        done < ~/.gitavoid
      done
    else
      echo "WARNING: There is no ~/.gitavoid file!"
    fi
    printf "\n"
    update=1
  fi
  ret=`git commit -a -m "$difffiles, from $OSTYPE"`
  if echo $ret|grep -q "changed";then
    if [ $update -eq 0 ];then
      pwd
    fi
    echo $ret
    update=1
  fi

  #ret=$(git pull --rebase)
  ret=$(git pull)
  if [ "$(echo $ret|grep "Already up-to-date")" == "" ] &&\
     [ "$(echo $ret|grep "is up to date")" == "" ];then
    if [ $update -eq 0 ];then
      pwd
    fi
    echo $ret
    update=1
  fi
  ret=$(git push 2>&1)
  if ! echo $ret|grep -q "Everything up-to-date";then
    if [ $update -eq 0 ];then
      pwd
    fi
    echo $ret
  fi

  git gc >& /dev/null
}
# }}}

# man wrapper{{{
function man () {
  # Open man file with vim
  # col -b -x: remove backspace, replace tab->space
  # vim -R -: read only mode, read from stdin
  if [ $# -eq 0 ];then
    command man
  else
    # If there are any -* arguments,
    # use original man
    for m in $@;do
      if [[ $m =~ ^- ]];then
        command man $@
        return
      fi
    done
    # Then open each manual
    for m in $@;do
      if command man -W $m >&  /dev/null;then
        LANG=C command man $@|col -b -x|vim -R -
      else
        command man $@
      fi
    done
  fi
}
#alias man='LANG=C man'
# }}}

# Show 256 colors{{{
function col256 () {
  for c in {0..255};do
    local num=`printf " %03d" $c`
    printf "\e[38;5;${c}m$num\e[m"
    printf "\e[48;5;${c}m$num\e[m"
    if [ $(($c%8)) -eq 7 ];then
      echo
    fi
  done
} # }}}

# Function to calculate with perl (for decimal, etc...) {{{
function calc () {
  local eq=$(echo $@|sed "s/\^/**/g")
  echo -n '$xx ='$eq';print "$xx \n"'|perl
} # }}}

# For GNU-BSD compatibility {{{

# cp wraper for BSD cp (make it like GNU cp){{{
# Remove the end "/" and change -r to -R
if ! cp --version 2>/dev/null |grep -q GNU;then
  function cp () {
    local opt=""
    local source=""
    local dest=""
    while [ $# -gt 0 ];do
      if [[ "$1" == -* ]];then
        if [ "$1" == "-r" ];then
          opt="$opt -R"
        else
          opt="$opt $1"
        fi
      elif [ $# -eq 1 ];then
        dest="$1"
      else
        source="${source} ${1%/}"
      fi
      shift
    done
    command cp $opt $source $dest
  }
fi
# }}}

# Use common function in Mac/Unix for sed -i... w/o backup {{{
# Unix uses GNU sed
# Mac uses BSD sed
# BSD sed requires suffix for backup file when "-i" option is given
# (for no backup, need ""),
# while GNU sed can run w/o suffix and doesn't make backup file
if sed --version 2>/dev/null |grep -q GNU;then
  alias sedi='sed -i"" '
else
  alias sedi='sed -i "" '
fi
# }}}

# Revert lines in the file/std input
# Note: There is "rev" command which
#       reversing the order of characters in every line.
# Set reverse command as tac for BSD
if ! type tac >& /dev/null && \
   ! tail --version 2>/dev/null|grep -q GNU;then
  alias tac='tail -r'
fi
# }}}

# }}} Alias, Function

# stty {{{
# Disable terminal lock
tty -s && stty stop undef
tty -s && stty start undef
if [[ "$OSTYPE" =~ "darwin" ]];then
  tty -s && stty discard undef
fi
# }}}

# For screen {{{
alias screenr="screen -d -r"

## Screen wrapper {{{
#function screen () {
#  # Tips of screen for a cluster
#  # This setting keeps the host name in which screen is running
#  # for a case in the cluster,
#  # in which the host can be changed at every login
#  #
#  #touch .hostForScreen
#  #if [ $# = 0 ] || [ $1 = "-r" ] || [ $1 = "-R" ] || [ $1 = "-x" ];then
#  #  sed -i -e "/^$(hostname).*/d" .hostForScreen
#  #  hostname >> ~/.hostForScreen
#  #  # keep 10 histories
#  #  #tail -n10 ~/.hostForScreen > ~/.hostForScreen.tmp
#  #  #mv ~/.hostForScreen.tmp ~/.hostForScreen
#  ## write out DISPLAY of current terminal
#  #  echo "$DISPLAY"> ~/.display.txt
#  #fi
#
#  options="$@"
#  if [ $# = 0 ];then
#    # Don't make another screen session
#    options="-R"
#  fi
#
#  # launch screen
#  command screen $options
#}
## }}}

## Function to check remaining screen sessions in a cluster{{{
#function screen_check () {
#  touch .hostForScreen
#  for h in `cat ~/.hostForScreen`;do
#    echo "checking $h..."
#    ping $h -c 2 -w2 >& /dev/null
#    if [ $? -eq 0 ];then
#      local checklog="$(ssh -x $h "screen -ls")"
#      echo $checklog
#      if ! echo $checklog|grep -q "No Sockets found";then
#        echo $h >> ~/.hostForScreen.tmp
#      fi
#    else
#      echo $h seems not available
#    fi
#  done
#  touch ~/.hostForScreen.tmp
#  mv ~/.hostForScreen.tmp ~/.hostForScreen
## }}}

## ssh to the host which launched screen previously {{{
#function sc () {
#  touch .hostForScreen
#  local n=1
#  if [ $# -ne 0 ];then
#    n=$1
#  fi
#  local schost=`tail -n$n ~/.hostForScreen|head -n1`
#  if [ "$schost" == "" ];then
#    echo "no host has remaining screen"
#  else
#    ssh $schost
#  fi
#} # }}}

# screen exchange file
export SCREENEXCHANGE=$HOME/.screen-exchange

# Following functions/alias are also enabled before screen {{{

# Overwrite path to push to the clipboard list{{{
function path () {
  if [ $# -eq 0 ];then
      echo "usage: path file/directory"
      return 1
  fi
  fullpath="$(cd "$(dirname $1)";pwd -P)/$(basename $1)"
  echo $fullpath
  multi_clipboard -s $fullpath
} # }}}

# pwd wrapper (named as wc) to push pwd to the clipboard list{{{
function wd () {
  local curdir=`pwd -P`
  multi_clipboard -s $curdir
  echo $curdir
}
# }}}

# }}} Following functions/alias are also enabled before screen

# functions/settings only for screen sessions {{{
if [[ "$TERM" =~ "screen" ]]; then # {{{
  # "\\" doesn't work well, use \134 instead
  PS1="\[\ek\h \W\e\134\e]0;\h \w\a\]\$(\
    ret=\$?
    rand=\$((RANDOM%36));\
    if [ \$ret -eq 0 ];then\
      if [ \$rand -lt 3 ];then
        printf '\[\e[m\](^_^)\[\e[m\] \$ ';\
      elif [ \$rand -lt 5 ];then\
        printf '\[\e[m\](^_-)\[\e[m\] \$ ';\
      elif [ \$rand -lt 6 ];then\
        printf '\[\e[m\](.^.)\[\e[m\] \$ ';\
      else\
        printf '\[\e[m\](-_-)\[\e[m\] \$ ';\
      fi;\
    else\
      if [ \$rand -lt 6 ];then\
        printf '\[\e[31m\](@o@)\[\e[m\] \$ ';\
      elif [ \$rand -lt 12 ];then\
        printf '\[\e[31;1m\](>_<)\[\e[m\] \$ ';\
      elif [ \$rand -lt 18 ];then\
        printf '\[\e[35m\](*_*)\[\e[m\] \$ ';\
      elif [ \$rand -lt 24 ];then\
        printf '\[\e[34m\](T_T)\[\e[m\] \$ ';\
      elif [ \$rand -eq 30 ];then\
        printf '\[\e[34;1m\](/_T)\[\e[m\] \$ ';\
      else\
        printf '\[\e[31m\](>_<)\[\e[m\] \$ ';\
      fi\
    fi;\
    )"
  # }}}

  # Set display if screen is attached in other host than previous host {{{
  function set_display () {
    if [ -f ~/.display.txt ];then
      #local d=`grep $HOSTNAME ~/.display.txt|awk '{print $2}'`
      local d=`cat ~/.display.txt`
      export DISPLAY=$d
    fi
  }
  # }}}

fi # }}}

# }}} For screen

# Setup for each environment {{{
# Note: such PATH setting should be placed
#       at above Local path settings (before alias/function definitions)

# File used in linux
if [[ "$OSTYPE" =~ "linux" ]];then
  source_file ~/.linux.sh
fi

# File used in mac
if [[ "$OSTYPE" =~ "darwin" ]];then
  source_file ~/.mac.sh
fi

# File used in windows (cygwin)
if [[ "$OSTYPE" =~ "cygwin" ]];then
  source_file ~/.win.sh
fi

# File used for working server
source_file ~/.work.sh

# brew api token
source_file ~/.brew_api_token

# File for special settings for each machine
source_file ~/.local.sh

# }}} Setup for each environment
