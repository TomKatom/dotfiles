-- Environment variables.
-- Third argument `true` also pushes the variable into the systemd/D-Bus
-- activation environment, so services started by the session target
-- (waybar, polkit agent, portals, ...) see it too. Use it for anything
-- that affects how apps render; skip it for compositor-only vars.

-- Cursor
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Toolkits: prefer native Wayland, fall back to X11
hl.env("QT_QPA_PLATFORM", "wayland;xcb", true)
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1", true)
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto", true)
