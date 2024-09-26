return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            svelte = { "eslint_d" },
            lua = { "luacheck" },
            python = { "pylint" },
            -- Add more file types and linters as needed
        }

        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })

        vim.keymap.set("n", "<leader>l", function()
            lint.try_lint()
        end, { desc = "Trigger linting for current file" })

        vim.keymap.set("n", "<leader>lf", function()
            lint.try_lint()
            vim.diagnostic.setloclist({ open = true })
        end, { desc = "Trigger linting and open diagnostics list" })

        -- Function to get the names of active linters for the current buffer
        local function get_active_linters()
            local ft = vim.bo.filetype
            return lint.linters_by_ft[ft] or {}
        end

        -- Keymap to show active linters
        vim.keymap.set("n", "<leader>la", function()
            local linters = get_active_linters()
            if #linters > 0 then
                print("Active linters: " .. table.concat(linters, ", "))
            else
                print("No active linters for this file type")
            end
        end, { desc = "Show active linters" })
    end,
}
