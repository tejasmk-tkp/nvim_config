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
				"lemminx",
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
					"stylua",
					"xmllint",
					"cmake-language-server",
					"actionlint",
					"checkmake",
					"cmakelang",
					"cmakelint",
					"codespell",
					"cpptools",
					"mypy",
					"ruff",
					"yapf",
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

			-- Build ROS Python paths dynamically from environment
			local function get_ros_python_paths()
				local paths = {}

				-- From ROS_PYTHON_PATH env var (set in .zshrc)
				local ros_path = vim.env.ROS_PYTHON_PATH
				if ros_path and ros_path ~= "" then
					table.insert(paths, ros_path)
				end

				-- From workspace env var (optional)
				local ws_path = vim.env.ROS_WS_PYTHON_PATH
				if ws_path and ws_path ~= "" then
					table.insert(paths, ws_path)
				end

				-- Fallback: try to detect from AMENT_PREFIX_PATH (set when you source ROS)
				local ament_path = vim.env.AMENT_PREFIX_PATH
				if ament_path and ament_path ~= "" then
					for prefix in ament_path:gmatch("[^:]+") do
						-- Try common Python lib locations
						local py_paths = {
							prefix .. "/lib/python3.12/site-packages",
							prefix .. "/lib/python3.11/site-packages",
							prefix .. "/lib/python3.10/site-packages",
							prefix .. "/local/lib/python3.12/dist-packages",
							prefix .. "/local/lib/python3.11/dist-packages",
							prefix .. "/local/lib/python3.10/dist-packages",
						}
						for _, p in ipairs(py_paths) do
							if vim.fn.isdirectory(p) == 1 then
								table.insert(paths, p)
							end
						end
					end
				end

				-- Remove duplicates
				local seen = {}
				local unique = {}
				for _, p in ipairs(paths) do
					if not seen[p] then
						seen[p] = true
						table.insert(unique, p)
					end
				end

				return unique
			end

			-- Setup each installed LSP with enhanced settings
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			lspconfig.pyright.setup({
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							extraPaths = get_ros_python_paths(),
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
					"package.xml",
					"prj.conf",
					".git"
				),
			})

			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
			})

			lspconfig.lemminx.setup({
				capabilities = capabilities,
				filetypes = { "xml", "xsd", "xsl", "xslt", "svg", "launch" },
			})

			lspconfig.cmake.setup({
				capabilities = capabilities,
			})
		end,
	},
}
