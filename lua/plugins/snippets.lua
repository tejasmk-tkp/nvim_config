-- ~/.config/nvim/lua/plugins/snippets.lua
-- Plugin configuration only - NO keybindings here

return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/snippets/"})
    end,
  },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require('neogen').setup({
        enabled = true,
        input_after_comment = true,
        -- Use default python template for now - we'll rely mainly on LuaSnip snippets
        languages = {
          python = {
            template = {
              annotation_convention = "google_docstrings"
            }
          }
        }
      })
    end,
  }
}
