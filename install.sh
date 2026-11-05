#!/usr/bin/env bash
# Link dotfiles into $HOME and enable session services.
# Idempotent: re-run after every pull or after adding a package/service.
set -euo pipefail
cd "$(dirname "$(realpath "$0")")"

# Stow packages (top-level dirs of this repo) to link into $HOME
PACKAGES=(
    bat
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
