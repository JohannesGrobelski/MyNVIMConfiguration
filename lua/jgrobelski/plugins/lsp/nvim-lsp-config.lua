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
			filetypes = { "xml" },
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				-- Add additional LSP functionalities (e.g. autocompletion, hover, etc.)
				local opts = { noremap = true, silent = true }
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
			end,
			settings = {
				xml = {
					server = {
						validation = {
							enabled = true, -- Ensures LemMinX performs validation
						},
					},
				},
			},
		})
		-- Set the Python host program to the currently active pyenv virtual environment
		local handle = io.popen("pyenv which python")
		local python_path = handle:read("*a")
		handle:close()
		vim.g.python3_host_prog = python_path:gsub("%s+", "") -- Remove any trailing whitespace



        -- Print startup message
        print("Setting up Pyright with Python path: /home/johannes/.pyenv/versions/.venv/bin/python")

        -- Configure Pyright
        lspconfig.pyright.setup({
            capabilities = capabilities,
            before_init = function(_, config)
                config.settings.python.pythonPath = "/home/johannes/.pyenv/versions/.venv/bin/python"
            end,
            settings = {
                python = {
                    pyright = {
                        autoImportCompletion = true
                    },
                    python = {

                    },
                    pythonPath = "/home/johannes/.pyenv/versions/.venv/bin/python",
                    venvPath = "/home/johannes/.pyenv/versions",
                    venv = ".venv",
                    analysis = {
                        extraPaths = {
                            "/home/johannes/.pyenv/versions/.venv/lib/python3.12/site-packages",
                            "/home/johannes/.pyenv/versions/3.12.3/lib/python3.12",
                            "/home/johannes/.pyenv/versions/3.12.3/lib/python3.12/lib-dynload",
                        },
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                        diagnosticMode = "openFileOnly",
                        typeCheckingMode = "off"
                    }
                }
            }
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
