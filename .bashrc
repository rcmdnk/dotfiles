# shellcheck shell=bash
# .bashrc

# {{{ Initialization
# Load common functions
# shellcheck disable=SC1091
source "$HOME/.commonrc"

# First, reset all pathes (PATH LD_LIBRARY_PATH PYTHONPATH PKG_CONFIG_PATH)
_reset_path

# Reset PROMPT_COMMAND
PROMPT_COMMAND=""
# }}}

# Source global definitions {{{
# Most of systems have useful default bashrc, load it first on the clean status
_source_file /etc/bashrc
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
_set_prompt

_set_mise () { # {{{
  if ! type mise >& /dev/null;then
    return
  fi
  export MISE_SHELL=bash
  export __MISE_ORIG_PATH="$PATH"

  mise() {
    local command
    command="${1:-}"
    if [ "$#" = 0 ]; then
      command mise
      return
    fi
    shift

    case "$command" in
    deactivate|shell|sh)
      # if argv doesn't contains -h,--help
      if [[ ! " $* " =~ " --help " ]] && [[ ! " $* " =~ " -h " ]]; then
        eval "$(command mise "$command" "$@")"
        return $?
      fi
      ;;
    esac
    command mise "$command" "$@"
  }

  _mise_hook() {
    local previous_exit_status=$?;
    eval "$(mise hook-env -s bash)";
    return $previous_exit_status;
  };
  if [[ ";${PROMPT_COMMAND:-};" != *";_mise_hook;"* ]]; then
    PROMPT_COMMAND="_mise_hook${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
  fi
  if [ -z "${_mise_cmd_not_found:-}" ]; then
      _mise_cmd_not_found=1
      if [ -n "$(declare -f command_not_found_handle)" ]; then
          _mise_cmd_not_found_handle=$(declare -f command_not_found_handle)
          eval "${_mise_cmd_not_found_handle/command_not_found_handle/_command_not_found_handle}"
      fi

      command_not_found_handle() {
          if mise hook-not-found -s bash -- "$1"; then
            _mise_hook
            "$@"
          elif [ -n "$(declare -f _command_not_found_handle)" ]; then
              _command_not_found_handle "$@"
          else
              echo "bash: command not found: $1" >&2
              return 127
          fi
      }
  fi

  export MISE_TRUST_REPO="rcmdnk"
} # }}}
_set_mise

# Suffix aliases/auto cd {{{
if [[ "${BASH_VERSINFO[0]}" -ge 4 ]];then
  _suffix_vi=(md markdown txt text tex cc c C cxx h hh java py rb sh)
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
      if echo " ${_suffix_vi[*]} "|grep -q " ${cmd##*.} ";then
        if type vi >& /dev/null;then
          vi "${args[@]}"
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

# exit code 0
:
