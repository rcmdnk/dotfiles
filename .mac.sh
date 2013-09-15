#alias ctags='/Applications/MacVim.app/Contents/MacOS/ctags "$@"' # not in the recent MacVim

# ssh agent
if [ "$SSH_AUTH_SOCK" = "" ];then
  export SSH_AUTH_SOCK=`/usr/sbin/lsof|grep ssh-agent|grep Listeners|awk '{print $8}'`
fi
