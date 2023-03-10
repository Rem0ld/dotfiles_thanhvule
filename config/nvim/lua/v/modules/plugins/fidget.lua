return {
	"j-hui/fidget.nvim",
	event = "VeryLazy",
	config = function()
		require("fidget").setup({
			text = {
				spinner = "dots_pulse",
				done = "",
				commenced = "Started",
				completed = "Completed",
			},
			window = {
				relative = "win",
				blend = 0,
				zindex = nil,
				border = "none",
			},
		})
	end,
}
