-- Window rules. Evaluated top to bottom; order matters.
-- Find a window's class with `hyprctl clients`.

-- Ignore apps asking to maximize themselves (stock-config default).
hl.window_rule({
    name = "suppress-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Don't let the screen idle/lock while something is fullscreen (video, games).
hl.window_rule({
    name = "idle-inhibit-fullscreen",
    match = { class = ".*" },
    idle_inhibit = "fullscreen",
})

-- Small utility windows and portal file choosers float, centered.
hl.window_rule({
    name = "float-utilities",
    match = { class = "^(org\\.pulseaudio\\.pavucontrol|blueman-manager|nm-connection-editor|xdg-desktop-portal-gtk)$" },
    float = true,
    size = "900 600",
    center = true,
})

-- Screenshot annotator.
hl.window_rule({
    name = "float-satty",
    match = { class = "^(com\\.gabm\\.satty)$" },
    float = true,
})

hl.window_rule({
    name = "float-bitwarden",
    match = { class = "^(Bitwarden)$" },
    float = true,
    center = true,
})

hl.window_rule({
    name = "float-thunar-progress",
    match = { class = "^(thunar)$", title = "^(File Operation Progress)$" },
    float = true,
})

hl.window_rule({
    name = "pip-firefox",
    match = { title = "^(Picture-in-Picture)$" },
    float = true,
    pin = true,
    keep_aspect_ratio = true,
})
