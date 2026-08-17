#!/usr/bin/env sh

DOTFILES_ROOT=$(pwd -P)
# shellcheck source=../../scripts/tools
. "$DOTFILES_ROOT/scripts/tools"

OUT="${K9S_CONFIG_DIR}/skins"
mkdir -p "$OUT"

TARBALL=$(mktemp)
HTTP_CODE=$(curl -s -L -o "$TARBALL" -w "%{http_code}" https://github.com/catppuccin/k9s/archive/main.tar.gz)
if [ "$HTTP_CODE" = "200" ]; then
    tar xz -C "$OUT" --strip-components=2 -f "$TARBALL" k9s-main/dist
    success "k9s catppuccin skins installed"
else
    warning "Failed to download k9s catppuccin skins (HTTP $HTTP_CODE). Skipping."
fi
rm -f "$TARBALL"
