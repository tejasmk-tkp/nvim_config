return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        -- Core settings
        preset = "modern", -- "classic" | "modern" | "helix"
        delay = 500, -- Reduced delay for better responsiveness

        -- Visual settings
        win = {
            border = "rounded",
            padding = { 2, 2 },
            title = true,
            title_pos = "center",
            zindex = 1000,
            bo = {},
            wo = {
                winblend = 0,
            },
        },

        layout = {
            width = { min = 20 },
            spacing = 3,
        },

        keys = {
            scroll_down = "<c-d>",
            scroll_up = "<c-u>",
        },

        sort = { "local", "order", "group", "alphanum", "mod" },
        expand = 0,

        filter = function(mapping)
            return true
        end,

        -- Comprehensive spec for organized keymaps
        spec = {
            {
                mode = { "n", "v" },
                -- File operations
                { "<leader>f", group = "📁 File/Find" },
                { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
                { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
                { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
                { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
                { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
                { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },

                -- Buffer operations
                { "<leader>b", group = "📄 Buffer" },
                { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Switch buffer" },
                { "<leader>bd", "<cmd>bdelete<cr>", desc = "Delete buffer" },
                { "<leader>bn", "<cmd>bnext<cr>", desc = "Next buffer" },
                { "<leader>bp", "<cmd>bprevious<cr>", desc = "Previous buffer" },
                { "<leader>ba", "<cmd>%bd|e#<cr>", desc = "Delete all but current" },

                -- Window operations
                { "<leader>w", group = "🪟 Window" },
                { "<leader>wv", "<cmd>vsplit<cr>", desc = "Vertical split" },
                { "<leader>wh", "<cmd>split<cr>", desc = "Horizontal split" },
                { "<leader>wc", "<cmd>close<cr>", desc = "Close window" },
                { "<leader>wo", "<cmd>only<cr>", desc = "Only window" },
                { "<leader>w=", "<C-w>=", desc = "Equal windows" },
                { "<leader>wH", "<C-w>H", desc = "Move left" },
                { "<leader>wJ", "<C-w>J", desc = "Move down" },
                { "<leader>wK", "<C-w>K", desc = "Move up" },
                { "<leader>wL", "<C-w>L", desc = "Move right" },

                -- Navigation between windows (leader-based)
                { "<leader>ww", "<C-w>w", desc = "Next window" },
                { "<leader>wj", "<C-w>j", desc = "Window below" },
                { "<leader>wk", "<C-w>k", desc = "Window above" },
                { "<leader>wl", "<C-w>l", desc = "Window right" },
                { "<leader>wn", "<C-w>h", desc = "Window left" },

                -- Explorer
                { "<leader>e", group = "🗂️ Explorer" },
                { "<leader>ee", "<cmd>Neotree filesystem reveal float<cr>", desc = "Float explorer" },
                { "<leader>et", "<cmd>Neotree toggle<cr>", desc = "Toggle explorer" },
                { "<leader>ef", "<cmd>Neotree focus<cr>", desc = "Focus explorer" },
                { "<leader>ec", "<cmd>Neotree close<cr>", desc = "Close explorer" },

                -- Search operations
                { "<leader>s", group = "🔍 Search" },
                { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Search files" },
                { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Search text" },
                { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search buffer" },
                { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Search help" },
                { "<leader>sr", "<cmd>Telescope resume<cr>", desc = "Resume search" },
                { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Search keymaps" },
                { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Search commands" },

                -- LSP operations
                { "<leader>l", group = "🔧 LSP" },
                { "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Go to definition" },
                { "<leader>lr", "<cmd>lua vim.lsp.buf.references()<cr>", desc = "References" },
                { "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Hover" },
                { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code action" },
                { "<leader>ln", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
                { "<leader>lf", "<cmd>lua vim.lsp.buf.format()<cr>", desc = "Format" },
                { "<leader>le", "<cmd>lua vim.diagnostic.open_float()<cr>", desc = "Show diagnostics" },
                { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Diagnostics to loclist" },
                { "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next diagnostic" },
                { "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev diagnostic" },

                -- Git operations
                { "<leader>g", group = "🌿 Git" },
                { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
                { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
                { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff split" },
                { "<leader>gl", "<cmd>Git log<cr>", desc = "Git log" },
                { "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
                { "<leader>gP", "<cmd>Git pull<cr>", desc = "Git pull" },

                -- Git hunks (gitsigns)
                { "<leader>gh", group = "Git Hunks" },
                { "<leader>ghs", "<cmd>lua require('gitsigns').stage_hunk()<cr>", desc = "Stage hunk" },
                { "<leader>ghr", "<cmd>lua require('gitsigns').reset_hunk()<cr>", desc = "Reset hunk" },
                { "<leader>ghS", "<cmd>lua require('gitsigns').stage_buffer()<cr>", desc = "Stage buffer" },
                { "<leader>ghu", "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>", desc = "Undo stage hunk" },
                { "<leader>ghR", "<cmd>lua require('gitsigns').reset_buffer()<cr>", desc = "Reset buffer" },
                { "<leader>ghp", "<cmd>lua require('gitsigns').preview_hunk()<cr>", desc = "Preview hunk" },
                { "<leader>ghb", "<cmd>lua require('gitsigns').blame_line{full=true}<cr>", desc = "Blame line" },
                { "<leader>ghd", "<cmd>lua require('gitsigns').diffthis()<cr>", desc = "Diff this" },
                { "<leader>ghD", "<cmd>lua require('gitsigns').diffthis('~')<cr>", desc = "Diff this ~" },
                { "<leader>ghn", "<cmd>lua require('gitsigns').nav_hunk('next')<cr>", desc = "Next hunk" },
                { "<leader>ghN", "<cmd>lua require('gitsigns').nav_hunk('prev')<cr>", desc = "Prev hunk" },

                -- Debug operations
                { "<leader>d", group = "🐛 Debug" },
                { "<leader>dt", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle breakpoint" },
                { "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue" },
                { "<leader>dx", "<cmd>DapTerminate<cr>", desc = "Terminate" },
                { "<leader>do", "<cmd>DapStepOver<cr>", desc = "Step over" },
                { "<leader>di", "<cmd>DapStepInto<cr>", desc = "Step into" },
                { "<leader>dO", "<cmd>DapStepOut<cr>", desc = "Step out" },
                { "<leader>dr", "<cmd>DapRepl<cr>", desc = "Open REPL" },
                { "<leader>du", "<cmd>lua require('dapui').toggle()<cr>", desc = "Toggle DAP UI" },
                { "<leader>dh", "<cmd>lua require('dapui').eval()<cr>", desc = "Evaluate expression" },

                -- Copilot operations
                { "<leader>c", group = "🤖 Copilot" },
                { "<leader>ct", "<cmd>Copilot toggle<cr>", desc = "Toggle Copilot" },
                { "<leader>cp", "<cmd>Copilot panel<cr>", desc = "Copilot panel" },
                { "<leader>cs", "<cmd>Copilot suggestion<cr>", desc = "Copilot suggestion" },

                -- Copilot Chat
                { "<leader>cc", group = "💬 Copilot Chat" },
                { "<leader>ccq", function()
                    local input = vim.fn.input("Quick Chat: ")
                    if input ~= "" then
                        require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
                    end
                end, desc = "Quick chat" },
                { "<leader>cch", function()
                    local actions = require("CopilotChat.actions")
                    require("CopilotChat.integrations.telescope").pick(actions.help_actions())
                end, desc = "Help actions" },
                { "<leader>ccp", function()
                    local actions = require("CopilotChat.actions")
                    require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
                end, desc = "Prompt actions" },
                { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "Explain code" },
                { "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "Generate tests" },
                { "<leader>ccr", "<cmd>CopilotChatReview<cr>", desc = "Review code" },
                { "<leader>ccR", "<cmd>CopilotChatRefactor<cr>", desc = "Refactor code" },
                { "<leader>ccn", "<cmd>CopilotChatRename<cr>", desc = "Rename" },
                { "<leader>ccv", "<cmd>CopilotChatToggle<cr>", desc = "Toggle chat" },
                { "<leader>cci", "<cmd>CopilotChatInline<cr>", desc = "Inline chat" },
                { "<leader>ccf", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "Fix diagnostic" },
                { "<leader>ccl", "<cmd>CopilotChatReset<cr>", desc = "Clear buffer and chat history" },
                { "<leader>ccs", function()
                    require("CopilotChat").ask("Summarize the selected code", { selection = require("CopilotChat.select").buffer })
                end, desc = "Summarize buffer" },
                { "<leader>ccm", "<cmd>CopilotChatCommit<cr>", desc = "Generate commit message for all changes" },
                { "<leader>ccM", "<cmd>CopilotChatCommitStaged<cr>", desc = "Generate commit message for staged changes" },

                -- Terminal operations
                { "<leader>t", group = "💻 Terminal" },
                { "<leader>tt", "<cmd>terminal<cr>", desc = "Open terminal" },
                { "<leader>tv", "<cmd>vsplit | terminal<cr>", desc = "Vertical terminal" },
                { "<leader>th", "<cmd>split | terminal<cr>", desc = "Horizontal terminal" },
                { "<leader>tf", "<cmd>terminal<cr>", desc = "Float terminal" },

                -- Toggles
                { "<leader>T", group = "🔄 Toggle" },
                { "<leader>Tb", "<cmd>lua require('gitsigns').toggle_current_line_blame()<cr>", desc = "Toggle git blame" },
                { "<leader>Td", "<cmd>lua require('gitsigns').toggle_deleted()<cr>", desc = "Toggle deleted" },
                { "<leader>Tn", "<cmd>set number!<cr>", desc = "Toggle line numbers" },
                { "<leader>Tr", "<cmd>set relativenumber!<cr>", desc = "Toggle relative numbers" },
                { "<leader>Tw", "<cmd>set wrap!<cr>", desc = "Toggle word wrap" },

                -- Quit operations
                { "<leader>q", group = "❌ Quit" },
                { "<leader>qq", "<cmd>qa<cr>", desc = "Quit all" },
                { "<leader>qQ", "<cmd>qa!<cr>", desc = "Force quit all" },
                { "<leader>qw", "<cmd>wqa<cr>", desc = "Save and quit all" },
                { "<leader>qc", "<cmd>close<cr>", desc = "Close window" },

                -- Miscellaneous
                { "<leader>m", group = "📋 Misc" },
                { "<leader>mh", "<cmd>nohlsearch<cr>", desc = "Clear highlights" },
                { "<leader>mr", "<cmd>lua vim.lsp.buf.reload()<cr>", desc = "Reload LSP" },
                { "<leader>ms", "<cmd>source %<cr>", desc = "Source file" },

                -- Quick access (no submenu)
                { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
                { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Search text" },
                { "<leader>,", "<cmd>Telescope buffers<cr>", desc = "Switch buffer" },

                -- Global navigation keymaps (commonly used)
                { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
                { "<C-n>", "<cmd>Neotree filesystem reveal float<cr>", desc = "Toggle file tree" },

            },
            -- Visual mode specific
            {
                mode = { "v" },
                { "<leader>ghs", function()
                    require('gitsigns').stage_hunk {vim.fn.line('.'), vim.fn.line('v')}
                end, desc = "Stage hunk (visual)" },
                { "<leader>ghr", function()
                    require('gitsigns').reset_hunk {vim.fn.line('.'), vim.fn.line('v')}
                end, desc = "Reset hunk (visual)" },
                { "<leader>ccx", ":<C-u>CopilotChatInline<cr>", desc = "Inline chat" },
            },
            -- Insert mode for Copilot
            {
                mode = { "i" },
                { "<C-J>", 'copilot#Accept("\\<CR>")', expr = true, replace_keycodes = false, desc = "Accept Copilot suggestion" },
                { "<C-L>", "<Plug>(copilot-accept-word)", desc = "Accept Copilot word" },
                { "<C-H>", "<Plug>(copilot-previous)", desc = "Previous Copilot suggestion" },
                { "<C-K>", "<Plug>(copilot-next)", desc = "Next Copilot suggestion" },
                { "<C-]>", "<Plug>(copilot-dismiss)", desc = "Dismiss Copilot suggestion" },
            },
        },

        triggers = {
            { "<auto>", mode = "nixsotc" },
            { "<leader>", mode = { "n", "v" } },
        },

        defer = function(ctx)
            return ctx.mode == "V" or ctx.mode == "<C-V>"
        end,

        plugins = {
            marks = true,
            registers = true,
            spelling = {
                enabled = true,
                suggestions = 20,
            },
            presets = {
                operators = false,
                motions = true,
                text_objects = true,
                windows = false, -- We handle window navigation with leader
                nav = true,
                z = true,
                g = true,
            },
        },

        icons = {
            breadcrumb = "»",
            separator = "➜",
            group = "+",
        },

        show_help = true,
        show_keys = true,
    },
}
