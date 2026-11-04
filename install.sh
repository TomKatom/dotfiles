#!/usr/bin/env bash
# Link dotfiles into $HOME and enable session services.
# --system first installs packages.txt and deploys system/ to / (needs sudo).
# Idempotent: re-run after every pull or after adding a package/service.
set -euo pipefail
cd "$(dirname "$(realpath "$0")")"

# Stow packages (top-level dirs of this repo) to link into $HOME
PACKAGES=(
    bat
    bin
    eza
    fuzzel
    git
    gtk
    hypr
    kitty
    mako
    ssh
    qt
    starship
    systemd
    waybar
    xdg
    zsh
)

# User services started with the graphical session.
# Each must have WantedBy=graphical-session.target in its [Install] section
# (check with: systemctl --user cat <unit>).
SERVICES=(
    hyprpolkitagent.service
    waybar.service
    cliphist.service
    hyprpaper.service
    hypridle.service
    hyprsunset.service
)

# System units enabled by --system, shipped by a package or under system/etc/systemd/system/.
SYSTEM_SERVICES=(
    greetd.service
)

install_packages() {
    local wanted missing out rc=0
    mapfile -t wanted <packages.txt
    out=$(pacman -T "${wanted[@]}") || rc=$?
    case $rc in
    0) return ;;
    127) mapfile -t missing <<<"$out" ;;
    *) return "$rc" ;;
    esac
    # paru also builds AUR entries; plain pacman only works while all of them are in the repos.
    if command -v paru &>/dev/null; then
        paru -S --needed "${missing[@]}"
    else
        sudo pacman -S --needed "${missing[@]}"
    fi
}

# Root-owned copies, not symlinks into $HOME. Asks before replacing a file that differs.
deploy_system_files() {
    local files src dst old answer
    mapfile -d '' files < <(find system -type f -print0 | sort -z)
    for src in "${files[@]}"; do
        dst="/${src#system/}"
        cmp -s "$src" "$dst" && continue
        old=/dev/null
        [[ -e "$dst" ]] && old="$dst"
        diff -u --color=auto "$old" "$src" || true
        read -rp "Install $dst? [y/N] " answer || true
        if [[ "$answer" == [yY] ]]; then
            sudo install -Dm644 "$src" "$dst"
        fi
    done
}

case "${1-}" in
--system)
    install_packages
    deploy_system_files
    sudo systemctl daemon-reload
    sudo systemctl enable "${SYSTEM_SERVICES[@]}"
    ;;
"") ;;
*)
    echo "Usage: $0 [--system]" >&2
    exit 2
    ;;
esac

stow --restow "${PACKAGES[@]}"

# WireGuard tunnel to the lab, owned by NetworkManager. Its keys stay out of the repo: the
# profile is imported once from the wg-quick file, then lives in NM's root-only keyfile.
WG_LAB=lab
WG_LAB_CONF="/etc/wireguard/$WG_LAB.conf"
if ! nmcli connection show "$WG_LAB" &>/dev/null; then
    if sudo test -f "$WG_LAB_CONF"; then
        sudo nmcli connection import type wireguard file "$WG_LAB_CONF"
    else
        echo "Skipping WireGuard: $WG_LAB_CONF not found." >&2
    fi
fi
if nmcli connection show "$WG_LAB" &>/dev/null &&
    [[ "$(nmcli -g connection.autoconnect connection show "$WG_LAB")" != yes ]]; then
    sudo nmcli connection modify "$WG_LAB" connection.autoconnect yes
fi

mkdir -p ~/Pictures/Screenshots

systemctl --user daemon-reload
systemctl --user enable "${SERVICES[@]}"

echo "Done. Log out and back in (or reboot) to start the session target."
