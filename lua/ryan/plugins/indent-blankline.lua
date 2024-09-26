local highlight = {
	"LotusBlue",
}

local scope_highlight = {
  "PeachRed"
}

return {
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufEnter",
		config = function()
			local hooks = require("ibl.hooks")
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "LotusBlue", { fg = "#4d699b" })
        vim.api.nvim_set_hl(0, "PeachRed", { fg = "#FF5D62" })
			end)

			require("ibl").setup({
				indent = {
					char = "│",
					tab_char = "│",
					highlight = highlight,
				},
				scope = {
					enabled = true,
					highlight = scope_highlight
				},
				exclude = {
					filetypes = {
						"help",
						"lazy",
						"mason",
						"notify",
					},
				},
			})
		end,
	},
}
