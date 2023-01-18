return {
	"m-demare/hlargs.nvim",
	event = "VeryLazy",
	config = function()
		local colors = require("catppuccin.palettes").get_palette()

		require("hlargs").setup({
			color = colors.lavender,
		})
	end,
}
