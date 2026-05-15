# ~/.config/bash/prompt.sh

# Only configure the prompt for interactive shells.
[[ $- != *i* ]] && return

# Wrap non-printing escape sequences for proper readline cursor positioning.
yellow='\[\e[38;2;224;175;104m\]' # #e0af68
cyan='\[\e[38;2;125;207;255m\]'   # #7dcfff
purple='\[\e[38;2;187;154;247m\]' # #bb9af7
reset='\[\e[0m\]'

git_branch() {
    command git rev-parse --is-inside-work-tree &>/dev/null || return
    local branch
    branch=$(command git symbolic-ref --quiet --short HEAD 2>/dev/null \
        || command git rev-parse --short HEAD 2>/dev/null) || return
    printf ' %s(%s)%s' "$purple" "$branch" "$reset"
}

prompt() {
    PS1="${yellow}\u@\h ${cyan}\w$(git_branch)${reset} \$ ${reset}"
}

PROMPT_COMMAND=prompt
