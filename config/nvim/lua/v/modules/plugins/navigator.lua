return {
	"numToStr/Navigator.nvim",
	cmd = { "NavigatorUp", "NavigatorDown", "NavigatorLeft", "NavigatorRight" },
	init = function()
		vim.keymap.set({ "n", "t" }, "<A-h>", "<CMD>NavigatorLeft<CR>")
		vim.keymap.set({ "n", "t" }, "<A-l>", "<CMD>NavigatorRight<CR>")
		vim.keymap.set({ "n", "t" }, "<A-k>", "<CMD>NavigatorUp<CR>")
		vim.keymap.set({ "n", "t" }, "<A-j>", "<CMD>NavigatorDown<CR>")
	end,
	config = function()
		require("Navigator").setup()
	end,
}
