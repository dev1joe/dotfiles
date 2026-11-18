hl.config({
	decoration = {
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},

		blur = {
			enabled = true,
			size = 15,
			passes = 3,

			-- Performance Optimizations
			new_optimizations = true,
			ignore_opacity = true,
			xray = true, -- avoids redundant blur passes on layered windows

			-- Downsampling & Performance Limits
			popups = false,
			special = false,

			-- Aesthetics (gives a smooth frosted glass look on low passes)
			vibrancy = 0.18,
			noise = 0.02,
			contrast = 0.9,
			brightness = 0.9,
		},
	},
})
