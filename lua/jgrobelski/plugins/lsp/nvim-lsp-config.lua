-- NOTE: Lsp, Linters, Formatters are installed in mason.lua
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"alefpereira/pyenv-pyright", --
		{ "antosha417/nvim-lsp-file-operations", config = true },
		-- dditional lua configuration, makes nvim stuff amazing!
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		local server_to_filetype_map = {
			bashls = { "sh" },
			--pyright = { "python" },
			-- jdtls = { "java" },
			lemminx = { "xml" },
			lua_ls = { "lua" },
			ts_ls = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
			cssls = { "css", "scss", "less" },
			docker_compose_language_service = { "yaml", "yaml.docker-compose" },
			groovyls = { "groovy" },
		}

		for lsp, filetypes in pairs(server_to_filetype_map) do
			lspconfig[lsp].setup({
				filetypes = filetypes,
				capabilities = capabilities,
			})
		end

		-- setup xml lsp
		lspconfig.lemminx.setup({
			settings = {
				xml = {
					schema = {
						["http://schemas.android.com/apk/res/android"] = {
							type = "object",
							properties = {
								-- Add property definitions here as needed
							},
						},
					},
					validate = true,
				},
			},
		})

		-- Set the Python host program to the currently active pyenv virtual environment
		local handle = io.popen("pyenv which python")
		local python_path = handle:read("*a")
		handle:close()
		vim.g.python3_host_prog = python_path:gsub("%s+", "") -- Remove any trailing whitespace

		-- LSP Configuration for Python
		require("lspconfig").pyright.setup({
			filetypes = { "python" },
			capabilities = capabilities,
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "basic", -- or "strict" if you prefer
						useLibraryCodeForTypes = true,
					},
				},
			},
		})

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		vim.cmd([[
  autocmd FileType dap-repl setlocal syntax=java
]])
	end,
}
