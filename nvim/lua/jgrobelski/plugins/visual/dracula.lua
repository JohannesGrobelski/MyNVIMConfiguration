return {
	"Mofiqul/dracula.nvim",
	priority = 1000, -- load plugin before any other
	lazy = false,
	config = function()
		vim.cmd("colorscheme dracula") -- set dracula as neovim themek
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end,
}
