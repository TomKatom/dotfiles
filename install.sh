#!/usr/bin/env bash
# Link dotfiles into $HOME and enable session services.
# Idempotent: re-run after every pull or after adding a package/service.
set -euo pipefail
cd "$(dirname "$(realpath "$0")")"

# Stow packages (top-level dirs of this repo) to link into $HOME
PACKAGES=(
    fuzzel
    hypr
    mako
    systemd
    waybar
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

mkdir -p ~/Pictures/Screenshots

systemctl --user daemon-reload
systemctl --user enable "${SERVICES[@]}"

echo "Done. Log out and back in (or reboot) to start the session target."
