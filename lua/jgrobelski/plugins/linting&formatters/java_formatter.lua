return {
	{
		"mhartington/formatter.nvim",
		event = { "BufReadPre", "BufNewFile" },
		enabled = false,
		config = function()
			require("formatter").setup({
				logging = false,
				log_level = vim.log.levels.WARN,
				filetype = {
					java = {
						function()
							return {
								-- Use Google Java Format for formatting
								exe = "google-java-format",
								args = { "--replace", vim.api.nvim_buf_get_name(0) }, -- Replace in the current buffer
								stdin = false,
							}
						end,
						function()
							return {
								-- Run Checkstyle to validate (not format)
								exe = "checkstyle",
								args = {
									"-c",
									"/home/johannes/ArbeitsProjekte/BIRD-Liferay/checkstyle.xml", -- Specify your checkstyle.xml path
									vim.api.nvim_buf_get_name(0), -- Current buffer
								},
								stdin = false,
								stream = "stdout", -- Capture errors from Checkstyle
							}
						end,
					},
				},
			})

			-- Set up formatting on save
			vim.cmd([[
                augroup FormatAutogroup
                    autocmd!
                    autocmd BufWritePost *.java FormatWrite
                augroup END
            ]])
		end,
	},
}
