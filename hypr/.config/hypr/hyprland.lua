-- ~/.config/hypr/hyprland.lua
-- Entry point only. Each concern lives in its own module under ./modules.
--
-- Hyprland runs every require()'d file in its own scope: a runtime error in
-- one module pops an error bar but does NOT stop the others from loading.
-- Consequence: modules don't share locals. Keep each one self-contained.
--
-- Reference for every hl.* call: /usr/share/hypr/stubs/hl.meta.lua
-- Stock example config:          /usr/share/hypr/hyprland.lua

require("modules.env")
require("modules.monitors")
require("modules.input")
require("modules.look")
require("modules.rules")
require("modules.binds")
require("modules.autostart")
