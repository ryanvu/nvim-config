-- leader key definition (ensure this is at the very top of your keymaps file)
vim.g.mapleader = " "

local keymap = vim.keymap

-- Exit insert mode with jk
keymap.set("i", "jk", "<ESC>", { desc = "Exit insertmode with jk" })

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- --- Window Management ---
-- Split window vertically
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })

-- Split window horizontally
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })

-- Make splits equal size
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })

-- Close current split and associated buffer if not used elsewhere
keymap.set("n", "<leader>sx", function()
    local current_buf = vim.api.nvim_get_current_buf()
    local current_win = vim.api.nvim_get_current_win()

    -- Close the current window
    vim.api.nvim_win_close(current_win, false)

    -- After closing the window, check if the buffer is still open in any other window.
    -- vim.fn.bufwinnr(current_buf) returns the window ID if the buffer is open, or -1 if not.
    if vim.api.nvim_buf_is_valid(current_buf) and vim.fn.bufwinnr(current_buf) == -1 then
        -- If the buffer is no longer in any window and is a 'listed' buffer, delete it.
        -- 'buflisted' ensures we don't delete special buffers like help files, quickfix lists, etc.
        if vim.api.nvim_buf_get_option(current_buf, 'buflisted') then
            vim.api.nvim_buf_delete(current_buf, { force = false })
            -- Optional: Add a subtle notification if you want to see which buffers are deleted
            -- vim.notify("Deleted unused buffer: " .. vim.api.nvim_buf_get_name(current_buf), vim.log.levels.INFO)
        end
    end
end, { desc = "Close current split and associated buffer if not used elsewhere" })


-- --- Tab Management ---
-- Open new tab
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })

-- Close current tab
-- The BufWinLeave autocmd below will handle closing the buffers automatically.
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })

-- Go to next tab
keymap.set("n", "<Tab>", "<cmd>tabn<CR>", { desc = "Go to next tab" })

-- Go to previous tab
keymap.set("n", "<S-Tab>", "<cmd>tabp<CR>", { desc = "Go to previous tab" })

-- Open current buffer in new tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- --- Visual Mode Indentation ---
keymap.set("v", "<", "<gv", { desc = "Indent line backwards" })
keymap.set("v", ">", ">gv", { desc = "Indent line forward" })

-- --- Navbuddy (if you've enabled it in lspconfig.lua dependencies) ---
keymap.set("n", "<leader>fl", "<cmd>Navbuddy<CR>", { desc = "Open Navbuddy" })

-- --- AUTOCMD TO AUTOMATICALLY DELETE UNUSED BUFFERS ---
-- This function deletes a buffer if it's no longer open in any window
local function delete_if_unused_buffer(bufnr)
    -- Check if the buffer is still valid, not in any window, and is a 'listed' buffer
    if vim.api.nvim_buf_is_valid(bufnr) and vim.fn.bufwinnr(bufnr) == -1 then
        if vim.api.nvim_buf_get_option(bufnr, 'buflisted') then
            vim.api.nvim_buf_delete(bufnr, { force = false })
            -- vim.notify("Auto-deleted unused buffer: " .. vim.api.nvim_buf_get_name(bufnr), vim.log.levels.INFO) -- Uncomment for debugging
        end
    end
end

-- Autocommand that runs whenever a buffer leaves a window
-- This covers cases like closing splits, closing tabs, or opening a new buffer in an existing window.
vim.api.nvim_create_autocmd("BufWinLeave", {
    callback = function(args)
        -- Call our cleanup function for the buffer that just left the window
        delete_if_unused_buffer(args.buf)
    end,
    -- Consider adding 'nested = true' if you have autocmds that trigger other autocmds,
    -- though generally not needed for this specific cleanup.
    -- pattern = "*", -- Apply to all buffers (default)
})
