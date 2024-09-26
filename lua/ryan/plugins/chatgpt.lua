return {
	"jackMort/ChatGPT.nvim",
	event = "VeryLazy",
	keys = {
		{ "<leader>gpt", "<cmd>ChatGPT<CR>", { noremap = true, silent = true } },
	},
	config = function()
		require("chatgpt").setup({
			api_key_cmd = "pass show personal/openai",
			openai_params = {
				max_tokens = 1600,
			},
		})
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim",
		"nvim-telescope/telescope.nvim",
	},
}
