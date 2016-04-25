# .bash_profile

# Mobaxterm sources .bashrc in /etc/profile
# But some basic files, such /etc/baseprofile which sets aliases,
# are sourced after .bashrc in profile.
# Therefore, if you want to edit aliases, need to source .bashrc here again...

#if [ -f ~/.bashrc ] && [ "$HOME" != /home/mobaxterm ];then
if [ -f ~/.bashrc ];then
  . ~/.bashrc
fi
