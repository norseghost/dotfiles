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
