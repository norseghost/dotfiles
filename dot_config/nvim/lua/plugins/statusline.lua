local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end
local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed
        }
    end
end

local workspace_diagnostics = {
    "diagnostics",
    sources = { "nvim_workspace_diagnostic" },
    sections = { "error", "warn", "info" },
    symbols = { error = " ", warn = " ", info = "", hint = "" },
    colored = false,
    update_in_insert = false,
    always_visible = false,
}

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn", "info" },
    symbols = { error = " ", warn = " ", info = "", hint = "" },
    colored = false,
    update_in_insert = false,
    always_visible = false,
}

local diff = {
    "diff",
    source = diff_source,
    colored = false,
    symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
    cond = hide_in_width
}

local mode = {
    "mode",
    fmt = function(str)
        return str:sub(1, 1)
    end,
}

local nav = function()
    local ts_nav = require("nvim-treesitter").statusline({
        separator = "  ",
        type_patterns = {
            "class",
            "function",
            "method",
            "import",
            "for",
            "if",
            "while",
            "variable",
            "comment",
        },

    })
    local buf = vim.api.nvim_get_current_buf()
    local highlighter = require "vim.treesitter.highlighter"
    if highlighter.active[buf] then
        -- treesitter highlighting is enabled
        return ts_nav
    else
        return ""
    end
end

local filetype = {
    "filetype",
    colored = false,
    icon_only = false
}
--
-- local debug = function()
--     local dap = require("day")
--     if day.status() ~= nil then
--         return day.status()
--     end
-- end

local persisting = function()
    if vim.g.persisting then
        return " "
    elseif vim.g.persisting == false then
        return " "
    end
end

local branch = { "b:gitsigns_head", icon = "" }

local location = {
    "location",
    -- padding = 0
}

local filename = {
    "filename",
    symbols = {
        modified = " ⚡", -- Text to show when the file is modified.
        readonly = " ", -- Text to show when the file is non-modifiable or read only.
        unnamed = " ", -- Text to show for unnamed buffers.
    },
    path = 4,
}

-- cool function for progress
local progress = function()
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
end

local spelling = function()
    if vim.o.spell then
        return "暈 " .. vim.bo.spelllang
    else
        return ""
    end
end
local buffers = {
    "buffers",
    show_filename_only = false,      -- Shows shortened relative path when set to false.
    hide_filename_extension = false, -- Hide filename extension when set to true.
    show_modified_status = true,     -- Shows indicator when the buffer is modified.

    mode = 0,                        -- 0: Shows buffer name
    -- 1: Shows buffer index
    -- 2: Shows buffer name + buffer index
    -- 3: Shows buffer number
    -- 4: Shows buffer name + buffer number

    max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
    -- it can also be a function that returns
    -- the value of `max_length` dynamically.
    filetype_names = {
        TelescopePrompt = "Telescope",
        dashboard = "Dashboard",
        packer = "Packer",
        fzf = "FZF",
        alpha = "Alpha"
    }, -- Shows specific buffer name for that file type ( { `file type` = `buffer_name`, ... } )

    buffers_color = {
        -- Same values as the general color option can be used here.
        active = "lualine_{section}_normal",     -- Color for active buffer.
        inactive = "lualine_{section}_inactive", -- Color for inactive buffer.
    },

    symbols = {
        modified = " ●", -- Text to show when the buffer is modified
        alternate_file = "#", -- Text to show to identify the alternate file
        directory = "", -- Text to show when the buffer is a directory
    },
}
local function linewrap()
    if vim.wo.wrap then
        return ""
    else
        return "ﯖ"
    end
end

local spaces = function()
    return vim.bo.shiftwidth()
end

return {
    { -- status line
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                icons_enabled = true,
                theme = "nord",
                -- component_separators = { left = "", right = "" },
                -- section_separators = { left = "", right = "" },
                disabled_filetypes = {
                    "Outline",
                    "Trouble",
                    statusline = {},
                    winbar = {}
                },
                always_divide_middle = true,
                globalstatus = true,
            },
            extensions = {
                "quickfix",
                "trouble",
                "lazy"
            },
            sections = {
                lualine_a = { mode },
                lualine_b = { branch, workspace_diagnostics },
                lualine_c = { filename },
                -- lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_x = { diff, filetype },
                lualine_y = { spaces, linewrap },
                lualine_z = { location, progress },
            },
            inactive_sections = {
                -- lualine_a = {},
                -- lualine_b = {},
                -- lualine_c = {},
                lualine_x = { location },
                -- lualine_y = {},
                -- lualine_z = {},
            },
            tabline = {
                lualine_a = { "tabs" },
                lualine_b = { "windows" },
                -- lualine_c = {},
                -- lualine_x = {},
                -- lualine_y = {},
                -- lualine_z = {}
            },
            winbar = {
                -- lualine_a = {},
                lualine_b = { filename },
                lualine_c = { nav },
                -- lualine_x = {},
                -- lualine_y = {},
                -- lualine_z = {}
            },
            inactive_winbar = {
                -- lualine_a = {},
                lualine_b = { filename },
                -- lualine_c = {},
                -- lualine_x = {},
                -- lualine_y = {},
                -- lualine_z = {}
            },
        }
    }
}
