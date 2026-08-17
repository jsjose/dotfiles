#!/usr/bin/env sh

DOTFILES_ROOT=$(pwd -P)
# shellcheck source=../../scripts/tools
. "$DOTFILES_ROOT/scripts/tools"

if command -v mise >/dev/null 2>&1; then
    # A single tool/plugin/gem failure (flaky registry, stale version, etc.)
    # shouldn't abort the rest of `dotfiles configure` — mise itself already
    # reports per-tool status above.
    mise install || warning "mise install reported failures (see above) — continuing"
fi
