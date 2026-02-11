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

local function get_date()
    return os.date("%Y-%m-%d")
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

-- Function to scan and get global variables
local function get_global_variables()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local globals = {}
    local in_function = false
    local in_class = false
    local indent_level = 0
    
    for _, line in ipairs(lines) do
        -- Skip empty lines and comments
        if line:match("^%s*$") or line:match("^%s*#") then
            goto continue
        end
        
        local current_indent = #(line:match("^%s*") or "")
        
        -- Track if we're inside a function or class
        if line:match("^%s*def%s+") then
            in_function = true
            indent_level = current_indent
        elseif line:match("^%s*class%s+") then
            in_class = true
            indent_level = current_indent
        elseif current_indent <= indent_level and (in_function or in_class) then
            in_function = false
            in_class = false
        end
        
        -- Look for global variable assignments (not inside functions/classes)
        if not in_function and not in_class and current_indent == 0 then
            -- Match various assignment patterns
            local var_name = line:match("^([%w_]+)%s*=") or
                           line:match("^([%w_]+)%s*:%s*[%w_%[%]]+%s*=") or
                           line:match("^([%w_]+)%s*:%s*[%w_%[%]]+")
            
            if var_name and not var_name:match("^__") then -- Exclude dunder variables
                table.insert(globals, var_name)
            end
        end
        
        ::continue::
    end
    
    if #globals > 0 then
        return table.concat(globals, ", ")
    end
    return "None"
end

