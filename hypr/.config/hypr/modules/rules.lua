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

-- Small utility windows float, centered.
hl.window_rule({
    name = "float-utilities",
    match = { class = "^(org\\.pulseaudio\\.pavucontrol|blueman-manager|nm-connection-editor)$" },
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
