---
name: dotfiles-mise
description: Manage the ~/dotfiles repo and the machines it configures via mise dotfiles/bootstrap. Use when updating dotfiles, applying new config, editing ~/dotfiles/.config/mise/config*.toml or templates, handling bootstrap secrets, checking dotfiles status/diff, troubleshooting a broken symlink or an apply that a tool rewrote out from under mise, or deciding what a "dotfiles change" actually needs to touch. Covers the shared/machine overlay file layout, `config.toml` [dotfiles]/[tasks.bootstrap], templates, `--prompt-secrets`, OS/platform auto_env, and `bin/dotfiles-update`.
---

# Managing dotfiles with mise

`~/dotfiles` is applied with **mise dotfiles + bootstrap**, not Stow. A
`~/.config/mise` symlink points at the repo's `.config/mise/`, so editing the
repo is editing the live config. Config lives in `config.toml` plus per-platform
and per-machine overlays; anything the user calls "a dotfile" is a
`[dotfiles]` entry there, and most one-shot maintenance is **`dotfiles-update`**.

Docs: [bootstrap](https://mise.jdx.dev/bootstrap.html) (phase order, `--only`
`/--skip`, secrets preflight, "hooks run on every apply"),
[dotfiles](https://mise.jdx.dev/dotfiles.html) (commands, modes, capturing
changes), [environments](https://mise.jdx.dev/configuration/environments.html)
(`auto_env` / `MISE_ENV`), [templates](https://mise.jdx.dev/templates.html)
(Tera syntax, but [dotfiles templating](https://mise.jdx.dev/dotfiles.html) for
how `mode = "template"` renders).

## Where config lives

| File | Loaded when | Purpose |
|---|---|---|
| `~/.config/mise/config.toml` | always | Shared tools, **all** shared dotfiles, `[tasks.bootstrap]`, `[bootstrap.secrets]`, settings |
| `config.linux.toml` | auto on Linux (`auto_env`) | Linux dotfiles + pacman/AUR `[bootstrap.packages]` |
| `config.macos.toml` | auto on macOS | Homebrew formulae/casks, taps, macOS dotfiles, `[bootstrap.macos.*]` prefs |
| `config.desktop.toml` | `MISE_ENV=desktop` overlay | Desktop (Arch gaming box): Steam, peon-ping opencode plugin |
| `config.macbook.toml` | `MISE_ENV=macbook` overlay | Old Apple MacBook running Arch: evremap + systemd unit, touchpad override, no Steam/peon-ping |

Machines today: **Desktop** (Arch+Omarchy, `MISE_ENV=desktop`), **Old MacBook**
(Arch+Omarchy, `MISE_ENV=macbook`), **Work Mac** (macOS, no `MISE_ENV` — `auto_env`
picks up `config.macos.toml`). Shared bits that differ per machine are *added*
in overlays; mise packages are additive and **cannot express "absent"** — to
stop installing something on a machine, comment its entry out, don't try to
negate it. See [platform environments](https://mise.jdx.dev/configuration/environments.html#platform-environments)
and [config environments](https://mise.jdx.dev/configuration/environments.html#config-environments).

## Update everything: `@bin/dotfiles-update`

The one-command path (in `~/dotfiles/bin/dotfiles-update`, synced to `~/bin`):

```bash
dotfiles-update
```

It runs, in order: `git pull --ff-only` → `mise bootstrap dotfiles apply
--prompt-secrets` → `mise self-update` → `mise outdated` / `mise upgrade` →
`mise bootstrap packages upgrade` → `mise run bootstrap`. Step by step:

```bash
git -C ~/dotfiles pull --ff-only            # 1. pick up new config
mise bootstrap dotfiles apply --prompt-secrets   # 2. apply dotfiles, ask for missing secrets
mise self-update                            # 3. update mise itself
mise outdated && mise upgrade               # 4. upgrade [tools]
mise bootstrap packages upgrade             # 5. upgrade system packages (needs sudo/TTY)
mise run bootstrap                          # 6. re-run the bootstrap task
```

Caveats baked into `dotfiles-update` (see the [bootstrap docs](https://mise.jdx.dev/bootstrap.html) for the full pipeline):

- The system-package step is **skipped without a TTY** (sudo prompt) — under
  cron or an agent, run `mise bootstrap packages upgrade` in a real terminal.
- `mise self-update` fails silently when mise is installed via a package
  manager (AUR `mise-bin`, Homebrew) — update mise that way instead
  (`yay -S mise-bin`), not via self-update.
- `mise upgrade` respects configured version ranges: pinned tools
  (`node = "24"`, `python = "3.14.4"`) stay put unless rewritten with
  `mise upgrade --bump`.
- `mise bootstrap` re-runs tasks/hooks even when resources are unchanged, so
  edit `[tasks.bootstrap]` only with idempotent commands (it already is).

Never edit dotfiles by hand on the machine as an alternative to applying —
apply is what owns the installed files.

## Applying / checking dotfiles

```bash
mise bootstrap dotfiles status            # what's applied / what differs
mise bootstrap dotfiles diff              # preview before applying
mise bootstrap dotfiles apply             # apply; prompts before overwriting conflicts
mise bootstrap dotfiles apply --force     # overwrite conflicting existing files
mise bootstrap dotfiles apply --dry-run   # show actions without writing
mise bootstrap dotfiles apply <target>    # just one [dotfiles] key
```

State/preview commands are part of the [bootstrap command surface](https://mise.jdx.dev/bootstrap.html#inspecting-state):
`mise bootstrap status` / `--json` / `--missing` report the whole declarative
surface (packages, dotfiles, secrets, systemd units, …), and `mise bootstrap
plan` produces a dependency-ordered resource plan. `--only` / `--skip`
(`mise bootstrap --only dotfiles,tools`) narrow an apply; the [dotfiles commands](https://mise.jdx.dev/dotfiles.html#commands)
cover `status` / `diff` specifically.

Troubleshooting patterns:

- **A tool rewrites its config in place** (e.g. `nvpm`, `hyprmoncfg` via atomic
  rename) and silently breaks a symlink. The repo solves this with
  `mode = "copy"` for those entries — if the user reports a link that's become
  a real file, switch (or keep) the entry as `mode = "copy"`.
- **Whole-dir symlinks vs per-file**: omit `mode` for whole-dir symlinks;
  use `mode = "symlink-each"` for dirs that also hold untracked/machine files
  (`opencode` excludes `node_modules`/`package*.json`/`bun.lock`; `hunk`,
  `hypr`, `uwsm` use it). Dirs whose tools rewrite files in place use copy.
- **After an apply that broke self-referencing symlinks** (the one-time
  `symlink-each` migration): remove the stale whole-dir links in
  `~/.config` (`opencode`, `uwsm`, `hunk`) then re-apply with `--force`.

## Secrets

Secrets are declared in `[bootstrap.secrets]` in `config.toml` (currently
`gitlab_instance = "GITLAB_INSTANCE"` and `lazygit_owner = "LAZYGIT_OWNER"`).
They are referenced in templates as `{{ secret(name="gitlab_instance") }}`.
`mise bootstrap dotfiles apply --prompt-secrets` prompts (securely) for any
missing secrets; bootstrap [resolves secrets in a preflight](https://mise.jdx.dev/bootstrap.html#how-it-runs)
before touching the host. Docs: [bootstrap secrets](https://mise.jdx.dev/bootstrap/secrets.html).
The lazygit template bakes `gitlab_instance` into
`services:`; `lazygit_owner` is enforced by the `bootstrap` task (chown of
`~/.config/lazygit/config.yml`). When a config edit adds a secret:

- add the key under `[bootstrap.secrets]` with an env-var-style placeholder name,
- use `--prompt-secrets` when applying so the user is asked for its value,
- never hardcode a secret value in the repo or a template.

## Templates

Files with a `.tmpl` suffix and `mode = "template"` render through mise's
Tera templates at apply time (see [dotfiles templates](https://mise.jdx.dev/dotfiles.html#templates)
and [mise templates](https://mise.jdx.dev/templates.html) for the full
function set). Pattern in use:

```toml
"~/.config/kitty/kitty.conf"        = { source = "../kitty/kitty.conf.tmpl", mode = "template" }
"~/.config/fastfetch/config.jsonc"  = { source = "../fastfetch/config.jsonc.tmpl", mode = "template" }
"~/.config/lazygit/config.yml"      = { source = "templates/lazygit.config.yml",  mode = "template" }
```

Available in templates: `{{ os() }}` (e.g. `"macos"` vs `"linux"`) for
OS-specific content, `{{ secret(name="...") }}` for bootstrap secrets,
`.tmpl` source paths are relative to the config file that declares them
(`source = "templates/lazygit.config.yml"` resolves from `.config/mise`).
`{% raw %}…{% endraw %}` wraps literal text that must not be evaluated (see
the lazygit template around its customCommands). Keep `mode = "template"`
entries' targets UNMANAGED by other tools — a tool rewriting the rendered file
in place breaks the illusion just like symlinks do (see copy-mode note above).

## OS / machine-specific config

Per OS uses `auto_env` (no `MISE_ENV` needed): Linux → `config.linux.toml`,
macOS → `config.macos.toml`. Per machine uses `MISE_ENV`: `export
MISE_ENV=desktop` / `=macbook`, persisted in the shell config. The OS file
carries the platform's packages and dotfiles; the machine overlay carries
gaming/remapper/plugin deltas. When adding something only for one Arch machine,
decide whether it belongs in `config.linux.toml` (both Arch machines) or in the
`MISE_ENV` overlay (one of them). macOS-only content is additive in
`config.macos.toml`.

## Do / Don't

- **Do** run `dotfiles-update` for routine "update my dotfiles" requests.
- **Do** check `mise bootstrap dotfiles diff` before big config edits, and
  apply with `--prompt-secrets` when secrets may be new.
- **Do** keep `[tasks.bootstrap]` idempotent and safe to re-run — bootstrap
  re-runs it even when nothing changed.
- **Do** use `mise bootstrap dotfiles apply <target>` to isolate an apply to
  one entry when debugging.
- **Don't** hand-edit installed files under `~/.config` that mise owns; fix the
  repo and apply. (Exception: genuinely machine-owned files like
  `karabiner.json`, which the config deliberately leaves alone.)
- **Don't** use `mode = "symlink"` (or the default symlink mode) for tools that
  rewrite their config with atomic rename — use `mode = "copy"` or
  `symlink-each` as the repo already does for `nvpm`/`hyprmoncfg`.
- **Don't** try to "uninstall" something by omitting it — comment entries out
  per-overlay, and use `mise uninstall <tool>` / `mise bootstrap packages prune`
  for cleanup.
- **Don't** add `MISE_ENV` handling for the Work Mac — macOS is auto_env.