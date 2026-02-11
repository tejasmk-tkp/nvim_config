return {
    "hat0uma/csvview.nvim",
    ft = { "csv" },
    config = function()
        require("csvview").setup({
            view = {
                display_mode = "highlight", -- "border" or "highlight"
            },
        })

        -- Auto-enable csvview when opening CSV files
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "csv",
            callback = function()
                vim.cmd("CsvViewEnable")
            end,
        })
    end,
}
