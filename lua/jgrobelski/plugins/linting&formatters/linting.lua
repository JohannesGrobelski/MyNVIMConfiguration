return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"rshkarin/mason-nvim-lint",
	},
	config = function()
		require("mason-nvim-lint").setup({
			ensure_installed = {
				"eslint_d",
				"checkstyle", --java linter
			},
		})

		local lint = require("lint")
		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			python = { "pylint" },
			java = { "checkstyle" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				-- Dynamically pass checkstyle.xml as argument
				if vim.bo.filetype == "java" then
					lint.linters.checkstyle.args =
						{ "-c", "/home/johannes/ArbeitsProjekte/BIRD-Liferay/checkstyle.xml", vim.fn.expand("%:p") }
				end
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })

		lint.linters.checkstyle.args = { "-c", "/absolute/path/to/your/checkstyle.xml", vim.fn.expand("%:p") }
	end,
}
