return {
	"CRAG666/code_runner.nvim",
	lazy = false,
	config = function()
		require("code_runner").setup({
			filetype = {
				java = {
					"cd $dir &&",
					"javac $fileName &&",
					"java $fileNameWithoutExt",
				},
				python = function() -- enter venv if possible and the exec file
					local venv_path = vim.fn.getcwd() .. "/venv" -- Adjust if your venv is named differently
					local command = "python3 -u"

					-- Check if the venv directory exists
					if vim.fn.isdirectory(venv_path) == 1 then
						command = string.format("source %s/bin/activate && %s", venv_path, command)
					end

					return command
				end,
				typescript = "deno run",
				rust = {
					"cd $dir &&",
					"rustc $fileName &&",
					"$dir/$fileNameWithoutExt",
				},
			},
		})
	end,
}
