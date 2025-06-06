local test = {
    "nvim-neotest/neotest",
    event = "BufEnter test*.*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        {
            "nvim-neotest/neotest-python",
        },
    },
    config = function()
        local neotest = require("neotest")

        neotest.setup({
            log_level = vim.log.levels.TRACE,
            adapters = {
                require("neotest-python") {
                    dap = {
                        justMyCode = false,
                        console = "integratedTerminal",
                        args = { "--log-level", "DEBUG" },

                    },
                }
            }
        })
        vim.keymap.set("n", "<leader>uu",
            function() require("neotest").run.run(vim.fn.expand("%")) end,
            { desc = "Run all tests", buffer = true })
        vim.keymap.set("n", "<leader>uy",
            function() require("neotest").summary.toggle() end,
            { desc = "Toggle test summary", buffer = true })
        vim.keymap.set("n", "<leader>ui",
            function() require("neotest").run.run(vim.fn.expand("%"), { strategy = "dap" }) end,
            { desc = "Debug tests", buffer = true })
        vim.keymap.set("n", "<leader>uo",
            function() require("neotest").run.run({ strategy = "dap" }) end,
            { desc = "Debug nearest test", buffer = true })
        vim.keymap.set("n", "<leader>up",
            function() require("neotest").run.stop() end,
            { desc = "Stop test jobs", buffer = true })
        vim.keymap.set("n", "<leader>uh",
            function() require("neotest").run.run() end,
            { desc = "Run nearest test", buffer = true })
        vim.keymap.set("n", "<leader>uj",
            function() require("neotest").run.run_last() end,
            { desc = "Run last test", buffer = true })
        vim.keymap.set("n", "[n",
            function() require("neotest").jump.prev({ status = "failed" }) end,
            { desc = "Previous failed test", silent = true })
        vim.keymap.set("n", "]n",
            function() require("neotest").jump.next({ status = "failed" }) end,
            { desc = "Next failed test", silent = true })
    end,
    -- keys = {
    --     { "<leader>uu",
    --         function() require("neotest").run.run(vim.fn.expand("%")) end,
    --         desc = "Run all tests", buffer = true },
    --     { "<leader>uy",
    --         function() require("neotest").summary.toggle() end,
    --         desc = "Toggle test summary", buffer = true },
    --     { "<leader>ui",
    --         function() require("neotest").run.run(vim.fn.expand("%"), { strategy = "dap" }) end,
    --         desc = "Debug tests", buffer = true },
    --     { "<leader>uo",
    --         function() require("neotest").run.run({ strategy = "dap" }) end,
    --         desc = "Debug nearest test", buffer = true },
    --     { "<leader>up",
    --         function() require("neotest").run.stop() end,
    --         desc = "Stop test jobs", buffer = true },
    --     { "<leader>uh",
    --         function() require("neotest").run.run() end,
    --         desc = "Run nearest test", buffer = true },
    --     { "<leader>uj",
    --         function() require("neotest").run.run_last() end,
    --         desc = "Run last test", buffer = true },
    --     { "[n",
    --         function() require("neotest").jump.prev({ status = "failed" }) end,
    --         desc = "Previous failed test", silent = true },
    --     { "]n",
    --         function() require("neotest").jump.next({ status = "failed" }) end,
    --         desc = "Next failed test", silent = true },
    --
    -- }
}
return {}
