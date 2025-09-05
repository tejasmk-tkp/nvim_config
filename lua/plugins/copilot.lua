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
			-- Custom prompts
			prompts = {
				Explain = {
					prompt = "/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.",
				},
				Review = {
					prompt = "/COPILOT_REVIEW Review the selected code.",
				},
				Fix = {
					prompt = "/COPILOT_GENERATE There is a problem in this code. Rewrite the code to fix the problem.",
				},
				Optimize = {
					prompt = "/COPILOT_GENERATE Optimize the selected code to improve performance and readability.",
				},
				Docs = {
					prompt = "/COPILOT_GENERATE Please add documentation comment for the selection.",
				},
				Tests = {
					prompt = "/COPILOT_GENERATE Please generate tests for my code.",
				},
				FixDiagnostic = {
					prompt = "Please assist with the following diagnostic issue in file:",
					selection = function(source)
						return require("CopilotChat.select").diagnostics(source)
					end,
				},
				Commit = {
					prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
					selection = function(source)
						return require("CopilotChat.select").gitdiff(source)
					end,
				},
				CommitStaged = {
					prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
					selection = function(source)
						return require("CopilotChat.select").gitdiff(source, true)
					end,
				},
			},
		},
		config = function(_, opts)
			local chat = require("CopilotChat")
			-- Setup CopilotChat with opts (including prompts)
			chat.setup(opts)
			-- All keymaps are now handled in which-key configuration
		end,
		event = "VeryLazy",
	},
}
