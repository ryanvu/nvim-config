return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- Required for LSP completion
		{ "antosha417/nvim-lsp-file-operations", config = true }, -- Good for LSP-driven file renames
		{ "folke/neodev.nvim", opts = {} }, -- Helps with Neovim LSP setup for Lua
    -- You can add navbuddy later if you still want it, but let's keep it minimal for now.
    {
      "SmiteshP/nvim-navbuddy",
      dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim"
      },
      opts = { lsp = { auto_attach = true } }
    }
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap

		-- General capabilities for all LSP servers
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Recommended: Set up global autocommands for LSP features
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				-- Basic LSP keymaps (adjust as you prefer)
				keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				keymap.set("n", "K", vim.lsp.buf.hover, opts)
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- Requires Telescope
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- Requires Telescope
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			end,
		})

		-- Use mason-lspconfig to set up all installed LSP servers with default configurations
		-- This replaces the problematic `setup_handlers` call
		mason_lspconfig.setup({
			-- A 'handler' is a function that gets called for each LSP server Mason installs.
			-- We define custom handlers for specific servers if they need special settings.
			handlers = {
				-- Default handler: For any server not specifically listed below,
				-- just set it up with default capabilities.
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
						-- Additional default options can go here, e.g., on_attach for general setup
					})
				end,

				-- Custom handler for `typescriptls` (for React/Node.js)
				-- You might want specific settings for JSX, TSX, etc. here.
				["typescriptls"] = function()
					lspconfig.typescriptls.setup({
						capabilities = capabilities,
						-- Example settings for JS/TS projects. Adjust as needed.
						settings = {
							javascript = {
								preferences = {
									importModuleSpecifierEnding = "js",
									quoteStyle = "double",
								},
							},
							typescript = {
								preferences = {
									importModuleSpecifierEnding = "js",
									quoteStyle = "double",
								},
							},
						},
						init_options = {
							hostInfo = "neovim",
						},
					})
				end,

				-- Custom handler for `eslint` (if you use it for linting)
				["eslint"] = function()
					lspconfig.eslint.setup({
						capabilities = capabilities,
						-- Ensure ESLint lints on save, etc.
						on_attach = function(client, bufnr)
							vim.api.nvim_create_autocmd("BufWritePre", {
								buffer = bufnr,
								command = "EslintFixAll", -- Or vim.lsp.buf.format({async = true}) if you use format on save
							})
						end,
					})
				end,

				-- Custom handler for `lua_ls` (for Neovim config)
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									library = {
										vim.fn.stdpath("nvim") .. "/lua",
										vim.fn.stdpath("nvim") .. "/lua/ryan", -- Adjust if your config structure is different
									},
								},
								telemetry = { enable = false },
							},
						},
					})
				end,

				-- Placeholder for Ruby:
				-- When you start working with Ruby, you'll likely want 'solargraph'.
				-- You'd add 'solargraph' to mason.lua's ensure_installed.
				-- Then uncomment and configure this handler:
				-- ["solargraph"] = function()
				--   lspconfig.solargraph.setup({
				--     capabilities = capabilities,
				--     -- cmd = { "bundle", "exec", "solargraph", "stdio" }, -- Example if using bundler
				--     -- filetypes = { "ruby", "rb", "gemspec", "rakefile" },
				--   })
				-- end,
			},
		})
	end,
}
