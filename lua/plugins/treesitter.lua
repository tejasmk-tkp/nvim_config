-- plugins/treesitter.lua
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        
        config.setup({
            ensure_installed = {
                "lua", 
                "javascript",
                "typescript",
                "tsx",
                "python",
                "c",
                "cpp",
                "json",
                "css",
                "html",
                "xml"
            },
            highlight = { enable = true },
            indent = { enable = true }
        })
    end,
}
