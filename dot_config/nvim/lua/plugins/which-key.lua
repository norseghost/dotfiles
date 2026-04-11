return {
    "folke/which-key.nvim", -- key mappings and hints
    event = "VeryLazy",
    opts = {
        spec = {
            -- { "<leader>d", group = "Debug",             nowait = true, remap = false },
            { "<leader>", group = "Git",               nowait = true, remap = false },
            { "<leader>", group = "Plugins",           nowait = true, remap = false },
            { "<leader>", group = "Search",            nowait = true, remap = false },
            { "<leader>", group = "Toggle",            nowait = true, remap = false },
            -- { "<leader>u", group = "Test",              nowait = true, remap = false },
            { "<leader>", group = "Quickfix/Location", nowait = true, remap = false },
            { "<leader>", group = "Zettelkasten",      nowait = true, remap = false },

        }
    },
}
