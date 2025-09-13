return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local npairs = require("nvim-autopairs")

            npairs.setup({
                check_ts = true, -- use treesitter to be smart
                disable_filetype = { "TelescopePrompt", "vim" },
            })

            -- If you’re using nvim-cmp, hook it in
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },

    -- For auto-closing & auto-renaming HTML/XML tags (URDF/Xacro life-saver)
    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
}
