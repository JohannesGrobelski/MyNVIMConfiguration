-- Debugging Support
return {
	-- https://github.com/rcarriga/nvim-dap-ui
	"rcarriga/nvim-dap-ui",
	event = "VeryLazy",
	dependencies = {
		-- https://github.com/mfussenegger/nvim-dap
		"mfussenegger/nvim-dap",
		-- https://github.com/nvim-neotest/nvim-nio
		"nvim-neotest/nvim-nio",
		-- https://github.com/theHamsta/nvim-dap-virtual-text
		"theHamsta/nvim-dap-virtual-text", -- inline variable text while debugging
		-- https://github.com/nvim-telescope/telescope-dap.nvim
		"nvim-telescope/telescope-dap.nvim", -- telescope integration with dap
		-- language specific plugins
		"mfussenegger/nvim-dap-python", --
	},
	opts = {
		controls = {
			element = "repl",
			enabled = false,
			icons = {
				disconnect = "",
				pause = "",
				play = "",
				run_last = "",
				step_back = "",
				step_into = "",
				step_out = "",
				step_over = "",
				terminate = "",
			},
		},
		element_mappings = {},
		expand_lines = true,
		floating = {
			border = "single",
			mappings = {
				close = { "q", "<Esc>" },
			},
		},
		force_buffers = true,
		icons = {
			collapsed = "",
			current_frame = "",
			expanded = "",
		},
		layouts = {
			{
				elements = {
					{
						id = "scopes",
						size = 0.50,
					},
					{
						id = "stacks",
						size = 0.30,
					},
					{
						id = "watches",
						size = 0.10,
					},
					{
						id = "breakpoints",
						size = 0.10,
					},
				},
				size = 40,
				position = "left", -- Can be "left" or "right"
			},
			{
				elements = {
					"repl",
					"console",
				},
				size = 10,
				position = "bottom", -- Can be "bottom" or "top"
			},
		},
		mappings = {
			edit = "e",
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			repl = "r",
			toggle = "t",
		},
		render = {
			indent = 1,
			max_value_lines = 100,
		},
	},
	config = function(_, opts)
		local dap = require("dap")
		require("dapui").setup(opts)

		dap.listeners.after.event_initialized["dapui_config"] = function()
			require("dapui").open()
		end

		dap.listeners.before.event_terminated["dapui_config"] = function()
			-- Commented to prevent DAP UI from closing when unit tests finish
			-- require('dapui').close()
		end

		dap.listeners.before.event_exited["dapui_config"] = function()
			-- Commented to prevent DAP UI from closing when unit tests finish
			-- require('dapui').close()
		end

		-- Add dap configurations based on your language/adapter settings
		-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
		dap.configurations.java = {
			{
				name = "Debug Launch (2GB)",
				type = "java",
				request = "launch",
				vmArgs = "" .. "-Xmx2g ",
			},
			{
				name = "Debug Attach BIRD (5005)",
				type = "java",
				request = "attach",
				hostName = "127.0.0.1",
				port = 5005,
				projectName = "BIRD-Liferay",
				cwd = "${workspaceFolder}",
			},
			{
				name = "My Custom Java Run Configuration",
				type = "java",
				request = "launch",
				-- You need to extend the classPath to list your dependencies.
				-- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
				-- classPaths = {},

				-- If using multi-module projects, remove otherwise.
				-- projectName = "yourProjectName",

				-- javaExec = "java",
				mainClass = "replace.with.your.fully.qualified.MainClass",

				-- If using the JDK9+ module system, this needs to be extended
				-- `nvim-jdtls` would automatically populate this property
				-- modulePaths = {},
				vmArgs = "" .. "-Xmx2g ",
			},
		}

		local dap_python = require("dap-python")
		dap_python.setup("~/.pyenv/versions/myenv/bin/python") -- Adjust this path to match your Python interpreter

		dap.configurations.python = {
			{
				-- Launch configuration for Python script
				type = "python", -- Debug adapter type
				request = "launch", -- Request type: launch a new instance
				name = "Launch file", -- Name of the configuration
				program = "${file}", -- This will run the current file in the buffer
				pythonPath = function()
					-- Use the Python from the active virtual environment
					local venv_path = os.getenv("VIRTUAL_ENV")
					if venv_path then
						return venv_path .. "/bin/python"
					else
						return "/usr/bin/python3" -- Fallback if no venv is active
					end
				end,
			},
			{
				-- Attach to a running Python process
				type = "python",
				request = "attach",
				name = "Attach to process",
				connect = {
					port = 5678, -- Default port for debugpy
					host = "127.0.0.1",
				},
				processId = require("dap.utils").pick_process,
			},
			{
				-- Run tests using pytest or unittest
				type = "python",
				request = "launch",
				name = "Run pytest",
				module = "pytest",
				args = { "-v" }, -- Verbose mode
			},
		}
		-- Attempt to set up the Python adapter
		local success, _ = pcall(function()
			dap_python.setup("python") -- Use the global Python interpreter
		end)
		if not success then
			-- Notify the user if debugpy is not installed
			vim.notify(
				"Error: debugpy is not installed. Please install it like this: pip install debugpy in venv or globally.",
				vim.log.levels.ERROR
			)
		end

		-- Enable nvim-dap-repl-highlights
		--require("nvim-dap-repl-highlights").setup()
		--
		--
	end,
}
