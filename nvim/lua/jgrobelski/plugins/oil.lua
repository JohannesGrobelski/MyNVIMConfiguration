return {
	{
		"stevearc/oil.nvim",
		-- Set to load only on the :Oil command
		cmd = "Oil",
		config = function()
			require("oil").setup({
				-- Configuration options for oil.nvim
				-- Example configuration options:
				float = {
					border = "rounded", -- Border style for floating window
				},
				-- You can add more configuration options as needed
			})
		end,
	},
}
