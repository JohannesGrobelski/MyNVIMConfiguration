return {
	"mfussenegger/nvim-jdtls",
	dependencies = {
		"mfussenegger/nvim-dap",
	},
	config = function(_)
		local jdtls = require("jdtls")

		-- Find the root directory
		local root_markers = { ".git", "mvnw", "gradlew" }
		local root_dir = vim.fs.dirname(vim.fs.find(root_markers, { upward = true })[1])

		-- Only start jdtls if a root directory is found
		if not root_dir then
			return -- Exit if no root directory is found
		end

		-- Configure jdtls
		local config = {
			cmd = { "/home/johannes/.local/share/nvim/mason/packages/jdtls/bin/jdtls" },
			root_dir = root_dir,
			init_options = {
				bundles = {
					vim.fn.glob(
						"/home/johannes/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-0.53.0.jar"
					),
				},
			},
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		}

		-- Start or attach the language server
		jdtls.start_or_attach(config)
	end,
}
