---
name: add-topic
description: Scaffold a new dotfiles topic (install.sh/configure.sh/update.sh/exports.sh/aliases.sh/functions.sh hooks + install.conf.yaml entry) following this repo's topic-authoring conventions. Use when the user wants to add config for a new tool, editor, or language to the dotfiles repo.
---

Scaffold a new topic in this dotfiles repo per `docs/TOPIC-AUTHORING.md`.

1. Read `docs/TOPIC-AUTHORING.md` and `docs/ARCHITECTURE.md` first if not already in context.
2. Pick the right home for the topic based on the domain split: `tools/<name>/` for tool-specific setup, `editors/<name>/` for editor/IDE prefs, `langs/<name>/` for language runtimes/tooling, `etc/` only for `~/.*`-style home dotfiles, `os/mac/` for macOS-only setup.
3. Only create the hook files the topic actually needs — all hooks are optional:
   - `install.sh` — install dependencies not covered by Homebrew (`os/mac/brew/Brewfile`)
   - `configure.sh` — generate runtime state/completions, assumes `install.sh` already ran
   - `update.sh` — sync local state back into repo-managed files (used by `dotfiles update`)
   - `exports.sh` / `aliases.sh` / `functions.sh` — shell fragments, consolidated by `shell/configure.sh` into `shell/source/*` at configure time
4. Any config file the tool needs (not shell fragments) goes in the topic directory itself and gets linked via `install.conf.yaml` `link:` — do not hardcode paths inside hook scripts.
5. For hook scripts, use the logging helpers from `scripts/tools`:
   ```sh
   #!/usr/bin/env sh
   DOTFILES_ROOT=$(pwd -P)
   # shellcheck source=../../scripts/tools
   . "$DOTFILES_ROOT/scripts/tools"
   info "..."
   ```
   Use `info`/`success`/`warning`/`fail`/`user` for output; call `fail "message"` to stop on unrecoverable errors.
6. Add the topic's directory/links to `install.conf.yaml` (`create` for dirs, `link` for symlinks, `if: "[ \`uname\` = Darwin ]"` for OS-conditional entries).
7. Test per `docs/TOPIC-AUTHORING.md`: run the new script directly, then `dotfiles install`/`dotfiles configure` (only if explicitly asked to run these), then `make check`. Do not run `dotfiles apply` unless explicitly requested — see the repo's safety rules in `CLAUDE.md`/`AGENTS.md`.
