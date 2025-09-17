return {
	-- GitHub Copilot
	{
		"github/copilot.vim",
		event = "InsertEnter",
		config = function()
			-- Disable default tab mapping (we use custom mappings in which-key)
			vim.g.copilot_no_tab_map = true

			-- Filetypes to enable Copilot
			vim.g.copilot_filetypes = {
				["*"] = false,
				["javascript"] = true,
				["typescript"] = true,
				["lua"] = true,
				["rust"] = true,
				["c"] = true,
				["cpp"] = true,
				["go"] = true,
				["python"] = true,
				["html"] = true,
				["css"] = true,
				["scss"] = true,
				["json"] = true,
				["yaml"] = true,
				["markdown"] = true,
			}
		end,
	},

	-- Copilot Chat
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		dependencies = {
			{ "github/copilot.vim" },
			{ "nvim-lua/plenary.nvim" },
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			-- Simplified setup with default prompts
		},
		config = function(_, opts)
			local chat = require("CopilotChat")
			chat.setup(opts)
		end,
		event = "VeryLazy",
	},
}
