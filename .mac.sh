#!/usr/bin/env bash

## Use Vim in MacVim, if better
#*********
#**done at .bashrc like:
#**      if [[ "$OSTYPE" =~ "darwin" ]] && [ -d /Applications/MacVim.app/Contents/MacOS ];then
#**        export PATH=$HOME/usr/local/bin:$HOME/usr/bin:/Applications/MacVim.app/Contents/MacOS:/usr/local/bin:$PATH
#**      else
#vimversion=`vim --version`
#vimvn=`echo "$vimversion"|grep "Vi IMproved"|cut -d' ' -f 5` 2>/dev/null
#vimpatches=`echo "$vimversion"|grep "patches"|cut -d' ' -f 3|cut -d'-' -f2` 2>/dev/null
#vimluacheck=`echo "$vimversion"|grep lua|grep -v Linking|awk '{split($0,tmp,"lua")}{print substr(tmp[1],length(tmp[1]),1)}'`
#mvimversion=`mvim --version`
#mvimvn=`echo "$mvimversion"|grep "Vi IMproved"|cut -d' ' -f 5` 2>/dev/null
#mvimpatches=`echo "$mvimversion"|grep "patches"|cut -d' ' -f 3|cut -d'-' -f2` 2>/dev/null
#mvimluacheck=`echo "$mvimversion"|grep lua|grep -v Linking|awk '{split($0,tmp,"lua")}{print substr(tmp[1],length(tmp[1]),1)}'`
#
#mvimflag=0
#if [ "$mvimluacheck" = "+" -a "$vimluacheck" = "+" ];then
#  mvimflag=2
#elif [ "$mvimluacheck" = "-" -a "$vimluacheck" = "-" ];then
#  mvimflag=2
#elif [ "$mvimluacheck" = "+" -a "$vimluacheck" = "-" ];then
#  mvimflag=1
#else
#  mvimflag=0
#fi
#
#if [ $mvimflag -eq 2 ];then
#  vimret=`echo -n '$xx = '$mvimvn' <=> '$vimvn';print "$xx \n"'|perl`
#  if [ $vimret -eq 1 ];then
#    mvimflag=1
#  elif [ "$mvimpatches" = "" ];then
#    mvimflag=0
#  elif [ "$vimpatches" = "" ];then
#    mvimflag=1
#  else
#    vimret=`echo -n '$xx = '$mvimpatches' <=> '$vimpatches';print "$xx \n"'|perl`
#    if [ $vimret -eq 1 ];then
#      mvimflag=1
#    else
#      mvimflag=0
#    fi
#  fi
#fi
#
#if [ $mvimflag -eq 1 ];then
#  alias vim="mvim"
#  alias vimdiff="mvimdiff"
#fi

# ssh agent
if [ "$SSH_AUTH_SOCK" = "" ];then
  #export SSH_AUTH_SOCK=`/usr/sbin/lsof|grep ssh-agent|grep Listeners|awk '{print $8}'`
  sock_tmp=($(ls -t /tmp/com.apple.launchd.*/Listeners 2>/dev/null))
  if [ ${#sock_tmp[@]} -eq 0 ];then
    # For Mavericks or older OS X
    sock_tmp=($(ls -t /tmp/launchd-*/Listeners 2>/dev/null))
  fi
  for s in "${sock_tmp[@]}";do
    export SSH_AUTH_SOCK=$s
    ssh-add -l >& /dev/null
    ret=$?
    if [ $ret -eq 0 ] || [ $ret -eq 1 ];then
      break
    fi
    unset SSH_AUTH_SOCK
  done
  unset sock_tmp
fi


# Homebrew

brew_prefix=$(brew --prefix)
if [ $? -eq 0 ];then
  ## brew api token
  source_file ~/.brew_api_token

  ## completion from brew
  if [ "$BASH_VERSION" != "" ];then
    brew_completion="$brew_prefix/etc/bash_completion"
    if [ -f "$brew_completion" ];then
      source "$brew_completion"
    fi
  elif [ "$ZSH_VERSION" != "" ];then
    for d in "/share/zsh-completions" "/share/zsh/zsh-site-functions";do
      brew_completion="$brew_prefix/$d"
      if [ -d "$brew_completion" ];then
        fpath=($brew_completion $fpath)
      fi
    done
    autoload -Uz compinit
    compinit
  fi

  ## wrap brew (brew-wrap in brew-file)
  if [ -f "$brew_prefix/etc/brew-wrap" ];then
    source "$brew_prefix/etc/brew-wrap"
  fi

  ## brew-file setup for cmd version
  if brew command setup-file >&/dev/null;then
    eval "$(brew setup-file)"
  fi

  ## Cask application directory
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"

  ## Python
  if type -a brew >& /dev/null;then
    if [ -d "$(brew --prefix)/lib/python2.7/site-packages" ];then
      export PYTHONPATH=$(brew --prefix)/lib/python2.7/site-packages:$PYTHONPATH
    fi
  fi

  ## Openssl
  OPENSSL_PATH=$(brew --prefix)/opt/openssl
  if [ -d "$OPENSSL_PATH" ];then
    export PATH=$OPENSSL_PATH/bin:$PATH
    export LD_LIBRARY_PATH=$OPENSSL_PATH/lib:$LD_LIBRARY_PATH
    export CPATH=$OPENSSL_PATH/include:$LD_LIBRARY_PATH
  fi
fi

# JAVA_HOME
export JAVA_HOME=$(/usr/libexec/java_home)
if [ -f /System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc ];then
  export PATH=$PATH:/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources
fi

# For Gem
if [ -d /usr/local/gems ];then
  export GEM_HOME=/usr/local/gems
  export PATH=$GEM_HOME/bin:$PATH
fi
