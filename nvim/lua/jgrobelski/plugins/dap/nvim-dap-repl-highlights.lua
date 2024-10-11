return {
	"LiadOz/nvim-dap-repl-highlights",
	event = "VeryLazy",
	config = function()
		require("nvim-dap-repl-highlights").setup()
	end,
}
