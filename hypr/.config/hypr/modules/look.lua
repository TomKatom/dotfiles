-- Layout and appearance.
-- Performance-first baseline for the UHD 770: no blur, no shadows, short
-- animations. Colors: Catppuccin Macchiato.

local c = {
    mauve    = "rgb(c6a0f6)",
    red      = "rgb(ed8796)",
    text     = "rgb(cad3f5)",
    overlay0 = "rgb(6e738d)",
    surface0 = "rgb(363a4f)",
    crust    = "rgb(181926)",
}

hl.config({
    general = {
        layout           = "dwindle",
        gaps_in          = 4,
        gaps_out         = 8,
        border_size      = 2,
        resize_on_border = true,
        col = {
            active_border   = c.mauve,
            inactive_border = c.overlay0,
        },
    },

    group = {
        col = {
            border_active          = c.mauve,
            border_inactive        = c.overlay0,
            border_locked_active   = c.red,
            border_locked_inactive = c.overlay0,
        },
        groupbar = {
            text_color = c.text,
            col = {
                active          = c.mauve,
                inactive        = c.surface0,
                locked_active   = c.red,
                locked_inactive = c.surface0,
            },
        },
    },

    decoration = {
        rounding = 6,
        blur     = { enabled = false },
        shadow   = { enabled = false },
    },

    animations = { enabled = true },

    render = {
        direct_scanout = 2,  -- auto: only fullscreen content tagged as game/video
    },

    dwindle = {
        preserve_split = true,  -- a split keeps its direction when resized
    },

    misc = {
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        force_default_wallpaper  = 0,
        background_color         = c.crust,
    },

    debug = {
        vfr = true,
    },

    xwayland = {
        force_zero_scaling = true,  -- avoid blurry XWayland apps if scale > 1
    },

    ecosystem = {
        no_update_news  = true,
        no_donation_nag = true,
    },
})

-- One curve, short durations (speed is in tenths of a second).
hl.curve("snappy", { type = "bezier", points = { { 0.25, 1.0 }, { 0.5, 1.0 } } })
hl.animation({ leaf = "global",     enabled = true, speed = 3,   bezier = "snappy" })
hl.animation({ leaf = "windows",    enabled = true, speed = 2.5, bezier = "snappy", style = "popin 90%" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2.5, bezier = "snappy", style = "slide" })
