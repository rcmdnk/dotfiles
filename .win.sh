#!/bin/bash

# settings {{{
# for cmd.exe, change to UTF8 (default is 932:sjis)
# 65000 UTF-7
# 65001 UTF-8
# 50220 JIS
# 20932 EUC-JP
#   932 SJIS
chcp.com 65001 >/dev/null

# COMSPEC (especially for Octopress)
export COMSPEC=/cygdrive/c/Windows/System32/cmd.exe

# display
export DISPLAY=${DISPLAY:=":0.0"}

# Chocolatey
chocolatey="/cygdrive/c/ProgramData/chocolatey/chocolateyinstall/chocolatey.cmd"
alias choco="$chocolatey"
alias cinst="$chocolatey install"
alias clist="$chocolatey list"
alias cpack="$chocolatey pack"
alias cpush="$chocolatey push"
alias cuninst="$chocolatey uninstall"
alias cup="$chocolatey update"
alias cver="$chocolatey version"

# unset tmp/temp (=C:\Users\user\AppData\Local\Temp)
# for Chocolatey (otherwise it complains...)
#unset tmp temp

#}}}

# alias {{{
alias open='cygstart'
alias mail='email'
#}}}

# Use Windows' symbolic link {{{
# On Windows 10, it needs Administrator's right
# For normal user, it makes shortcut for Windows
#export CYGWIN="winsymlinks:native"
export CYGWIN="winsymlinks:nativestrict"
#}}}

# moba xterm {{{
if [ "$HOME" = "/home/mobaxterm" ];then
  unalias apt-cyg >& /dev/null
  hash -r
  function apt-cyg () {
    PATH=/bin:$PATH /bin/apt-cyg "$@"
  }
fi
#}}}
