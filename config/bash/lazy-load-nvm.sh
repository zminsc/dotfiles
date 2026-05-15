# ~/.config/bash/lazy-load-nvm.sh

load_nvm() {
    [[ -n "${NVM_LOADED:-}" ]] && return
    if ! . /usr/share/nvm/init-nvm.sh; then
        printf "lazy-load-nvm.sh: . /usr/share/nvm/init-nvm.sh failed\n" >$2
        return 1
    fi
    NVM_LOADED=1
}

# Special handling to avoid infinite loop, as `nvm` is a function, not a binary
nvm()  { unset -f nvm; load_nvm || return 127; nvm "$@"; }

# Add commands to this list as needed.
node() { load_nvm; command node "$@"; }
npm()  { load_nvm; command npm "$@"; }
npx()  { load_nvm; command npx "$@"; }
pi()   { load_nvm; command pi "$@"; }
