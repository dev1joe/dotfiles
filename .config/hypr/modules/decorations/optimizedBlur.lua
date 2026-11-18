hl.config({
	decoration = {
		shadow = {
			enabled = true,
			range = 8,
			render_power = 2, -- lower = cheaper falloff
			color = "rgba(1a1a1a99)",
		},

		blur = {
			enabled = true,
			size = 5,
			passes = 1, -- biggest saver; 2 passes roughly doubles the cost
			new_optimizations = true,
			ignore_opacity = true,
			xray = true, -- blur only samples the wallpaper, much cheaper
			popups = false,
			special = false,

			vibrancy = 0, -- extra shader work, subtle benefit
			noise = 0.015, -- hides banding at 1 pass
			contrast = 1.0,
			brightness = 0.8,
		},
	},
})
