local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

local home = os.getenv("HOME")
local cache = home .. "/.cache/nvim"
vim.opt.runtimepath:prepend(cache)

require("lazy").setup(require("v.modules.plugins"), {
	defaults = { lazy = true },
	install = {
		missing = true,
		colorscheme = { "catppuccin-mocha" },
	},
	checker = { enabled = false, notify = false },
	change_detection = {
		enabled = false,
		notify = false,
	},
	performance = {
		cache = {
			enabled = true,
			path = cache .. "/lazy/cache",
			disable_events = { "VimEnter", "BufReadPre" },
		},
	},
})
