# dotfiles

[![CI](https://github.com/TomKatom/dotfiles/actions/workflows/ci.yml/badge.svg)](https://github.com/TomKatom/dotfiles/actions/workflows/ci.yml)

Personal Linux desktop config (Hyprland on Wayland), managed with
[GNU Stow](https://www.gnu.org/software/stow/).

## Layout

Each top-level directory is a stow package that mirrors `$HOME`:

| Package   | Contents                                                           |
| --------- | ------------------------------------------------------------------ |
| `bat`     | `cat`/pager replacement (theme)                                    |
| `eza`     | `ls` replacement (theme)                                           |
| `fuzzel`  | Application launcher                                               |
| `git`     | Git pager settings (delta); identity stays in untracked `~/.gitconfig` |
| `gtk`     | GTK 3/4 settings (adw-gtk3-dark, Papirus icons) and Catppuccin CSS |
| `hypr`    | Hyprland (Lua config + modules), hypridle, hyprlock, hyprpaper, hyprsunset |
| `kitty`   | Terminal (config + Catppuccin theme)                               |
| `mako`    | Notification daemon                                                |
| `qt`      | Qt 6 theming via qt6ct (Fusion style, Catppuccin colors)           |
| `starship`| Shell prompt                                                       |
| `systemd` | User units (`cliphist.service`, `hyprland-session.target`)         |
| `waybar`  | Status bar (`config.jsonc`, `style.css`)                           |
| `xdg`     | Default applications (`mimeapps.list`)                             |
| `zsh`     | `~/.zshenv` (sets `ZDOTDIR`) + modular config in `~/.config/zsh`   |

`.stowrc` sets `--target=~` and `--no-folding`, so only files are symlinked and
directories are real.

## Install

Requires `stow` plus the programs the configs reference (Hyprland, waybar,
cliphist, hyprpaper, hypridle, hyprsunset, hyprpolkitagent, kitty, fuzzel, thunar).
The shell and theming need:

```sh
sudo pacman -S --needed zsh starship fzf zoxide eza bat fd ripgrep dust duf git-delta \
    zsh-completions zsh-autosuggestions zsh-syntax-highlighting \
    qt6ct adw-gtk-theme papirus-icon-theme ttf-jetbrains-mono-nerd inter-font
paru -S --needed catppuccin-cursors-macchiato
```

```sh
git clone https://github.com/TomKatom/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` is idempotent: re-run it after every pull or when adding a package
or service. Then log out and back in to start the session target.

The lab WireGuard tunnel is a NetworkManager connection. Its keys are never in
the repo: put the wg-quick file at `/etc/wireguard/lab.conf` (root-only) before
running `install.sh`, which imports it once and sets it to autoconnect.

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
