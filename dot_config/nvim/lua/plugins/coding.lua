local coding = {
    {
        "folke/trouble.nvim",
        opts = {
            position = "bottom",
            use_diagnostic_signs = true
        },
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Document Diagnostics" },
            { "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Workspace Diagnostics" },
            { "<leader>xt", "<cmd>Trouble todo<cr>",                            desc = "Troublesome TODOs" },
            { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                   desc = "Quickfix Trouble" },
            { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                  desc = "Location List Trouble" },
        },
        init = function()
            local trouble_grp = vim.api.nvim_create_augroup("trouble", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "Trouble",
                callback = function()
                    vim.wo.colorcolumn = ""
                end,
                group = trouble_grp
            })
        end
    },
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        event = "BufReadPost",
        keys = {
            { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
            { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },

        },
        config = true,
    },
    {
        "mcauley-penney/tidy.nvim", -- clear trailing whitespace and empty lines
        config = true,
        event = "InsertLeave"
    },
    {
        "rafcamlet/nvim-luapad", -- interactive neovim-lua REPL
        ft = "lua"
    },
    {
        "lambdalisue/suda.vim", -- save files owned by others
        event = "BufReadPre",
        config = function()
            vim.g.suda_smart_edit = 1
            vim.keymap.set("n", "<leader>W", "<cmd>SudaWrite<CR>", { desc = "Save as root" })
        end
    },

    -- better increase/decrease
    {
        "monaqa/dial.nvim",
        keys = {
            { "<C-a>",  function() return require("dial.map").inc_normal() end,  expr = true, desc = "Increment" },
            { "<C-x>",  function() return require("dial.map").dec_normal() end,  expr = true, desc = "Decrement" },
            { "g<C-a>", function() return require("dial.map").inc_gnormal() end, expr = true, desc = "Increment" },
            { "g<C-x>", function() return require("dial.map").dec_gnormal() end, expr = true, desc = "Decrement" },
            -- { "<C-a>", function() return require("dial.map").inc_visual() end, "v", expr = true, desc = "Increment" },
            -- { "<C-x>", function() return require("dial.map").dec_visual() end, "v", expr = true, desc = "Decrement" },
            -- { "g<C-a>", function() return require("dial.map").inc_gvisual() end, "v", expr = true, desc = "Increment" },
            -- { "g<C-x>", function() return require("dial.map").dec_gvisual() end, "v", expr = true, desc = "Decrement" },
        },
        config = function()
            local augend = require("dial.augend")
            require("dial.config").augends:register_group({
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.hex,
                    augend.date.alias["%Y/%m/%d"],
                    augend.constant.alias.bool,
                    augend.semver.alias.semver,
                },
            })
        end,
    },
    { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },

}
return coding
