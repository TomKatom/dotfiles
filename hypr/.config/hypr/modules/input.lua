-- Keyboard and pointer.

hl.config({
    input = {
        kb_layout  = "us,il",
	kb_variant = "colemak,",
        kb_options = "grp:alt_shift_toggle",

        repeat_rate  = 40,   -- keys/sec while held
        repeat_delay = 250,  -- ms before repeat kicks in
        numlock_by_default = true,

        follow_mouse = 1,    -- focus follows the cursor
        sensitivity  = 0,    -- -1.0 .. 1.0
    },
})
