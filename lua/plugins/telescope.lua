-- plugins/telescope.lua
return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("telescope").setup({
            -- Add any telescope-specific configuration here
            defaults = {
                -- Configure telescope defaults if needed
                mappings = {
                    i = {
                        -- Insert mode mappings within telescope
                    },
                    n = {
                        -- Normal mode mappings within telescope
                    },
                },
            },
        })

        -- No global keymaps here - all handled by which-key
        -- Telescope functions are called via which-key mappings
    end,
}
