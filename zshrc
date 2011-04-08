# Disable extended filename globbing
unsetopt extendedglob

source "$HOME/.zsh/aliases.sh"
source "$HOME/.zsh/git.sh"

autoload colors; colors;
# Setup the prompt with pretty colors
setopt prompt_subst


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

bindkey "5C" forward-word
bindkey "5D" backward-word

export EDITOR="vim"
export GEM_OPEN_EDITOR="redcar"

[[ -s $HOME/.screeninator/scripts/screeninator ]] && . "$HOME/.screeninator/scripts/screeninator"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
