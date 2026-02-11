return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- Diagnostics
        null_ls.builtins.diagnostics.tidy,       -- XML/HTML
        null_ls.builtins.diagnostics.checkmake,  -- Make files
        null_ls.builtins.diagnostics.cmake_lint, -- CMake
        null_ls.builtins.diagnostics.codespell,
        null_ls.builtins.diagnostics.mypy,       -- python
        null_ls.builtins.diagnostics.pylint,     --python
        null_ls.builtins.diagnostics.cppcheck,   -- c/c++
        null_ls.builtins.diagnostics.yamllint,   -- YAML

        -- Formatting
        null_ls.builtins.formatting.stylua,         -- Lua
        null_ls.builtins.formatting.clang_format,   -- C/C++
        null_ls.builtins.formatting.yapf,           -- Python
        null_ls.builtins.formatting.cmake_format,   -- CMake
        null_ls.builtins.formatting.xmllint,        -- XML
        null_ls.builtins.formatting.prettier.with({ -- YAML, JSON, Markdown, etc.
          filetypes = { "yaml", "yml", "json", "markdown" },
        }),
      },
    })

    -- No keymaps here - handled by which-key
    -- Formatting is available via <leader>lf in which-key config
  end,
}
