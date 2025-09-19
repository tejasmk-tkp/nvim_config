-- ~/.config/nvim/lua/snippets/python.lua
-- LuaSnip snippets for Python with enhanced documentation

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- Helper functions
local function get_filename()
    return vim.fn.expand("%:t")
end

-- Function to scan buffer and get all functions
local function get_all_functions()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local functions = {}
    
    for _, line in ipairs(lines) do
        local func_name = line:match("^%s*def%s+([%w_]+)")
        if func_name and func_name ~= "__init__" then
            table.insert(functions, func_name)
        end
    end
    
    if #functions > 0 then
        return table.concat(functions, ", ")
    end
    return "function1, function2"
end

-- Function to scan buffer and get all classes
local function get_all_classes()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local classes = {}
    
    for _, line in ipairs(lines) do
        local class_name = line:match("^%s*class%s+([%w_]+)")
        if class_name then
            table.insert(classes, class_name)
        end
    end
    
    if #classes > 0 then
        return table.concat(classes, ", ")
    end
    return ""
end

-- Function to get function name from surrounding context
local function get_function_name()
    local bufnr = vim.api.nvim_get_current_buf()
    local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    
    -- Look for function definition above current line
    for i = cursor_line - 1, math.max(1, cursor_line - 10), -1 do
        if lines[i] then
            local func_name = lines[i]:match("^%s*def%s+([%w_]+)")
            if func_name then
                return func_name
            end
        end
    end
    
    -- Look for function definition below current line
    for i = cursor_line, math.min(#lines, cursor_line + 5) do
        if lines[i] then
            local func_name = lines[i]:match("^%s*def%s+([%w_]+)")
            if func_name then
                return func_name
            end
        end
    end
    
    return "function_name"
end

-- Function to get class name from surrounding context
local function get_class_name()
    local bufnr = vim.api.nvim_get_current_buf()
    local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    
    -- Look for class definition above current line
    for i = cursor_line - 1, math.max(1, cursor_line - 20), -1 do
        if lines[i] then
            local class_name = lines[i]:match("^%s*class%s+([%w_]+)")
            if class_name then
                return class_name
            end
        end
    end
    
    -- Look for class definition below current line
    for i = cursor_line, math.min(#lines, cursor_line + 5) do
        if lines[i] then
            local class_name = lines[i]:match("^%s*class%s+([%w_]+)")
            if class_name then
                return class_name
            end
        end
    end
    
    return "ClassName"
end

-- Function to extract function parameters from context
local function get_function_params()
    local bufnr = vim.api.nvim_get_current_buf()
    local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    
    -- Look for function definition around current line
    for i = math.max(1, cursor_line - 10), math.min(#lines, cursor_line + 5) do
        if lines[i] then
            local params = lines[i]:match("def%s+[%w_]+%(([^)]*)%)")
            if params and params ~= "" then
                -- Remove 'self' parameter for methods and clean up
                params = params:gsub("^self%s*,%s*", ""):gsub("^self$", "")
                if params ~= "" then
                    return params
                end
            end
        end
    end
    
    return "args"
end

-- Function to get method names from current class context
local function get_class_methods()
    local bufnr = vim.api.nvim_get_current_buf()
    local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local methods = {}
    local class_start = nil
    local class_indent = nil
    
    -- Find the class we're currently in
    for i = cursor_line, 1, -1 do
        if lines[i] and lines[i]:match("^%s*class%s+") then
            class_start = i
            class_indent = lines[i]:match("^(%s*)")
            break
        end
    end
    
    if class_start then
        -- Scan from class start to find methods
        for i = class_start + 1, #lines do
            local line = lines[i]
            if line:match("^" .. (class_indent or "") .. "%S") and not line:match("^" .. (class_indent or "") .. "%s") then
                -- We've left the class
                break
            elseif line then
                local method = line:match("^%s*def%s+([%w_]+)")
                if method and method ~= "__init__" then
                    table.insert(methods, method .. "()")
                end
            end
        end
    end
    
    if #methods > 0 then
        return table.concat(methods, ", ")
    end
    return "method1()"
end

local snippets = {
    -- eYRC file header comment
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
        f(get_all_functions, {}),
        t({ "", "# Classes: " }),
        f(get_all_classes, {}),
        t({ "", "# Global variables: " }),
        i(4, "None"),
        t({ "", "'''", "", "" }),
        i(0),
    }),

    -- General file header comment
    s("snip-cs-file", {
        t({ "'''", "# Author: " }),
        i(1, "Your Name"),
        t({ "", "# Filename: " }),
        f(get_filename, {}),
        t({ "", "# Description: " }),
        i(2, "Brief description of the file"),
        t({ "", "# Functions: " }),
        f(get_all_functions, {}),
        t({ "", "# Classes: " }),
        f(get_all_classes, {}),
        t({ "", "# Global variables: " }),
        i(3, "None"),
        t({ "", "'''", "", "" }),
        i(0),
    }),

    -- Function documentation with placeholders
    s("snip-cs-func", {
        t({ "'''", "Purpose:", "---", "" }),
        i(1, "Function description"),
        t({ "", "", "Input Arguments:", "---", "`" }),
        i(2, "arg1"),
        t("` : [ "),
        i(3, "type"),
        t(" ]"),
        t({ "" }),
        i(4, "arg1 description"),
        t({ "", "", "Returns:", "---", "`" }),
        i(5, "return_val"),
        t("` : [ "),
        i(6, "type"),
        t(" ]"),
        t({ "" }),
        i(7, "return description"),
        t({ "", "", "Example call:", "---", "" }),
        f(get_function_name, {}),
        t("("),
        f(get_function_params, {}),
        t({ ")", "'''" }),
        t({ "" }),
        i(0),
    }),

    -- Class documentation
    s("snip-cs-class", {
        t({ "'''", "Purpose:", "---", "" }),
        i(1, "Class description"),
        t({ "", "", "Attributes:", "---", "`" }),
        i(2, "attribute1"),
        t("` : [ "),
        i(3, "type"),
        t(" ]"),
        t({ "" }),
        i(4, "attribute1 description"),
        t({ "", "", "Methods:", "---", "`" }),
        f(get_class_methods, {}),
        t("` : "),
        i(5, "method description"),
        t({ "", "", "Example usage:", "---", "" }),
        i(6, "obj = "),
        f(get_class_name, {}),
        t({ "(args)", "'''" }),
        t({ "" }),
        i(0),
    }),
}

return snippets
