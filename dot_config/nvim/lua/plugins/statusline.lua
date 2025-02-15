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

local navic = function()
    local status_navic_ok, navic = pcall(require, "nvim-navic")
    if not status_navic_ok then
        return
    end

    return navic.get_location({ highlight = false })
end

local filetype = {
    "filetype",
    colored = false,
    icon_only = false
}

local debug = function()
    local dap = require("dap")
    if dap.status() ~= nil then
        return dap.status()
    end
end

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
    }
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
    }, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )

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
    return vim.api.nvim_buf_get_option(0, "shiftwidth")
end

return {
    {
        "nanozuki/tabby.nvim",
        -- event = 'VimEnter', -- if you want lazy load, see below
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            preset = "tab_only"
        end,
    },
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
                    "alpha",
                    "dashboard",
                    "NvimTree",
                    "Outline",
                    "Trouble",
                    statusline = {},
                    winbar = {}
                },
                always_divide_middle = true,
                globalstatus = true,
            },
            sections = {
                lualine_a = { mode },
                lualine_b = { branch, workspace_diagnostics },
                lualine_c = { filename },
                -- lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_x = { diff, persisting, debug, filetype },
                lualine_y = { spaces, linewrap },
                lualine_z = { location, progress },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = { location },
                lualine_y = {},
                lualine_z = {},
            },
            -- tabline = {
            --     lualine_a = { "tabs" },
            --     lualine_b = { "windows" },
            --     -- lualine_c = {},
            --     -- lualine_x = {},
            --     lualine_y = {},
            --     lualine_z = {}
            -- },
            winbar = {
                lualine_b = {
                    diagnostics
                },
                lualine_c = {
                    filename,
                    navic
                },
                lualine_x = {},
                lualine_y = { spelling },
                lualine_z = { "searchcount" }
            },

            inactive_winbar = {
                lualine_a = {},
                lualine_b = { {
                    "filename",
                    file_status = true
                } },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },
            extensions = {
                "quickfix",
                "fugitive",
                "nvim-dap-ui"
            },
        }
    },
    {
        "luukvbaal/statuscol.nvim",
        config = function()
            -- local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                -- configuration goes here, for example:
                -- relculright = true,
                -- segments = {
                --   { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                --   {
                --     sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
                --     click = "v:lua.ScSa"
                --   },
                --   { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
                --   {
                --     sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true },
                --     click = "v:lua.ScSa"
                --   },
                -- }
            })
        end
    }
}
