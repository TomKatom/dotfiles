-- Keybinds. `hyprctl binds` lists what's active.
-- Flags: locked = works on the lock screen, repeating = fires while held,
--        mouse = needed for drag/resize-with-mouse dispatchers.

local mod = "SUPER"

local terminal = "kitty"
local files    = "thunar"
local launcher = "pkill -x fuzzel || fuzzel"
local powermenu = "~/.local/bin/powermenu"  -- ~/.local/bin is not on the compositor's PATH

local function key(k) return mod .. " + " .. k end

-- Apps ---------------------------------------------------------------------
hl.bind(key("Return"), hl.dsp.exec_cmd(terminal))
hl.bind(key("Space"),  hl.dsp.exec_cmd(launcher))
hl.bind(key("E"),      hl.dsp.exec_cmd(files))
hl.bind(key("V"),      hl.dsp.exec_cmd("cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"))
hl.bind(key("SHIFT + C"), hl.dsp.exec_cmd("hyprpicker -a"))  -- color picker -> clipboard

-- Screenshots: region / whole screen, opened in satty for annotate + save/copy.
local shot_out = [[--output-filename ~/Pictures/Screenshots/$(date +%Y%m%d-%H%M%S).png]]
hl.bind("Print",         hl.dsp.exec_cmd([[grim -g "$(slurp -d)" -t ppm - | satty --filename - ]] .. shot_out))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd([[grim -t ppm - | satty --filename - ]] .. shot_out))

-- Notifications (N family) ---------------------------------------------------
hl.bind(key("N"),          hl.dsp.exec_cmd("makoctl dismiss"))
hl.bind(key("SHIFT + N"),  hl.dsp.exec_cmd("makoctl dismiss --all"))
hl.bind(key("CTRL + N"),   hl.dsp.exec_cmd("makoctl restore"))
hl.bind(key("ALT + N"),    hl.dsp.exec_cmd("~/.local/bin/dnd"))  -- explicit path: the session PATH may lack ~/.local/bin

-- Session ------------------------------------------------------------------
hl.bind(key("Escape"),    hl.dsp.exec_cmd("loginctl lock-session"))  -- handled by hypridle
hl.bind(key("SHIFT + M"), hl.dsp.exec_cmd("hyprshutdown"))
hl.bind(key("X"),         hl.dsp.exec_cmd("pkill -x fuzzel || " .. powermenu))

-- Windows ------------------------------------------------------------------
hl.bind(key("Q"), hl.dsp.window.close())
hl.bind(key("F"), hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(key("M"), hl.dsp.window.fullscreen({ mode = "maximized",  action = "toggle" }))
hl.bind(key("T"), hl.dsp.window.float({ action = "toggle" }))

-- Focus / move / resize, vim-style
local dirs = { h = "left", j = "down", k = "up", l = "right" }
local step = 40
local resize = { h = { -step, 0 }, j = { 0, step }, k = { 0, -step }, l = { step, 0 } }

for k, dir in pairs(dirs) do
    hl.bind(key(k),               hl.dsp.focus({ direction = dir }))
    hl.bind(key("SHIFT + " .. k), hl.dsp.window.move({ direction = dir }))
    hl.bind(key("CTRL + " .. k),
        hl.dsp.window.resize({ x = resize[k][1], y = resize[k][2], relative = true }),
        { repeating = true })
end

-- Mouse: SUPER + left-drag moves, SUPER + right-drag resizes
hl.bind(key("mouse:272"), hl.dsp.window.drag(),   { mouse = true })
hl.bind(key("mouse:273"), hl.dsp.window.resize(), { mouse = true })

-- Workspaces ---------------------------------------------------------------
for i = 1, 10 do
    local k = tostring(i % 10)  -- 10 lives on the 0 key
    hl.bind(key(k),               hl.dsp.focus({ workspace = i }))
    hl.bind(key("SHIFT + " .. k), hl.dsp.window.move({ workspace = i }))
end

-- Scratchpad
hl.bind(key("S"),         hl.dsp.workspace.toggle_special("scratch"))
hl.bind(key("SHIFT + S"), hl.dsp.window.move({ workspace = "special:scratch" }))

-- Media keys (work while locked) -------------------------------------------
local vol = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ "
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(vol .. "5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(vol .. "5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),   { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
