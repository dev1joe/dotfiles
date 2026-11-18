-- https://wiki.hypr.land/configuring/core/config-options/ (input)

local input_profile = "halmak" -- "halmak" | "us"

local input_profiles = {
	["halmak"] = {
		kb_layout = "halmak_no_qwerty, us, ara",
		kb_variant = "",
		kb_model = "",
		kb_options = "grp:shifts_toggle",
		numlock_by_default = true,
		mouse_refocus = false,

		follow_mouse = 1,
		touchpad = {
			-- for desktop
			-- natural_scroll = false,

			-- for laptop
			natural_scroll = true,
			middle_button_emulation = true,
			clickfinger_behavior = false,
			scroll_factor = 1.5, -- Touchpad scroll factor
			disable_while_typing = true,
		},
		sensitivity = 0, -- Pointer speed: -1.0 - 1.0, 0 means no modification.
	},
	["us"] = {
		-- For United States
		kb_layout = "us",
		kb_variant = "intl",
		kb_model = "pc105",
		kb_options = "",

		follow_mouse = 1,
		touchpad = {
			-- for desktop
			-- natural_scroll = false,

			-- for laptop
			natural_scroll = true,
			middle_button_emulation = true,
			clickfinger_behavior = false,
			scroll_factor = 1.5, -- Touchpad scroll factor
		},
		sensitivity = 0, -- Pointer speed: -1.0 - 1.0, 0 means no modification.
	},
}

hl.config({
	input = input_profiles[input_profile],
})

-- Gestures: https://wiki.hypr.land/configuring/core/binds/gestures/
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "vertical", action = "special", workspace_name = "magic" })
