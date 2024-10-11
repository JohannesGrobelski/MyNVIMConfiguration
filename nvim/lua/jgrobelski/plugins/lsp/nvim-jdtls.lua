return {
	"mfussenegger/nvim-jdtls",
	dependencies = {
		"mfussenegger/nvim-dap",
	},
	config = function(_)
		local jdtls = require("jdtls")

		-- Configure jdtls
		local config = {
			cmd = { "/home/johannes/.local/share/nvim/mason/packages/jdtls/bin/jdtls" },
			root_dir = vim.fs.dirname(vim.fs.find({ ".git", "mvnw", "gradlew" }, { upward = true })[1]),
			init_options = {
				bundles = {
					vim.fn.glob(
						"/home/johannes/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-0.53.0.jar"
					),
				},
			},
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		}
		jdtls.start_or_attach(config)
	end,
}
