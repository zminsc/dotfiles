# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=nvim

# Aliases
if [[ -f ~/.config/bash/aliases.sh ]] then
    source ~/.config/bash/aliases.sh
else
    printf ".bashrc: could not find aliases.sh file.\n"
fi

if [[ -f ~/.config/bash/aliases-local.sh ]] then
    source ~/.config/bash/aliases-local.sh
else
    printf ".bashrc: could not find aliases-local.sh file.\n"
fi

# Lazy-load nvm
if [[ -f ~/.config/bash/lazy-load-nvm.sh ]] then
    source ~/.config/bash/lazy-load-nvm.sh
else
    printf ".bashrc: could not find lazy-load-nvm.sh file.\n"
fi

# Lazy-load gem
if [[ -f ~/.config/bash/lazy-load-gem.sh ]] then
    source ~/.config/bash/lazy-load-gem.sh
else
    printf ".bashrc: could not find lazy-load-gem.sh file.\n"
fi

# Tokyo Night prompt
if [[ -f ~/.config/bash/prompt.sh ]] then
    source ~/.config/bash/prompt.sh
else
    printf ".bashrc: could not find prompt.sh file.\n"
fi
