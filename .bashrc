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
# }}} Alias, Function

# {{{ Load other files
_source_files
# }}}

# exit code 0
:
