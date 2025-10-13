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
                local result = vim.fn.systemlist({
                    "pwsh", "-NoLogo", "-Command",
                    "Set-WTFontSize 16 | ConvertTo-Json -Compress"
                })
                local ok, parsed = pcall(vim.json.decode, table.concat(result, ""))
                if ok and parsed and parsed.Old then
                    old_font_size = parsed.Old
                end
            end,

            on_close = function()
                if old_font_size then
                    vim.fn.system({
                        "pwsh", "-NoLogo", "-Command",
                        "Set-WTFontSize " .. tostring(old_font_size)
                    })
                end
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
        { "<leader>zz", function() Snacks.zen() end,            desc = "Zen Mode" },
        { "<leader>zZ", function() Snacks.zen.zoom() end,       desc = "Zoom Mode" }
    }
}
