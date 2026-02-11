return {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
        require("peek").setup({
            auto_load = true,
            close_on_bdelete = true,
            syntax = true,
            theme = "dark",
            update_on_change = true,
            app = "browser",  -- or "webview" for built-in
            filetype = { "markdown" },
            throttle_at = 200000,
            throttle_time = "auto",
        })

        vim.api.nvim_create_user_command("MarkdownPreview", require("peek").open, {})
        vim.api.nvim_create_user_command("MarkdownPreviewStop", require("peek").close, {})
        vim.api.nvim_create_user_command("MarkdownPreviewToggle", function()
            local peek = require("peek")
            if peek.is_open() then
                peek.close()
            else
                peek.open()
            end
        end, {})
    end,
}
