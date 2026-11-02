# dotfiles

[![CI](https://github.com/TomKatom/dotfiles/actions/workflows/ci.yml/badge.svg)](https://github.com/TomKatom/dotfiles/actions/workflows/ci.yml)

Personal Linux desktop config (Hyprland on Wayland), managed with
[GNU Stow](https://www.gnu.org/software/stow/).

## Layout

Each top-level directory is a stow package that mirrors `$HOME`:

| Package   | Contents                                                           |
| --------- | ------------------------------------------------------------------ |
| `hypr`    | Hyprland (Lua config + modules), hypridle, hyprlock, hyprpaper, hyprsunset |
| `systemd` | User units (`cliphist.service`, `hyprland-session.target`)         |

`.stowrc` sets `--target=~` and `--no-folding`, so only files are symlinked and
directories are real.

## Install

Requires `stow` plus the programs the configs reference (Hyprland, waybar,
cliphist, hyprpaper, hypridle, hyprsunset, hyprpolkitagent, kitty, fuzzel, thunar).

```sh
git clone https://github.com/TomKatom/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` is idempotent: re-run it after every pull or when adding a package
or service. Then log out and back in to start the session target.

## Adding things

- **Package:** create `<name>/.config/...`, add `<name>` to `PACKAGES` in `install.sh`.
- **Service:** add the unit under `systemd/.config/systemd/user/`, add it to `SERVICES`
  in `install.sh` (it needs `WantedBy=graphical-session.target`).

## Development

```sh
uv tool install pre-commit
pre-commit install
pre-commit run --all-files
```

CI (GitHub Actions, hosted runners) runs the same hooks plus a Lua syntax check,
a `stow --simulate` dry run, a check that `install.sh` lists every package, and
`systemd-analyze verify` on the units. Changes to `master` go through pull
requests with squash merge.
