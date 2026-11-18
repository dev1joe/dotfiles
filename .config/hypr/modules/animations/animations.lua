-- https://wiki.hypr.land/configuring/core/animations/

local animation_profile = "optimized" -- "optimized" | "default" | "new"

-- curves:     { name, x0, y0, x1, y1 }
-- animations: { leaf, speed, bezier, style? }
local animation_profiles = {
	["optimized"] = {
		curves = {
			-- Using simplified, faster curves
			{ "md3_decel", 0.05, 0.7, 0.1, 1 },
			{ "md3_accel", 0.3, 0, 0.8, 0.15 },
		},
		anims = {
			-- Reduced durations (from 3 down to 2 or 1.5)
			{ "windows", 2, "md3_decel", "popin 80%" },
			{ "windowsIn", 2, "md3_decel", "popin 80%" },
			{ "windowsOut", 2, "md3_accel", "popin 80%" },

			-- Static elements don't need high-duration animations
			{ "border", 5, "default" },
			{ "fade", 2, "md3_decel" },

			-- Faster layer and workspace switching
			{ "layersIn", 2, "md3_decel", "slide" },
			{ "layersOut", 1.5, "md3_accel" },
			{ "fadeLayersIn", 1.5, "md3_decel" },
			{ "fadeLayersOut", 2, "md3_accel" },

			-- Dramatically faster workspace switching (7 -> 3)
			{ "workspaces", 3, "md3_decel", "slide" },
			{ "specialWorkspace", 2, "md3_decel", "slidevert" },
		},
	},

	["default"] = {
		curves = {
			{ "easeOutQuint", 0.23, 1, 0.32, 1 },
			{ "easeInOutCubic", 0.65, 0.05, 0.36, 1 },
			{ "linear", 0, 0, 1, 1 },
			{ "almostLinear", 0.5, 0.5, 0.75, 1 },
			{ "quick", 0.15, 0, 0.1, 1 },
		},
		anims = {
			{ "global", 10, "default" },
			{ "border", 5.39, "easeOutQuint" },
			{ "windows", 4.79, "easeOutQuint" },
			{ "windowsIn", 4.1, "easeOutQuint", "popin 87%" },
			{ "windowsOut", 1.49, "linear", "popin 87%" },
			{ "fadeIn", 1.73, "almostLinear" },
			{ "fadeOut", 1.46, "almostLinear" },
			{ "fade", 3.03, "quick" },
			{ "layers", 3.81, "easeOutQuint" },
			{ "layersIn", 4, "easeOutQuint", "fade" },
			{ "layersOut", 1.5, "linear", "fade" },
			{ "fadeLayersIn", 1.79, "almostLinear" },
			{ "fadeLayersOut", 1.39, "almostLinear" },
			{ "workspaces", 1.94, "almostLinear", "fade" },
			{ "workspacesIn", 1.21, "almostLinear", "fade" },
			{ "workspacesOut", 1.94, "almostLinear", "fade" },
			{ "zoomFactor", 7, "quick" },
		},
	},

	-- name "End-4", credit https://github.com/end-4/dots-hyprland
	["new"] = {
		curves = {
			{ "linear", 0, 0, 1, 1 },
			{ "md3_standard", 0.2, 0, 0, 1 },
			{ "md3_decel", 0.05, 0.7, 0.1, 1 },
			{ "md3_accel", 0.3, 0, 0.8, 0.15 },
			{ "overshot", 0.05, 0.9, 0.1, 1.1 },
			{ "crazyshot", 0.1, 1.5, 0.76, 0.92 },
			{ "hyprnostretch", 0.05, 0.9, 0.1, 1.0 },
			{ "menu_decel", 0.1, 1, 0, 1 },
			{ "menu_accel", 0.38, 0.04, 1, 0.07 },
			{ "easeInOutCirc", 0.85, 0, 0.15, 1 },
			{ "easeOutCirc", 0, 0.55, 0.45, 1 },
			{ "easeOutExpo", 0.16, 1, 0.3, 1 },
			{ "softAcDecel", 0.26, 0.26, 0.15, 1 },
			{ "md2", 0.4, 0, 0.2, 1 }, -- use with .2s duration
		},
		anims = {
			{ "windows", 3, "md3_decel", "popin 60%" },
			{ "windowsIn", 3, "md3_decel", "popin 60%" },
			{ "windowsOut", 3, "md3_accel", "popin 60%" },
			{ "border", 10, "default" },
			{ "fade", 3, "md3_decel" },
			-- { "layers",        2,   "md3_decel", "slide" },
			{ "layersIn", 3, "menu_decel", "slide" },
			{ "layersOut", 1.6, "menu_accel" },
			{ "fadeLayersIn", 2, "menu_decel" },
			{ "fadeLayersOut", 4.5, "menu_accel" },
			{ "workspaces", 7, "menu_decel", "slide" },
			-- { "workspaces",    2.5, "softAcDecel", "slide" },
			-- { "workspaces",    7,   "menu_decel", "slidefade 15%" },
			-- { "specialWorkspace", 3, "md3_decel", "slidefadevert 15%" },
			{ "specialWorkspace", 3, "md3_decel", "slidevert" },
		},
	},
}

hl.config({ animations = { enabled = true } })

do
	local profile = animation_profiles[animation_profile]
	for _, c in ipairs(profile.curves) do
		hl.curve(c[1], { type = "bezier", points = { { c[2], c[3] }, { c[4], c[5] } } })
	end
	for _, a in ipairs(profile.anims) do
		hl.animation({ leaf = a[1], enabled = true, speed = a[2], bezier = a[3], style = a[4] })
	end
end
