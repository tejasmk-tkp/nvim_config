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
  s("eyrc-file", {
    t({"'''", "# Team ID: "}), i(1, "Team-ID"), 
    t({"", "# Theme: "}), i(2, "Theme Name"),
    t({"", "# Author List: "}), i(3, "Author1, Author2"),
    t({"", "# Filename: "}), f(get_filename, {}),
    t({"", "# Functions: "}), i(4, "function1, function2"),
    t({"", "# Global variables: "}), i(5, "None"),
    t({"", "'''", "", ""}), i(0)
  }),

  -- Function documentation
  s("eyrc-func", {
    t({"'''", "Purpose:", "---", ""}), i(1, "Short description of function purpose"),
    t({"", "", "Input Arguments:", "---", "`"}), i(2, "arg1"), t("` : [ "), i(3, "type"), t(" ]"),
    t({"", ""}), i(4, "Description of arg1"),
    t({"", "", "Returns:", "---", "`"}), i(5, "return_var"), t("` : [ "), i(6, "type"), t(" ]"),
    t({"", ""}), i(7, "Description of return value"),
    t({"", "", "Example call:", "---", ""}), i(8, "function_name(args)"),
    t({"", "'''"}), i(0)
  }),

  -- Variable comment
  s("eyrc-var", {
    t("# "), i(1, "variable_name"), t(": "), i(2, "description of variable and its use"), i(0)
  }),

  -- Implementation comment
  s("eyrc-impl", {
    t("# "), i(1, "Short description of what the code below is doing"), i(0)
  }),

  -- Complete function with documentation
  s("eyrc-def", {
    t("def "), i(1, "function_name"), t("("), i(2, "args"), t({"):", "    '''", "    Purpose:", "    ---", "    "}),
    i(3, "Function description"),
    t({"", "    ", "    Input Arguments:", "    ---", "    `"}), i(4, "arg1"), t("` : [ "), i(5, "type"), t(" ]"),
    t({"", "    "}), i(6, "arg1 description"),
    t({"", "    ", "    Returns:", "    ---", "    `"}), i(7, "return_val"), t("` : [ "), i(8, "type"), t(" ]"),
    t({"", "    "}), i(9, "return description"),
    t({"", "    ", "    Example call:", "    ---", "    "}), i(10, "function_name(example_args)"),
    t({"", "    '''", "    "}), i(0, "pass")
  }),

  -- Main function template
  s("eyrc-main", {
    t({"def main():", "    '''", "    Purpose:", "    ---", "    "}), i(1, "Main function description"),
    t({"", "    ", "    Input Arguments:", "    ---", "    None", "    ", "    Returns:", "    ---", "    None", "    ", "    Example call:", "    ---", "    Called automatically by the Operating System", "    '''", "    "}), i(0, "pass")
  }),

  -- if __name__ == "__main__" block
  s("eyrc-main-block", {
    t({"if __name__ == \"__main__\":", "    main()"}), i(0)
  }),

  -- Import section
  s("eyrc-imports", {
    t("import "), i(1, "os, sys"), i(0)
  })
}

return snippets
