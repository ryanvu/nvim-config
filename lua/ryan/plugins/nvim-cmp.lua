return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
		"luckasRanarison/tailwind-tools.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")
		local duplicates = {
			nvim_lsp = 0,
			luasnip = 1,
			path = 1,
			buffer = 1,
		}
		local duplicates_default = 0

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()
		-- Add these lines to extend React snippets
		require("luasnip").filetype_extend("javascriptreact", { "javascript" })
		require("luasnip").filetype_extend("typescriptreact", { "typescript" })
		require("luasnip").filetype_extend("javascript", { "next" })
		require("luasnip").filetype_extend("typescript", { "next" })

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered({
					scrollbar = false,
					scrolloff = 8,
					col_offset = -3,
					winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
				}),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif require("luasnip").expand_or_jumpable() then
						vim.fn.feedkeys(
							vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
							""
						)
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif require("luasnip").jumpable(-1) then
						vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
				{ name = "friendly-snippets" },
			}),

			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				expandable_indicator = true,
				fields = { cmp.ItemField.Abbr, cmp.ItemField.Kind, cmp.ItemField.Menu },
				format = function(entry, vim_item)
					local lsp_format = lspkind.cmp_format({
						mode = "symbol-text",
						maxwidth = math.min(50, math.floor(vim.o.columns * 0.5)),
						ellipsis_char = "...",
						preset = "codicons",
						menu = {
							async_path = "ᴘᴀᴛʜ",
							buffer = "ʙᴜꜰ",
							luasnip = "sɴɪᴘ",
							snippy = "sɴɪᴘ",
							nvim_lsp = "ʟsᴘ",
							nvim_lua = "ʟᴜᴀ",
							path = "ᴘᴀᴛʜ",
						},
						---@diagnostic disable-next-line: redefined-local
						before = function(entry, vim_item)
							vim_item = require("tailwind-tools.cmp").lspkind_format(entry, vim_item)
							if vim.tbl_contains({ "nvim_lsp" }, entry.source.name) then
								vim_item.dup = duplicates[entry.source.name] or duplicates_default
							end
							return vim_item
						end,
						show_labelDetails = true,
					})(entry, vim_item)

					local tailwind_colorized = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)

					-- print(vim.inspect(tailwind_colorized))
					if tailwind_colorized.kind == "XX" then
						lsp_format.kind = "  "
						lsp_format.kind_hl_group = tailwind_colorized.kind_hl_group
						lsp_format.menu = "ᴛᴡ"
					end

					if tailwind_colorized.kind == "" then
						lsp_format.kind = "▇▇"
						lsp_format.menu = "ᴛᴡ"
					end

					return lsp_format
				end,
			},
		})
	end,
}
