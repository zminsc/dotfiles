# starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

# ocaml
eval $(opam env)

# ruby
eval "$(rbenv init - --no-rehash zsh)"
