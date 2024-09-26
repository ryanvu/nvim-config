return {
	"hadronized/hop.nvim",
	cmd = {
		"HopAnywhere",
		"HopChar1",
		"HopChar2",
		"HopLine",
		"HopLineStart",
		"HopVertical",
		"HopWord",
	},
	config = function()
		require("hop").setup({})
	end,
	keys = {
		{
			"<leader>fj",
			function()
				require("hop").hint_words()
			end,
			mode = { "n", "x", "o" },
		},
	},
}
