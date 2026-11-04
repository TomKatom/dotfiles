-- Environment variables.
-- Third argument `true` also pushes the variable into the systemd/D-Bus
-- activation environment, so services started by the session target
-- (waybar, polkit agent, portals, ...) see it too. Use it for anything
-- that affects how apps render; skip it for compositor-only vars.

-- Cursor
local cursor_theme = "catppuccin-macchiato-mauve-cursors"
local cursor_size = "24"
hl.env("XCURSOR_THEME", cursor_theme, true)
hl.env("XCURSOR_SIZE", cursor_size, true)
hl.env("HYPRCURSOR_THEME", cursor_theme, true)
hl.env("HYPRCURSOR_SIZE", cursor_size, true)

-- Toolkits: prefer native Wayland, fall back to X11
hl.env("QT_QPA_PLATFORM", "wayland;xcb", true)
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1", true)
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct", true)
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto", true)
