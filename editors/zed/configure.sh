#!/usr/bin/env sh

set -e

DOTFILES_ROOT=$(pwd -P)
# shellcheck source=../scripts/tools
. "$DOTFILES_ROOT/scripts/tools"

# Install zed completion
if command -v zed >/dev/null 2>&1; then
    info "Installing zed completions"
    COMP_FILE="$ZSH_GENERATED_COMPLETIONS/_zed"
    zed --completions zsh >"$COMP_FILE"
    success "zed completions installed"
else
    info "zed command not found. Skipping completion installation."
fi
