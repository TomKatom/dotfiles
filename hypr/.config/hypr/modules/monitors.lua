-- Monitors.
-- Catch-all: any output, preferred mode, auto position, auto scale.
-- Once you know your output name (`hyprctl monitors`), pin it explicitly, e.g.
--   hl.monitor({ output = "DP-1", mode = "2560x1440@144", position = "0x0", scale = 1 })
-- An explicit rule beats the catch-all for that output.

hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })
