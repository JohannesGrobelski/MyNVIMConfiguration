-- setup vim configurations, lazy and plugins and keymaps
require("jgrobelski.core.options")
require("jgrobelski.lazy") -- has to be done after options (because mapleader must be set before lazy setup)
require("jgrobelski.core.keymaps") -- has to be done after lazy (because plugins are referenced in keymaps)

-- Function to check for and activate a virtual environment
local function activate_if_present_venv()
	-- Get the current working directory
	local cwd = vim.fn.getcwd()

	-- Define the path for the virtual environment (customize if needed)
	local venv_path = cwd .. "/venv" -- or whatever your venv folder is named

	-- Check if the virtual environment directory exists
	if vim.fn.isdirectory(venv_path) == 1 then
		-- Activate the virtual environment
		local activate_cmd = "source " .. venv_path .. "/bin/activate"
		vim.cmd("silent !(" .. activate_cmd .. ")")

		-- Display a message with the activated venv
		vim.notify("Activated virtual environment: " .. venv_path)
	end
end

-- Autocommand to activate the virtual environment when entering a Python directory
activate_if_present_venv()

-- set neotree backgrounds to transparent
vim.cmd([[
  hi NeoTreeNormal guibg=NONE ctermbg=NONE
  hi NeoTreeNormalNC guibg=NONE ctermbg=NONE
  hi NeoTreeEndOfBuffer guibg=NONE ctermbg=NONE
  hi NeoTreeWinSeparator guibg=NONE ctermbg=NONE
]])

-- Set transparent background for Telescope
vim.cmd([[
  hi TelescopeNormal guibg=NONE ctermbg=NONE
  hi TelescopeBorder guibg=NONE ctermbg=NONE
  hi TelescopePromptNormal guibg=NONE ctermbg=NONE
  hi TelescopeResultsNormal guibg=NONE ctermbg=NONE
  hi TelescopePreviewNormal guibg=NONE ctermbg=NONE
  hi TelescopeSelection guibg=NONE ctermbg=NONE
]])
