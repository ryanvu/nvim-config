return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x", -- Use the 0.1.x branch for stability
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- fzf-native is essential for speed, requires 'fzf' CLI tool installed
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons", -- For file icons
		"nvim-telescope/telescope-file-browser.nvim", -- If you use file Browse features
		-- "dharmx/telescope-media.nvim", -- Removed for simplification
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin") -- For common pickers

		telescope.setup({
			-- Minimal defaults for a clean experience
			defaults = {
				-- wrap_results = true, -- Optional, uncomment if you prefer results to wrap
				-- layout_strategy = "horizontal", -- Optional, defaults to auto
				-- layout_config = { prompt_position = "top" }, -- Optional
				-- sorting_strategy = "ascending", -- Optional
				-- winblend = 0, -- Optional, uncomment for transparency
				-- path_display = { "smart" }, -- Optional
				-- borderchars = { " ", " ", " ", " ", " ", " ", " ", " " }, -- Optional, uncomment for no borders

				-- Basic mappings for Telescope windows
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to previous result in results pane
						["<C-j>"] = actions.move_selection_next,    -- move to next result in results pane
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfix list
						["<C-c>"] = actions.close, -- close telescope
					},
					n = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
			-- You can add specific picker options here if needed, e.g.:
			-- pickers = {
			--   find_files = {
			--     hidden = true, -- Show hidden files by default
			--   },
			-- },
		})

		-- Load Extensions:
		telescope.load_extension("fzf") -- Essential for speed with fzf-native
		telescope.load_extension("file_browser") -- For `Telescope file_browser` command

		-- Set Keymaps (using the built-in pickers)
		local keymap = vim.keymap

		keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fw", builtin.live_grep, { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Browse open buffers" })

		-- File Browser Keymap (optional, but useful if you keep the extension)
		keymap.set("n", "<leader>sf", function()
			telescope.extensions.file_browser.file_browser({
				path = "%:p:h", -- Start in current file's directory
				-- other options if desired for file_browser
			})
		end, { desc = "File Browser" })

		-- LSP related pickers (will work once LSP setup is fixed)
		-- These are defined in lspconfig.lua, but Telescope is the UI.
		-- You already have these in your lspconfig.lua LspAttach autocmd, which is a good place.
		-- keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Go to definition (Telescope)" })
		-- keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "Show LSP references (Telescope)" })
		-- keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show buffer diagnostics (Telescope)" })

	end,
}
