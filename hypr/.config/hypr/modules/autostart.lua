-- Session startup.
-- Hyprland launches nothing itself except the systemd session target.
-- Everything long-running (bar, polkit agent, clipboard watcher, idle daemon,
-- wallpaper, ...) is a systemd user service bound to graphical-session.target:
--   * restarts on crash, logs in `journalctl --user -u <name>`
--   * stops cleanly when the session ends
--   * the enabled set is listed in ~/dotfiles/install.sh
--
-- Order matters: export the Wayland env to systemd/D-Bus first, then start
-- the target, so services don't come up without WAYLAND_DISPLAY.

hl.on("hyprland.start", function()
    hl.exec_cmd(
        "dbus-update-activation-environment --systemd "
        .. "WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE HYPRLAND_INSTANCE_SIGNATURE "
        .. "&& systemctl --user start hyprland-session.target"
    )
end)

hl.on("hyprland.shutdown", function()
    hl.exec_cmd("systemctl --user stop hyprland-session.target")
end)
