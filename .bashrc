#!/usr/bin/env bash
# .bashrc

# {{{ Initialization
# Load common functions
source "$HOME/.commonrc"

# First, reset all pathes (PATH LD_LIBRARY_PATH PYTHONPATH PKG_CONFIG_PATH)
_reset_path

# Reset PROMPT_COMMAND
PROMPT_COMMAND=""
# }}}

# Source global definitions {{{
# Most of systems have useful default bashrc, load it first on the clean status
_source_file /etc/bashrc

# Remove the last ";" from PROMPT_COMMAND
# }}}

# Manage PROMPT_COMMAND {{{
# Remove `;`, Necessary for Mac Terminal.app
PROMPT_COMMAND="${PROMPT_COMMAND%;}"

# Reset PROMPT_COMMAND at busybox, which makes conflicts
if type busybox >& /dev/null;then
  PROMPT_COMMAND=""
fi

# Append to the history file after every command
PROMPT_COMMAND="${PROMPT_COMMAND:+${PROMPT_COMMAND};}history -a"
# }}}

# Set path {{{
_set_path
# }}}

# Shell/Environmental variables {{{
_set_env

# Prompt
PS1="[\\h \\W]\$ "
# }}}

# shopt {{{
shopt -s checkwinsize # Update the window size after each command
shopt -s dotglob # Include dot files in the results of pathname expansion
shopt -s extglob # Extended pattern matching is enabled.
shopt -s no_empty_cmd_completion # Don't complete for an empty line
shopt -s cdspell # Auto spell correction at cd
if [[ "${BASH_VERSINFO[0]}" -ge 4 ]];then
  shopt -s dirspell # Auto spell correction at tab-completion for cd
fi
# }}} shopt

# Set stty {{{
_set_stty
# }}}

# Alias, functions {{{
_set_alias
_set_function
_gnu_bsd_compatibility

# Suffix aliases/auto cd {{{
if [[ "${BASH_VERSINFO[0]}" -ge 4 ]];then
  _suffix_vim=(md markdown txt text tex cc c C cxx h hh java py rb sh)
  alias_function() {
    eval "${1}() $(declare -f "${2}" | sed 1d)"
  }
  if ! type orig_command_not_found_handle >& /dev/null;then
    if type command_not_found_handle >& /dev/null;then
      alias_function orig_command_not_found_handle command_not_found_handle
    else
      orig_command_not_found_handle () {
        echo "bash: $1: command not found"
        return 127
      }
    fi
  fi
  command_not_found_handle() {
    cmd="$1"
    args=("$@")
    if [[ -f "$cmd" ]];then
      if echo " ${_suffix_vim[*]} "|grep -q "${cmd##*.}";then
        if type vim >& /dev/null;then
          vim "${args[@]}"
          return $?
        fi
      elif [[ "${cmd##*.}" = "ps1" ]];then
        if type powershell >& /dev/null;then
          powershell -F "${args[@]}"
          return $?
        fi
      fi
    fi
    orig_command_not_found_handle "${args[@]}"
  }
  shopt -s autocd # cd to the directory, if it is given as a command.
fi
# }}} Suffix aliases/auto cd
# }}} Alias, Function

# {{{ Load other files
_source_files
# }}}
