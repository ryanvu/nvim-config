return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim", -- Optional, but good for formatters/linters
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer") -- Optional

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- These are common LSP servers for Node.js, React, and general web dev.
		-- They will be automatically installed by Mason.
		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",          -- For Neovim config itself
				"ts_ls",    -- TypeScript and JavaScript support
				"html",            -- HTML language server
				"cssls",           -- CSS language server
				"jsonls",          -- JSON language server
				"emmet_ls",        -- Emmet support for HTML/CSS
				"eslint",          -- For ESLint integration
				-- "denols", -- Uncomment if you use Deno
				-- "graphql", -- Uncomment if you work with GraphQL schemas
			},
		})

		-- Optional: Install common formatters and linters via Mason
		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- A very common formatter for JS/TS/CSS/HTML
				"stylua",   -- Lua formatter
				"eslint_d", -- Faster ESLint daemon
			},
		})
	end,
}
