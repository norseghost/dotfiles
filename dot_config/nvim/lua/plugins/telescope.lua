return {
    "nvim-telescope/telescope.nvim", -- fuzzy finder
    dependencies = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim", -- compiled finder, fzf syntax
            build = "make",
        },
    },
    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
            defaults = {
                layout_strategy = "flex",
                layout_config = {
                    flex = {
                        flip_columns = 120,
                    },
                },
                prompt_prefix = " ",
                selection_caret = " ",
                path_display = { "smart" },
                mappings = {
                    i = {
                        ["<esc>"] = actions.close
                    },
                },
            },
            pickers = {
                buffers = {
                    previewer = false,
                    theme = "cursor",
                    ignore_current_buffer = true,
                    sort_lastused = true
                },
                live_grep = {
                    theme = "ivy"
                },
                current_buffer_fuzzy_find = {
                    theme = "ivy",
                    previewer = false
                }

                -- Default configuration for builtin pickers goes here:
                -- picker_name = {
                --   picker_config_key = value,
                --   ...
                -- }
                -- Now the picker_config_key will be applied every time you call this
                -- builtin picker
            },
            extensions = {
                dap = {
                    theme = "cursor"
                }
                -- Your extension configuration goes here:
                -- extension_name = {
                --   extension_config_key = value,
                -- }
                -- please take a look at the readme of the extension you want to configure
            },
        })
    end,
    keys = {
        { "<leader>b", function()
            require("telescope.builtin").buffers()
        end, desc = "Buffers" },
        { "<leader>/", function()
            require("telescope.builtin").current_buffer_fuzzy_find()
        end,
            desc = "Find Text in Buffer"
        },
        { "<leader>f", function()
            require("telescope.builtin").find_files()
        end, desc = "Find Files" },
        { "<leader>F", function()
            require("telescope.builtin").live_grep()
        end, desc = "Find Text" },

        { "<leader>gb", function()
            require("telescope.builtin").git_branches()
        end, desc = "Checkout branch" },
        { "<leader>sh", function()
            require("telescope.builtin").help_tags()
        end, desc = "Search Help" },
        { "<leader>sM", function()
            require("telescope.builtin").man_pages()
        end, desc = "Man Pages" },
        { "<leader>sr", function()
            require("telescope.builtin").oldfiles()
        end, desc = "Open Recent File" },
        { "<leader>sR", function()
            require("telescope.builtin").registers()
        end, desc = "Search Registers" },
        { "<leader>sk", function()
            require("telescope.builtin").keymaps()
        end, desc = "Search Keymaps" },
        { "<leader>sC", function()
            require("telescope.builtin").commands()
        end, desc = "Search Commands" },
    }
}
