return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()
		local keymap = vim.keymap
		keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
		end, { desc = "Add file to harpoon" })
		keymap.set("n", "<leader>hb", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Open harpoon list UI" })
		keymap.set("n", "<leader>hd", function(item)
      harpoon:list():delete(item)
		end, { desc = "Delete file from harpoon" })

		keymap.set("n", "<leader>1", function()
			harpoon:list():select(1)
		end)
		keymap.set("n", "<leader>2", function()
			harpoon:list():select(2)
		end)
		keymap.set("n", "<leader>3", function()
			harpoon:list():select(3)
		end)
		keymap.set("n", "<leader>4", function()
			harpoon:list():select(4)
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		keymap.set("n", "<C-S-P>", function()
			harpoon:list():prev()
		end)
		keymap.set("n", "<C-S-N>", function()
			harpoon:list():next()
		end)
	end,
}
