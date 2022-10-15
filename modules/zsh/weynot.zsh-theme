#!/usr/bin/env zsh

local LAST_EXIT_CODE=$?

ZSH_THEME_GIT_PROMPT_PREFIX="\e[1;30m:: %{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚ "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}⚑ "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖ "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}▴ "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}§ "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[white]%}◒ "

function _user_host() {
	local me
	if [[ -n $SSH_CONNECTION ]]; then
		me="\Ufbcb %n"
	elif [[ $LOGNAME != $USER ]]; then
		me="%n"
	fi
	if [[ -n $me ]]; then
		echo "\e[34m${me}\e[1;30m :: %{$reset_color%}"
	fi
}

precmd() {
	print -P "\n$(_user_host)%{$fg[blue]%}%2~%{$reset_color%}%{$fg[red]%} %{$reset_color%}$(git_prompt_info)%{$fg[cyan]%}%{$reset_color%}"
}

PROMPT="%(?.%F{white}.%F{red}$LAST_EXIT_CODE )❯%f " # Display a red prompt char on failure

# ------------------------------------------------------------------------------
#
# List of prompt format strings:
#
# prompt:
# %F => color dict
# %f => reset color
# %~ => current path
# %* => time
# %n => username
# %m => shortname host
# %(?..) => prompt conditional - %(condition.true.false)
#
# ------------------------------------------------------------------------------

