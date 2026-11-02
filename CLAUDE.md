# CLAUDE.md

This repo is the single source of truth for the configuration of Tom's workstation.
If it isn't in this repo, it isn't part of the system.

## Machine

Used for C++ development, low-level research and general productivity.

- **Hardware:** HP Elite Mini 800 G9, i7-12700T, Intel UHD 770 iGPU, 64 GB DDR5,
  1 TB NVMe + 512 GB NVMe, TP-Link Archer TX20UH Wi-Fi (in-kernel `rtw89`),
  TP-Link UB500 Plus Bluetooth
- **OS:** Arch Linux (fresh install, Nov 2026)
- **Kernel:** `linux-zen`, with `linux-lts` as fallback
- **Boot:** systemd-boot + UKIs, Secure Boot via `sbctl`
- **Disk:** LUKS2 unlocked with TPM2 + PIN, Btrfs
- **Snapshots:** snapper + snap-pac for `/`, btrbk for `/home`

## Desktop stack

- **Login:** greetd + tuigreet, launches `start-hyprland` (no uwsm)
- **Compositor:** Hyprland 0.56, configured in **Lua** (`~/.config/hypr/hyprland.lua`).
  `hyprland.conf`/hyprlang is deprecated since 0.55 — never write it.
  API reference: `/usr/share/hypr/stubs/hl.meta.lua`.
- **Hypr tools:** hyprlock, hypridle, hyprpaper, hyprsunset, hyprpicker, hyprshutdown,
  hyprpolkitagent — these still use their own `.conf` files
- **Portals:** xdg-desktop-portal-hyprland, xdg-desktop-portal-gtk
- **Bar:** waybar · **Launcher:** fuzzel · **Notifications:** mako · **Terminal:** kitty
- **File manager:** thunar + gvfs + tumbler
- **Audio:** pipewire, pipewire-pulse, pipewire-alsa, pipewire-jack, wireplumber, pavucontrol
- **Network/BT:** NetworkManager (iwd backend), network-manager-applet, bluez, bluez-utils, blueman
- **Clipboard:** wl-clipboard + cliphist · **Screenshots:** grim + slurp + satty
- **Misc:** brightnessctl, playerctl, gnome-keyring + libsecret, xdg-user-dirs, xdg-utils
- **Qt:** qt5-wayland, qt6-wayland
- **Fonts:** noto-fonts, noto-fonts-emoji, ttf-jetbrains-mono-nerd, inter-font
- **Theming:** adw-gtk-theme, papirus-icon-theme, nwg-look
- **Color scheme:** [Catppuccin Macchiato](https://catppuccin.com/palette) — everything
  (compositor, lock screen, bar, launcher, notifications, terminal, GTK/Qt, editor, shell
  prompt) must use it. Use the official palette values; don't invent colors.
- **Shell/editor:** zsh (no plugins yet), neovim (stock)
- **Not installed yet:** QoL CLI tools (starship, fzf, zoxide, eza, bat, ...)

## Priorities

1. **Performance** first
2. **Security** second
3. Comfortable but **not bloated** — every package and daemon must earn its place

## Repo layout

- Each top-level directory is a GNU Stow package mirroring `$HOME` (`.stowrc`: target `~`, `--no-folding`).
- `install.sh` is the idempotent entry point: stows `PACKAGES` and enables user `SERVICES`.
  Adding a package or service means adding it to those arrays.
- `hypr/`: `hyprland.lua` only `require()`s modules under `modules/`, one concern per module.
  Each module runs in its own scope — modules cannot share locals.
- `systemd/`: user units. Session services hang off `graphical-session.target`
  (`PartOf=` + `WantedBy=`), which `hyprland-session.target` binds to.

## Rules

### Infrastructure as code
- **No manual configuration on the machine without Tom's explicit approval.** Every change
  (dotfiles, packages, services, system settings) is made through this repo and applied by
  its scripts, so the machine can be rebuilt from it.
- If something can only be done manually, stop and ask first, then capture it in the repo.

### Git workflow
- Trunk-based. Trunk is `master`: protected, squash-merge only, never commit to it directly.
- Work on short-lived feature branches off `master`.
- Pick up `master`'s latest changes by **rebasing** onto it — never merge `master` into a branch.
- When done, open a PR and squash-merge it into `master`.
- PRs are small and responsible for a **single thing**.

### Code
- **Never commit secrets** (keys, tokens, passwords, Wi-Fi credentials, personal hostnames/IPs).
- **DRY** — don't repeat yourself; factor out shared values and logic.
- **Self-documenting** — don't bombard config or code with comments. Comment only what is
  genuinely unclear (non-obvious behaviour, workarounds, the "why").
