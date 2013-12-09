# get the name of the branch we are on
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

parse_git_dirty () {
  gitstat=$(git status 2>/dev/null | grep '\(Untracked\|Changes\|Changed but not updated:\)')

  if [[ $(echo ${gitstat} | grep -c "^Changes") > 0 ]]; then
	echo -n "$ZSH_THEME_GIT_PROMPT_DIRTY"
	return
  fi

  if [[ $(echo ${gitstat} | grep -c "^\(Untracked files:\)$") > 0 ]]; then
	echo -n "$ZSH_THEME_GIT_PROMPT_UNTRACKED"
	return
  fi

  if [[ $(echo ${gitstat} | grep -v '^$' | wc -l | tr -d ' ') == 0 ]]; then
	echo -n "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}
