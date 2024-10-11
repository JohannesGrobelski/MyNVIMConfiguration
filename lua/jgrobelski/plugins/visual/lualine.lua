return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-lua/lsp-status.nvim",
	},
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count
		local lsp_status = require("lsp-status")

		-- Function to get LSP clients that are ready
		local function get_ready_lsp_clients()
			local ready_clients = {}
			local clients = vim.lsp.get_clients({ bufnr = 0 })

			for _, client in ipairs(clients) do
				-- Check if client capabilities indicate it's ready
				if client.server_capabilities.textDocumentSync ~= 0 then
					table.insert(ready_clients, client.name)
				end
			end

			return ready_clients
		end

		-- Function to hide filename in Neo-tree
		local function filename_in_neo_tree()
			if vim.fn.expand("%:p"):find("neo-tree") then
				return "" -- Return an empty string when in Neo-tree
			end
			return vim.fn.expand("%:t") -- Otherwise, return the filename
		end

		-- Function to hide filetype in Neo-tree
		local function filetype_in_neo_tree()
			if vim.fn.expand("%:p"):find("neo-tree") then
				return "" -- Return an empty string when in Neo-tree
			end
			return vim.bo.filetype -- Otherwise, return the filetype
		end

		lsp_status.register_progress()

		-- configure lualine with modified theme
		require("lualine").setup({
			options = {
				theme = "dracula",
			},
			sections = {
				lualine_x = {
					{
						function()
							local ready_clients = get_ready_lsp_clients()

							if #ready_clients == 0 then
								return "" -- Return empty string if no clients are ready
							end

							return table.concat(ready_clients, ", ")
						end,
						icon = "", -- Icon can be changed as per preference
						color = { fg = "#FFFFFF", gui = "bold" }, -- Set color for the text
					},
					filename_in_neo_tree(), -- Use the custom function for the filename
				},
				lualine_y = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ filetype_in_neo_tree() }, -- Use the custom function for the filetype
				},
			},
		})
	end,
}
