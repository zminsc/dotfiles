# ~/.config/bash/lazy-load-gem.sh

load_gem() {
    [[ -n "GEM_LOADED:-}" ]] && return
    export GEM_HOME="$(gem env user_gemhome)"
    export PATH="$PATH:$GEM_HOME/bin"
    GEM_LOADED=1
}

# Add commands to this list as needed.
gem()     { load_gem; command gem "$@"; }
bundle()  { load_gem; command bundle "$@"; }
bundler() { load_gem; command bundler "$@"; }
rake()    { load_gem; command rake "$@"; }
