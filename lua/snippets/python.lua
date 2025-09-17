-- ~/.config/nvim/lua/snippets/python.lua
-- LuaSnip snippets for eYRC coding standards

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- Helper functions
local function get_filename()
    return vim.fn.expand("%:t")
end

local snippets = {
    -- File header comment
    s("snip-cs-eyrc-file", {
        t({ "'''", "# Team ID: " }),
        i(1, "Team-ID"),
        t({ "", "# Theme: " }),
        i(2, "Theme Name"),
        t({ "", "# Author List: " }),
        i(3, "Author1, Author2"),
        t({ "", "# Filename: " }),
        f(get_filename, {}),
        t({ "", "# Functions: " }),
        i(4, "function1, function2"),
        t({ "", "# Global variables: " }),
        i(5, "None"),
        t({ "", "'''", "", "" }),
        i(0),
    }),

    -- Variable comment
    s("snip-cs-var", {
        t("# "),
        i(1, "variable_name"),
        t(": "),
        i(2, "description of variable and its use"),
        i(0),
    }),

    -- Implementation comment
    s("snip-cs-impl", {
        t("# "),
        i(1, "Short description of what the code below is doing"),
        i(0),
    }),

    -- Complete function with documentation
    s("snip-cs-func", {
        t({ "'''", "Purpose:", "---", "" }),
        i(3, "Function description"),
        t({ "", "", "Input Arguments:", "---", "`" }),
        i(4, "arg1"),
        t("` : [ "),
        i(5, "type"),
        t(" ]"),
        t({ "" }),
        i(6, "arg1 description"),
        t({ "", "", "Returns:", "---", "`" }),
        i(7, "return_val"),
        t("` : [ "),
        i(8, "type"),
        t(" ]"),
        t({ "" }),
        i(9, "return description"),
        t({ "", "", "Example call:", "---", "" }),
        i(10, "function_name(example_args)"),
        t({ "'''", "" }),
    }),
}

return snippets
