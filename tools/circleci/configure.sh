#!/usr/bin/env sh

DOTFILES_ROOT=$(pwd -P)
# shellcheck source=../../scripts/tools
. "$DOTFILES_ROOT/scripts/tools"

# Generate a Zsh completion file in the repository-managed completion path.
if command -v circleci >/dev/null 2>&1; then
    info "Installing CircleCI CLI completions"
    completion_dir=${ZSH_GENERATED_COMPLETIONS:-"$DOTFILES_ROOT/shell/zsh/completions/generated"}
    mkdir -p "$completion_dir"
    circleci completion zsh >"$completion_dir/_circleci"
    success "CircleCI CLI completions installed."
else
    warning "circleci command not found. Skipping completion installation."
fi
