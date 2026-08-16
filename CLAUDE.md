# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Safety (read before touching anything)

This is a personal dotfiles repo that can modify real system/user config under `$HOME`. Full rules live in `@AGENTS.md` — key points:

- Default to read/inspect mode. Never run `./scripts/bootstrap`, `scripts/apply`, `scripts/install`, or `scripts/configure` (or the `dotfiles apply`/`install`/`configure` CLI equivalents) unless explicitly requested — they write real symlinks into `$HOME` and `install.conf.yaml` has `clean: force: true` on `~/`, `~/.config`, and the VS Code user dir.
- Prefer targeted validation (a single script or file) over full apply flows.
- Never expose secrets from `~/.localrc` or other local/credential files.
- Call out Darwin-vs-Linux impact before touching OS-conditional paths (`install.conf.yaml` uses `if: "[ \`uname\` = Darwin ]"`).

`docs/` is the source of truth for how this repo works: `docs/ARCHITECTURE.md` (mental model, execution flow, shell consolidation), `docs/TOPIC-AUTHORING.md` (topic hooks contract), `docs/CUSTOMIZATION.md`, `docs/TROUBLESHOOTING.md`.

## Structure

Topic-oriented, domain-split: `etc/` (home dotfiles), `os/mac/` (OS-specific + Homebrew), `shell/zsh/` (zsh/Zim/p10k), `tools/*` (per-tool config), `langs/*`, `editors/*`, `git/`, `harnesses/*` (AI tool configs — see below), `bin/`, `scripts/`.

Each topic can define optional hooks, auto-discovered anywhere under the repo root: `install.sh`, `configure.sh`, `update.sh`, `exports.sh`, `aliases.sh`, `functions.sh`. See `docs/TOPIC-AUTHORING.md` for the contract and execution order.

## Shell config is a build step

`shell/configure.sh` consolidates fragments from every topic's `exports.sh`/`aliases.sh`/`functions.sh` into generated files under `shell/source/*` (gitignored). **Edit the source fragments in each topic, never the generated `shell/source/*` files** — they get overwritten. Regenerate with `dotfiles configure` (or `./shell/configure.sh` directly) after editing a fragment.

## harnesses/claude/ is the live global Claude config

`harnesses/claude/CLAUDE.md` and `harnesses/claude/settings.json` are symlinked to `~/.claude/CLAUDE.md` and `~/.claude/settings.json` via `install.conf.yaml`. Editing them changes the user's *global* Claude Code config used in every repo, not just this one — treat edits there with more care than repo-local changes. This project-root `CLAUDE.md` (and `.claude/settings.json`, if present) is separate: it only applies when Claude Code is run inside this repo.

## Commands

- `make fmt` — format shell (`shfmt`), Python (`ruff format`), JSON (`biome check --write`)
- `make lint` — `ruff check .`
- `make test` — `pytest` via `uv run`
- `make check` — fmt + lint + test (run before committing)

Submodules (`dotbot`, `os/mac/iterm/themes/catppuccin`) are excluded from fmt/lint/test.

## Testing a change

Per `docs/TOPIC-AUTHORING.md`: run the changed script directly first (e.g. `./tools/mytool/configure.sh`), then a stage-level `dotfiles install`/`dotfiles configure` if needed, then `make check`. Only run a full `dotfiles apply` when explicitly asked.

## Git

Conventional commits (`feat(scope): ...`, `chore(scope): ...`). Single-branch workflow — commit directly to `master`, no PR/feature-branch convention in use.
