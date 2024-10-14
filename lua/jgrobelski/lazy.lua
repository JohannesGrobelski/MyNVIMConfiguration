-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

--setup all plugins defined in plugin dir and subdirs
require("lazy").setup({
	{ import = "jgrobelski.plugins" },
	{ import = "jgrobelski.plugins.visual" },
	{ import = "jgrobelski.plugins.navigation" },
	{ import = "jgrobelski.plugins.motions" },
	{ import = "jgrobelski.plugins.dap" },
	{ import = "jgrobelski.plugins.linting&formatters" },
	{ import = "jgrobelski.plugins.git" },
	{ import = "jgrobelski.plugins.lsp" },
}, {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})
