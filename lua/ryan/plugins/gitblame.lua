return {
	"f-person/git-blame.nvim",
	cmd = {
		"GitBlameToggle",
		"GitBlameEnable",
		"GitBlameOpenCommitURL",
		"GitBlameCopyCommitURL",
		"GitBlameOpenFileURL",
		"GitBlameCopyFileURL",
		"GitBlameCopySHA",
	},
	keys = {
		{ "<leader>tgb", "<cmd>GitBlameToggle<cr>", desc = "GitBlameToggle" },
	},
}
