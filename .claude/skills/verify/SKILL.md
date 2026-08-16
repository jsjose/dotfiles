---
name: verify
description: Run this dotfiles repo's staged testing convention (targeted script, then stage-level dotfiles install/configure, then make check) before proposing a full dotfiles apply. Use after making or reviewing a change to a topic hook, shell fragment, or install.conf.yaml entry.
---

Verify a change in this dotfiles repo following the staged approach in `docs/TOPIC-AUTHORING.md`. Do not skip straight to `dotfiles apply` — that's the last, riskiest stage and requires explicit user request (see `CLAUDE.md`/`AGENTS.md` safety rules).

1. **Targeted script test** — if a specific hook script changed (e.g. `tools/mytool/configure.sh`), run it directly first and check its output.
2. **Stage-level test** — only if explicitly asked to actually apply changes to the system, run `dotfiles install` and/or `dotfiles configure` (whichever stage is relevant). Otherwise stop after step 1 and report what step 2/3 would do.
3. **Full flow** — `dotfiles apply` (or `./scripts/bootstrap` on a fresh machine). Never run without explicit user request.
4. **Quality checks** — always run `make check` (fmt + lint + test) before considering the change done.

Report which stages actually ran and which were skipped (and why), so the user knows exactly what touched their real `$HOME`.
