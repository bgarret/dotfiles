# Disable extended filename globbing
unsetopt extendedglob

autoload colors; colors;
# Setup the prompt with pretty colors
setopt prompt_subst

# get the name of the branch we are on
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

parse_git_dirty () {
  gitstat=$(git status 2>/dev/null | grep '\(# Untracked\|# Changes\|# Changed but not updated:\)')

  if [[ $(echo ${gitstat} | grep -c "^# Changes to be committed:\|# Changed but not updated:\$") > 0 ]]; then
	echo -n "$ZSH_THEME_GIT_PROMPT_DIRTY"
	return
  fi

  if [[ $(echo ${gitstat} | grep -c "^\(# Untracked files:\)$") > 0 ]]; then
	echo -n "$ZSH_THEME_GIT_PROMPT_UNTRACKED"
	return
  fi

  if [[ $(echo ${gitstat} | grep -v '^$' | wc -l | tr -d ' ') == 0 ]]; then
	echo -n "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    echo '○'
}

PROMPT='
%{$fg_bold[blue]%}$(prompt_char)%{$reset_color%}$(git_prompt_info) %{$fg[yellow]%}%m%{$reset_color%} in %{$fg[green]%}$(collapse_pwd)%{$reset_color%}
→ '

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[green]%}|"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[green]%}|%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{$fg_bold[green]%}✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg_bold[green]%}✓%{$reset_color%}"

. "/etc/zsh_command_not_found"

alias gg='gitg &'
alias gs='git stash'
alias gsp='git stash pop'
alias mag='cd ~/code/magexpert'
alias magpro='cd ~/code/magexpert-pro'

bindkey "5C" forward-word
bindkey "5D" backward-word

export EDITOR="vim"
export GEM_OPEN_EDITOR="redcar"

[[ -s $HOME/.screeninator/scripts/screeninator ]] && . "$HOME/.screeninator/scripts/screeninator"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
