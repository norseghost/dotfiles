local old_font_size
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
return {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
        dim = {
            -- your dim configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        zen = {
            on_open = function()
                -- Call your PowerShell profile function directly
                if not is_windows then return end
                local result = vim.fn.system({
                    "pwsh", "-NoProfile", "-NoLogo",
                    "-File", "setwtfontsize.ps1",
                    "16"
                })
                local ok, parsed = pcall(vim.json.decode, result)
                if ok and parsed and parsed.Old then
                    old_font_size = parsed.Old
                    vim.notify("Saved old font size: " .. old_font_size)
                else
                    vim.notify("Failed to parse old font size", vim.log.levels.WARN)
                end
            end,

            on_close = function()
                if not is_windows then return end
                if not old_font_size then return end
                vim.fn.system({
                    "pwsh", "-NoProfile", "-NoLogo",
                    "-File", "setwtfontsize.ps1", old_font_size
                })
                vim.notify("Restored font size: " .. old_font_size)
            end,

        },
        statuscolumn = {
            enabled = true,
            -- your statuscolumn configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        notifier = {
            enabled = true,
        },
        scroll = { enabled = true },
    },
    keys = {
        { "<leader>.",  function() Snacks.scratch() end,        desc = "Toggle Scratch Buffer" },
        { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
        { "<leader>zm", function() Snacks.zen() end,            desc = "Zen Mode" },
        { "<leader>zz", function() Snacks.zen.zoom() end,       desc = "Zoom Mode" }
    }
}
