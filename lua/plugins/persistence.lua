return {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
        dir = vim.fn.stdpath("state") .. "/sessions/",
        options = { "buffers", "curdir", "tabpages", "winsize" },
    },
    keys = {
        { "<leader>Sr", function() require("persistence").load() end, desc = "Restore session" },
        { "<leader>Sl", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
        { "<leader>Ss", function() require("persistence").stop() end, desc = "Don't save session" },
    },
}
