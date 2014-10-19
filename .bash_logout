# .bash_logout

# cleanup .hostForScreen
if [ -f ~/.hostForScreen ];then
  if [ "`ps -u$USER|grep screen`" = "" ];then
    if sed --version 2>/dev/null |grep -q GNU;then
      alias sedi='sed -i"" '
    else
      alias sedi='sed -i "" '
    fi
    sedi -e "/`hostname`/d" ~/.hostForScreen
  fi
fi
#clear
echo "(-_-)/~ bye!"
