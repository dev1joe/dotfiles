-- See https://wiki.hypr.land/configuring/core/rules/

hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

-- Pavucontrol floating
hl.window_rule({
	name = "floating-pulseaudio-app",
	match = { class = ".*org.pulseaudio.pavucontrol.*" },

	float = true,
})

hl.window_rule({
	name = "floating-emoji-picker",
	match = { class = ".*org.gnome.Characters.*" },

	float = true,
	pin = true,
})

hl.window_rule({
	name = "floating-localsend",
	match = { class = "localsend" },

	float = true,
	pin = true,
})

hl.window_rule({
	name = "floating-calculator",
	match = { class = ".*org.gnome.Calculator.*" },

	float = true,
	size = "700 600",
})

--! IMPORTANT
hl.window_rule({
	name = "rider-popups-fix",
	match = {
		class = "jetbrains-rider",
		title = "^win(.*)",
		float = true,
	},

	no_focus = true,
	no_initial_focus = true,
})

hl.window_rule({
	name = "google-signin-float",
	match = {
		class = "brave-browser",
		title = ".*Sign in – Google accounts.*",
	},

	float = true,
	pin = true,
})

hl.window_rule({
	name = "thunar-progress-popup",
	match = {
		class = "thunar",
		title = "File Operation Progress",
	},

	float = true,
})

hl.window_rule({
	name = "floating-blueman-manager",
	match = { class = "blueman-manager" },

	float = true,
})

hl.layer_rule({
	name = "noctalia",
	match = { namespace = "noctalia-background-.*$" },

	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})
