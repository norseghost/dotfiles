return {
    "folke/which-key.nvim", -- key mappings and hints
    -- event = "VeryLazy"
    init = function()
        local nopts = {
            mode = "n",     -- NORMAL mode
            prefix = "<leader>",
            buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true,  -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true,  -- use `nowait` when creating keymaps
        }
        local nmaps = {
            { "<leader>d", group = "Debug",             nowait = true, remap = false },
            { "<leader>g", group = "Git",               nowait = true, remap = false },
            { "<leader>l", group = "LSP",               nowait = true, remap = false },
            { "<leader>p", group = "Plugins",           nowait = true, remap = false },
            { "<leader>s", group = "Search",            nowait = true, remap = false },
            { "<leader>t", group = "Toggle",            nowait = true, remap = false },
            { "<leader>u", group = "Test",              nowait = true, remap = false },
            { "<leader>x", group = "Quickfix/Location", nowait = true, remap = false },
            { "<leader>z", group = "Zettelkasten",      nowait = true, remap = false },
        }
        require "which-key".register(nmaps, nopts)
    end
}
