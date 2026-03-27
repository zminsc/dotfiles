# ----------
# Prompt
# ----------
autoload -U colors && colors
setopt PROMPT_SUBST

precmd() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    VIRTUAL_ENV_SEG="%{$fg[cyan]%}($(basename "$VIRTUAL_ENV"))%{$reset_color%} "
  else
    VIRTUAL_ENV_SEG=""
  fi

  local branch
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    branch=$(
      { git symbolic-ref --short HEAD || git rev-parse --short HEAD; } 2>/dev/null
    )
    [[ -n "$branch" ]] && GIT_SEG=" %{$fg[yellow]%}git:(${branch})%{$reset_color%}" || GIT_SEG=""
  else
    GIT_SEG=""
  fi

  PROMPT="${VIRTUAL_ENV_SEG}%{$fg[green]%}%n@%m %{$fg[magenta]%}%~%{$reset_color%}${GIT_SEG} %# "
}

# ----------
# Aliases
# ----------
alias vi="nvim"
alias python="python3"

alias gca="git add . && git commit -m"
alias gco="git checkout -b"
alias gc="git checkout"
alias gp="git push"
alias gs="git status"
alias gr="git restore"
alias grs="git restore --staged"

# ----------
# Local .zshrc
# ----------
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi
