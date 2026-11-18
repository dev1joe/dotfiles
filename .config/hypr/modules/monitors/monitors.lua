-- See https://wiki.hypr.land/configuring/core/monitors/

local monitor_profile = "extend-right" -- "extend-right" | "external-only" | "home"

local monitor_profiles = {
	["extend-right"] = {
		{ output = "eDP-1", mode = "highres", position = "auto-right", scale = 1, transform = 0 },
		{ output = "HDMI-A-1", mode = "highres", position = "0x0", scale = 1 },
		-- { output = "eDP-1", disabled = true },
	},
	["external-only"] = {
		{ output = "eDP-1", disabled = true },
		{ output = "HDMI-A-1", mode = "highres", position = "0x0", scale = 1 },
	},
	["home"] = {
		-- [___ 1366x768 monitor ___]
		{ output = "eDP-1", mode = "1920x1080", position = "1600x0", scale = 1, transform = 0 },
		{ output = "HDMI-A-1", mode = "1600x900", position = "0x0", scale = 1 }, -- can also try 1440x810
	},
}

for _, m in ipairs(monitor_profiles[monitor_profile]) do
	hl.monitor(m)
end

-- hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "0x0", scale = 1 })
-- hl.monitor({ output = "eDP-1", mode = "highres", position = "auto-right", scale = 1, transform = 0 })
-- hl.monitor({ output = "eDP-1", disabled = true })
