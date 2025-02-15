return {
    "yorik1984/jekyll.nvim",
    {
        dir = "~/Dev/nvimwordlist/",
        build = function()
            require("nvimwordlist").update_spell_file()
        end,
        config = function()
            vim.opt.spelllang:append("vim")
        end,
        event = "VeryLazy"
    },
    {
        "norseghost/vim-dirtytalk",
        build  = ":DirtytalkUpdate",
        config = function()
            vim.opt.spelllang:append("code")
        end,
        event  = "VeryLazy",
    },
    "folke/twilight.nvim",     -- focus current line when writing
    {
        "folke/zen-mode.nvim", -- distraction-free writing
        opts = {
            window = {
                backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
                -- height and width can be:
                -- * an absolute number of cells when > 1
                -- * a percentage of the width / height of the editor when <= 1
                -- * a function that returns the width or the height
                width = 84, -- width of the Zen window
                height = 1, -- height of the Zen window
                -- by default, no options are changed for the Zen window
                -- uncomment any of the options below, or add other vim.wo options you want to apply
                options = {
                    signcolumn = "no",      -- disable signcolumn
                    number = false,         -- disable number column
                    relativenumber = false, -- disable relative numbers
                    cursorline = true,      -- disable cursorline
                    cursorcolumn = false,   -- disable cursor column
                    foldcolumn = "0",       -- disable fold column
                    list = false,           -- disable whitespace characters
                },
            },
            plugins = {
                -- disable some global vim options (vim.o...)
                -- comment the lines to not apply the options
                options = {
                    enabled = true,
                    ruler = false,              -- disables the ruler text in the cmd line area
                    showcmd = false,            -- disables the command in the last line of the screen
                },
                twilight = { enabled = true },  -- enable to start Twilight when zen mode opens
                gitsigns = { enabled = false }, -- disables git signs
                tmux = { enabled = true },      -- disables the tmux statusline
                -- this will change the font size on kitty when in zen mode
                -- to make this work, you need to set the following kitty options:
                -- - allow_remote_control socket-only
                -- - listen_on unix:/tmp/kitty
                kitty = {
                    enabled = true,
                    font = "+4", -- font size increment
                },
            },
            -- callback where you can add custom code when the Zen window opens
            on_open = function(win)
            end,
            -- callback where you can add custom code when the Zen window closes
            on_close = function()
            end,
        },
        keys = {
            { "<leader>Z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
        }
    },
    {
        "gbprod/yanky.nvim",
        dependencies = {
            "kkharji/sqlite.lua",
            enabled = function()
                return not jit.os:find("Windows")
            end,
        },
        event = "BufReadPost",
        config = function()
            require("yanky").setup({
                highlight = {
                    timer = 150,
                },
                ring = {
                    storage = jit.os:find("Windows") and "shada" or "sqlite",
                },
            })

            vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")

            vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
            vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
            vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
            vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

            vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
            vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")

            vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
            vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
            vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
            vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

            vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
            vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
            vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
            vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

            vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
            vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)")

            vim.keymap.set("n", "<leader>P", function()
                require("telescope").extensions.yank_history.yank_history({})
            end, { desc = "Paste from Yanky" })
        end,
    },
}
