# .bash_logout

# cleanup .hostForScreen
if [ -f ~/.hostForScreen ];then
  if [ "`ps -U$USER|grep screen`" = "" ];then
    sed -i'' -e "/`hostname`/d" ~/.hostForScreen
  fi
fi
