return {
	"CRAG666/code_runner.nvim",
	lazy = false,
	config = function()
		require("code_runner").setup({
			filetype = {
				java = function()
					local commands = {}
					local gradlew_path = "gradlew" -- Change this if gradlew is located elsewhere

					-- Check if gradlew exists and is executable
					if vim.fn.executable(gradlew_path) == 1 then
						table.insert(commands, "cd $dir &&")
						table.insert(commands, "./" .. gradlew_path .. " build &&")
					else
						table.insert(commands, "cd $dir &&")
					end

					-- Compile and run the Java program
					table.insert(commands, "javac $fileName &&")
					table.insert(commands, "java $fileNameWithoutExt")

					return commands
				end,
				python = function()
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
