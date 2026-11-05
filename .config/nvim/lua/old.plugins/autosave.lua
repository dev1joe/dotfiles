return {
	"okuuva/auto-save.nvim",
	event = { "InsertLeave", "TextChanged" },
	opts = {
		-- Optional: Configure debounce, conditions, or trigger events
		debounce_delay = 1000,
	},
}
