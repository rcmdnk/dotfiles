# Use Vim in MacVim, if better
vimversion=`vim --version`
vimvn=`echo "$vimversion"|grep "Vi IMproved"|cut -d' ' -f 5` 2>/dev/null
vimpatches=`echo "$vimversion"|grep "patches"|cut -d' ' -f 3|cut -d'-' -f2` 2>/dev/null
vimluacheck=`echo "$vimversion"|grep lua|grep -v Linking|awk '{split($0,tmp,"lua")}{print substr(tmp[1],length(tmp[1]),1)}'`
mvimversion=`mvim --version`
mvimvn=`echo "$mvimversion"|grep "Vi IMproved"|cut -d' ' -f 5` 2>/dev/null
mvimpatches=`echo "$mvimversion"|grep "patches"|cut -d' ' -f 3|cut -d'-' -f2` 2>/dev/null
mvimluacheck=`echo "$mvimversion"|grep lua|grep -v Linking|awk '{split($0,tmp,"lua")}{print substr(tmp[1],length(tmp[1]),1)}'`

mvimflag=0
if [ "$mvimluacheck" = "+" -a "$vimluacheck" = "+" ];then
  mvimflag=2
elif [ "$mvimluacheck" = "-" -a "$vimluacheck" = "-" ];then
  mvimflag=2
elif [ "$mvimluacheck" = "+" -a "$vimluacheck" = "-" ];then
  mvimflag=1
else
  mvimflag=0
fi

if [ $mvimflag -eq 2 ];then
  vimret=`echo -n '$xx = '$mvimvn' <=> '$vimvn';print "$xx \n"'|perl`
  if [ $vimret -eq 1 ];then
    mvimflag=1
  elif [ "$mvimpatches" = "" ];then
    mvimflag=0
  elif [ "$vimpatches" = "" ];then
    mvimflag=1
  else
    vimret=`echo -n '$xx = '$mvimpatches' <=> '$vimpatches';print "$xx \n"'|perl`
    if [ $vimret -eq 1 ];then
      mvimflag=1
    else
      mvimflag=0
    fi
  fi
fi

if [ $mvimflag -eq 1 ];then
  alias vim="mvim"
  alias vimdiff="mvimdiff"
fi

# ssh agent
if [ "$SSH_AUTH_SOCK" = "" ];then
  #export SSH_AUTH_SOCK=`/usr/sbin/lsof|grep ssh-agent|grep Listeners|awk '{print $8}'`
  sock_tmp=(`ls -t /tmp/launch*/Listeners`)
  for s in ${sock_tmp[@]};do
    export SSH_AUTH_SOCK=$s
    ssh-add -l >& /dev/null
    if [ $? -eq 0 ];then
      break
    fi
    unset SSH_AUTH_SOCK
  done
  unset sock_tmp
fi

# competion from brew
brew_completion=`brew --prefix 2>/dev/null`/etc/bash_completion
if [ $? -eq 0 ] && [ -f "$brew_completion" ];then
  source $brew_completion
fi
