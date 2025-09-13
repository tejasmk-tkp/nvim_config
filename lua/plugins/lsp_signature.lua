return {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",  -- load when needed, keeps startup fast
    config = function()
        require("lsp_signature").setup({
            bind = true, -- mandatory, else it won’t work
            hint_enable = false, -- inline hints can be noisy
            handler_opts = {
                border = "rounded",
            },
            floating_window = true, -- the VSCode-style popup
            transparency = 5, -- optional, make it semi-transparent
        })
    end,
}
