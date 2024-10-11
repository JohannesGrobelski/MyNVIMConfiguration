return {
	"nvim-pack/nvim-spectre",
	lazy = false,
	config = function()
		require("spectre").setup({
			-- Configuration options
			open_cmd = "vnew", -- To use a vertical split instead, change to 'vnew'
			live_update = false, -- Auto update search results when typing
			highlight = {
				ui = "String",
				search = "DiffChange",
				replace = "DiffDelete",
			},
			mapping = {
				["toggle_line"] = {
					map = "dd",
					cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
					desc = "toggle current item",
				},
				["enter_file"] = {
					map = "<cr>",
					cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
					desc = "open current file",
				},
				-- More mappings...
			},
			find_engine = {
				rg = {
					cmd = "rg",
					options = {
						["ignore-case"] = {
							value = "--ignore-case",
							icon = "[I]",
							desc = "ignore case",
						},
						["hidden"] = {
							value = "--hidden",
							desc = "hidden file",
							icon = "[H]",
						},
						-- More options...
					},
				},
			},
			replace_engine = {
				sed = {
					cmd = "sed",
					args = nil,
				},
			},
			-- Adjust floating window settings
			default = {
				win_config = {
					border = "rounded", -- Can be 'single', 'double', 'rounded', etc.
					width = 80, -- Width of the floating window
					height = 20, -- Height of the floating window
					winblend = 10, -- Transparency effect
					zindex = 50, -- Z-index for the floating window
					anchor = "center", -- Open in the center of the window
				},
			},
		})
	end,
}
