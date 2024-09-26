return {
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				transparent = true,
				overrides = function(colors)
					local theme = colors.theme
					return {
						TelescopeTitle = { fg = theme.syn.special1, bg="#000000", bold = true },
						TelescopePromptNormal = { bg = theme.ui.bg_p1 },
						TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
						TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
						TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
						TelescopePreviewNormal = { bg = theme.ui.bg_dim },
						TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
						NormalFloat = { bg = "none" },
            -- String = { fg = theme.ui.special },
						FloatBorder = { bg = "none" },
						FloatTitle = { bg = "none" },
						NormalDark = { fg = theme.ui.fg_dim, bg = "#000000" },
						LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
						MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            SignColumn = { bg = "#000000", fg = theme.ui.fg_reverse },
            LineNr = { bg = "#000000", fg = theme.diag.ok },
            NoiceCmdlinePopup = { bg = theme.ui.bg_p1 }
					}
				end,
			})
			vim.cmd("colorscheme kanagawa")
		end,
	},
}

