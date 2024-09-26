return {
	"stevearc/dressing.nvim",
	config = function()
		require("dressing").setup({
			select = {
				telescope = {
					borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
				},
			},
		})
	end,
}