-- Function to get function name from surrounding context
local function get_function_name()
    local bufnr = vim.api.nvim_get_current_buf()
    local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    
    -- Look for function definition above current line
    for line_i = cursor_line - 1, math.max(1, cursor_line - 10), -1 do
        if lines[line_i] then
            local func_name = lines[line_i]:match("^%s*def%s+([%w_]+)")
            if func_name then
                return func_name
            end
        end
    end
    
    -- Look for function definition below current line
    for line_i = cursor_line, math.min(#lines, cursor_line + 5) do
        if lines[line_i] then
            local func_name = lines[line_i]:match("^%s*def%s+([%w_]+)")
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
    for line_i = cursor_line - 1, math.max(1, cursor_line - 20), -1 do
        if lines[line_i] then
            local class_name = lines[line_i]:match("^%s*class%s+([%w_]+)")
            if class_name then
                return class_name
            end
        end
    end
    
    -- Look for class definition below current line
    for line_i = cursor_line, math.min(#lines, cursor_line + 5) do
        if lines[line_i] then
            local class_name = lines[line_i]:match("^%s*class%s+([%w_]+)")
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
    for line_i = math.max(1, cursor_line - 10), math.min(#lines, cursor_line + 5) do
        if lines[line_i] then
            local params = lines[line_i]:match("def%s+[%w_]+%(([^)]*)%)")
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
    for line_i = cursor_line, 1, -1 do
        if lines[line_i] and lines[line_i]:match("^%s*class%s+") then
            class_start = line_i
            class_indent = lines[line_i]:match("^(%s*)")
            break
        end
    end
    
    if class_start then
        -- Scan from class start to find methods
        for line_i = class_start + 1, #lines do
            local line = lines[line_i]
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

-- Function to get formatted args list for docstring (backtick format like snip-cs-func)
local function get_function_args_formatted()
    local bufnr = vim.api.nvim_get_current_buf()
    local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    
    -- Look for function definition around current line
    for line_i = math.max(1, cursor_line - 10), math.min(#lines, cursor_line + 5) do
        if lines[line_i] then
            local params = lines[line_i]:match("def%s+[%w_]+%(([^)]*)%)")
            if params and params ~= "" then
                -- Remove 'self' parameter
                params = params:gsub("^self%s*,%s*", ""):gsub("^self$", "")
                if params ~= "" then
                    local args = {}
                    -- Split by comma and process each arg
                    for arg in params:gmatch("[^,]+") do
                        arg = arg:match("^%s*(.-)%s*$") -- trim whitespace
                        local name, type_hint = arg:match("([%w_]+)%s*:%s*([^=]+)")
                        if name and type_hint then
                            type_hint = type_hint:match("^%s*(.-)%s*$") -- trim
                            table.insert(args, string.format("`%s` : [ %s ] description", name, type_hint))
                        else
                            local name_only = arg:match("([%w_]+)")
                            if name_only then
                                table.insert(args, string.format("`%s` : [ type ] description", name_only))
                            end
                        end
                    end
                    if #args > 0 then
                        return table.concat(args, "\n")
                    end
                end
            end
        end
    end
    
    return "`arg` : [ type ] description"
end

-- Function to get return type from function signature
local function get_function_return_type()
    local bufnr = vim.api.nvim_get_current_buf()
    local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    
    -- Look for function definition around current line
    for line_i = math.max(1, cursor_line - 10), math.min(#lines, cursor_line + 5) do
        if lines[line_i] then
            local return_type = lines[line_i]:match("%)%s*%->%s*([^:]+)%s*:")
            if return_type then
                return return_type:match("^%s*(.-)%s*$") -- trim whitespace
            end
        end
    end
    
    return "type"
end

-- Function to get class attributes (self.xxx assignments in __init__)
local function get_class_attributes()
    local bufnr = vim.api.nvim_get_current_buf()
    local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local attributes = {}
    local class_start = nil
    local in_init = false
    local init_indent = nil
    
    -- Find the class we're currently in
    for line_i = cursor_line, 1, -1 do
        if lines[line_i] and lines[line_i]:match("^%s*class%s+") then
            class_start = line_i
            break
        end
    end
    
    if class_start then
        -- Scan from class start to find __init__ and its self.xxx assignments
        for line_i = class_start + 1, #lines do
            local line = lines[line_i]
            if not line then break end
            
            -- Check if we hit __init__
            if line:match("def%s+__init__%s*%(") then
                in_init = true
                init_indent = #(line:match("^(%s*)") or "")
            elseif in_init then
                local current_indent = #(line:match("^(%s*)") or "")
                -- Check if we've left __init__
                if line:match("^%s*def%s+") or (current_indent <= init_indent and not line:match("^%s*$")) then
                    break
                end
                -- Look for self.xxx = assignments
                local attr = line:match("self%.([%w_]+)%s*=")
                if attr and not attr:match("^_") then -- exclude private attrs
                    table.insert(attributes, attr)
                end
            end
        end
    end
    
    if #attributes > 0 then
        return table.concat(attributes, ", ")
    end
    return "attr1, attr2"
end

-- ROS2 Helper: Scan for subscribers in buffer
local function get_ros_subscribers()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local subs = {}
    
    for _, line in ipairs(lines) do
        -- Match create_subscription patterns
        local topic = line:match("create_subscription%s*%([^,]+,%s*['\"]([^'\"]+)['\"]")
        if topic then
            table.insert(subs, topic)
        end
    end
    
    if #subs > 0 then
        return table.concat(subs, ", ")
    end
    return "/topic_name"
end

-- ROS2 Helper: Scan for publishers in buffer
local function get_ros_publishers()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local pubs = {}
    
    for _, line in ipairs(lines) do
        -- Match create_publisher patterns
        local topic = line:match("create_publisher%s*%([^,]+,%s*['\"]([^'\"]+)['\"]")
        if topic then
            table.insert(pubs, topic)
        end
    end
    
    if #pubs > 0 then
        return table.concat(pubs, ", ")
    end
    return "/topic_name"
end

-- ROS2 Helper: Scan for services in buffer
local function get_ros_services()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local services = {}
    
    for _, line in ipairs(lines) do
        local service = line:match("create_service%s*%([^,]+,%s*['\"]([^'\"]+)['\"]")
        if service then
            table.insert(services, service)
        end
    end
    
    if #services > 0 then
        return table.concat(services, ", ")
    end
    return "None"
end

-- ROS2 Helper: Scan for parameters in buffer
local function get_ros_parameters()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local params = {}
    
    for _, line in ipairs(lines) do
        local param = line:match("declare_parameter%s*%(['\"]([^'\"]+)['\"]")
        if param then
            table.insert(params, param)
        end
    end
    
    if #params > 0 then
        return table.concat(params, ", ")
    end
    return "None"
end

-- ROS2 Helper: Scan for TF broadcasts
local function get_ros_tf_frames()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local frames = {}
    
    for _, line in ipairs(lines) do
        -- Match TransformStamped frame_id and child_frame_id assignments
        local parent = line:match("%.header%.frame_id%s*=%s*['\"]([^'\"]+)['\"]")
        local child = line:match("%.child_frame_id%s*=%s*['\"]([^'\"]+)['\"]")
        if parent then
            table.insert(frames, parent)
        end
        if child then
            table.insert(frames, child)
        end
    end
    
    if #frames > 0 then
        -- Remove duplicates
        local seen = {}
        local unique = {}
        for _, v in ipairs(frames) do
            if not seen[v] then
                seen[v] = true
                table.insert(unique, v)
            end
        end
        return table.concat(unique, " → ")
    end
    return "parent_frame → child_frame"
end

local snippets = {
    -- =====================================================
    -- General Documentation Snippets
    -- =====================================================
    
    -- General file header comment with auto-detected global variables
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
        f(get_global_variables, {}),
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

    -- =====================================================
    -- ROS2 NODE FILE-LEVEL DOCUMENTATION
    -- =====================================================
    
    -- Full ROS2 Node file header (comprehensive)
    s("snip-ros-node", {
        t({ '"""', "Node Name: " }),
        f(get_filename, {}),
        t({ "", "", "Purpose:", "    " }),
        i(1, "Short, high-level description of what this node does."),
        t({ "", "", "System Role:", "    " }),
        i(2, "Where this node fits in the architecture."),
        t({ "", "", "ROS Interfaces:", "", "    Subscribes: " }),
        f(get_ros_subscribers, {}),
        t({ "", "    Publishes:  " }),
        f(get_ros_publishers, {}),
        t({ "", "    Services:   " }),
        f(get_ros_services, {}),
        t({ "", "    Parameters: " }),
        f(get_ros_parameters, {}),
        t({ "", "", "TF Frames: " }),
        f(get_ros_tf_frames, {}),
        t({ "", "", "Behavioral Guarantees:", "    - " }),
        i(3, "What this node guarantees (e.g., monotonic timestamps)"),
        t({ "", "", "Failure Modes:", "    - " }),
        i(4, "What happens if input stops or time jumps"),
        t({ "", "", "Limitations:", "    - " }),
        i(5, "Known constraints (drift, latency, etc.)"),
        t({ "", "", "Author: " }),
        i(6, "Your Name"),
        t({ "", "Last Updated: " }),
        f(get_date, {}),
        t({ "", '"""', "", "" }),
        i(0),
    }),

    -- =====================================================
    -- ROS2 CLASS-LEVEL DOCUMENTATION
    -- =====================================================
    
    -- ROS2 Node class docstring (auto-detects attributes and methods)
    s("snip-ros-class", {
        t({ '"""', "Purpose:", "---", "" }),
        i(1, "One-line responsibility statement"),
        t({ "", "", "Responsibilities:", "---", "- " }),
        i(2, "What this class owns and manages"),
        t({ "", "", "Attributes:", "---", "`" }),
        f(get_class_attributes, {}),
        t({ "`", "", "", "Methods:", "---", "`" }),
        f(get_class_methods, {}),
        t({ "`", "", "", "Internal State:", "---", "- " }),
        i(3, "What persistent state is stored and invariants"),
        t({ "", "", "Threading Model:", "---", "" }),
        i(4, "SingleThreadedExecutor / MultiThreadedExecutor"),
        t({ "", "", "Example usage:", "---", "node = " }),
        f(get_class_name, {}),
        t({ "()", '"""' }),
        i(0),
    }),

    -- =====================================================
    -- ROS2 FUNCTION-LEVEL DOCUMENTATION
    -- =====================================================
    
    -- ROS2 function/callback docstring (auto-detects args and return type)
    s("snip-ros-func", {
        t({ '"""', "Purpose:", "---", "" }),
        i(1, "Brief description of what this function does"),
        t({ "", "", "Input Arguments:", "---", "" }),
        f(get_function_args_formatted, {}),
        t({ "", "", "Returns:", "---", "`" }),
        f(get_function_return_type, {}),
        t({ "` : " }),
        i(2, "Return description"),
        t({ "", "", "Assumptions:", "---", "- " }),
        i(3, "What must be true for this to work correctly"),
        t({ "", "", "Side Effects:", "---", "- " }),
        i(4, "Updates self.xxx / Publishes to /topic"),
        t({ "", "", "Example call:", "---", "" }),
        f(get_function_name, {}),
        t("("),
        f(get_function_params, {}),
        t({ ")", '"""' }),
        i(0),
    }),

    -- ROS2 callback docstring (specialized for subscription callbacks)
    s("snip-ros-subscription-callback", {
        t({ '"""', "Purpose:", "---", "Callback for " }),
        i(1, "/topic_name"),
        t({ " subscription.", "", "", "Input Arguments:", "---", "" }),
        f(get_function_args_formatted, {}),
        t({ "", "", "Processes:", "---", "" }),
        i(2, "What data is extracted/transformed"),
        t({ "", "", "Updates:", "---", "" }),
        i(3, "self.xxx state variables"),
        t({ "", "", "Publishes:", "---", "" }),
        i(4, "/output_topic or None"),
        t({ "", "", "Assumptions:", "---", "- " }),
        i(5, "Timing/frequency assumptions"),
        t({ "", '"""' }),
        i(0),
    }),

    -- ROS2 timer callback docstring
    s("snip-ros-timer-callback", {
        t({ '"""', "Purpose:", "---", "Timer callback at " }),
        i(1, "10"),
        t({ " Hz.", "", "", "Updates:", "---", "" }),
        i(2, "State variables modified"),
        t({ "", "", "Publishes:", "---", "" }),
        i(3, "/topic (MsgType)"),
        t({ "", "", "Assumptions:", "---", "- " }),
        i(4, "Timing guarantees or drift considerations"),
        t({ "", '"""' }),
        i(0),
    }),

    -- ROS2 service callback docstring (auto-detects args)
    s("snip-ros-service-callback", {
        t({ '"""', "Purpose:", "---", "Service callback for " }),
        i(1, "/service_name"),
        t({ ".", "", "", "Input Arguments:", "---", "" }),
        f(get_function_args_formatted, {}),
        t({ "", "", "Returns:", "---", "`" }),
        f(get_function_return_type, {}),
        t({ "` : Populated response", "", "", "Side Effects:", "---", "- " }),
        i(2, "State changes, if any"),
        t({ "", '"""' }),
        i(0),
    }),
}

return snippets
