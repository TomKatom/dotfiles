-- Monitors.
-- An explicit rule beats the catch-all for that output.
-- "preferred" picks 60 Hz on HDMI-A-4, so its 100 Hz mode is pinned.
hl.monitor({ output = "HDMI-A-4", mode = "1920x1080@100", position = "0x0", scale = 1 })

-- Catch-all: any other output, preferred mode, auto position, auto scale.
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })
