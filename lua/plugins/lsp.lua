return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
            ensure_installed = {
                "pyright",
                "rust_analyzer",
                "lua_ls",
                "clangd",
                "lemminx"
            },
			automatic_installation = true,
		},
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = {
					"stylua", -- Lua formatter
					"xmllint", -- XML formatter
					"cmake-language-server", -- CMake LSP (useful for ROS2/Zephyr)
                    "actionlint",
                    "checkmake",
                    "cmakelang",
                    "cmakelint",
                    "codespell",
                    "cpptools",
                    "mypy",
                    "ruff",
                    "yapf"
				},
				automatic_installation = false,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.offsetEncoding = { "utf-8" }
			
            -- Setup each installed LSP with enhanced settings
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			lspconfig.pyright.setup({
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							-- Better support for ROS2 Python packages
							extraPaths = {
								"/opt/ros/humble/lib/python3.10/site-packages",
								"/opt/ros/iron/lib/python3.11/site-packages",
								"/opt/ros/jazzy/lib/python3.12/site-packages",
							},
							autoImportCompletions = true,
						},
					},
				},
			})

			lspconfig.clangd.setup({
				capabilities = capabilities,
				cmd = {
					"clangd",
					"--background-index",
					"--suggest-missing-includes",
					"--clang-tidy",
					"--header-insertion=iwyu",
                    "--offset-encoding=utf-8",
				},
				root_dir = lspconfig.util.root_pattern(
					"compile_commands.json",
					"CMakeLists.txt",
					"package.xml", -- ROS2 projects
					"prj.conf", -- Zephyr projects
					".git"
				),
			})

			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
			})

			lspconfig.lemminx.setup({
				capabilities = capabilities,
				filetypes = { "xml", "xsd", "xsl", "xslt", "svg", "launch" }, -- Added .launch for ROS
			})

			-- CMake LSP (install via Mason)
			lspconfig.cmake.setup({
				capabilities = capabilities,
			})

			-- No LSP keymaps here - all handled by which-key
			-- Individual buffer LSP mappings can be set up in an on_attach function if needed
			-- But we'll rely on which-key for consistency
		end,
	},
}
