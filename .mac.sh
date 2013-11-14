#alias ctags='/Applications/MacVim.app/Contents/MacOS/ctags "$@"' # not in the recent MacVim

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

# brew api token
if [ -f ~/.brew_api_token ];then
  source ~/.brew_api_token
fi
