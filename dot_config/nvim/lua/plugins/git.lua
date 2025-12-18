return {
    {
        "lewis6991/gitsigns.nvim", -- git signcolumn integration
        event = "BufReadPre",
        opts = {
            signs = {
                add = { text = "│" },
                change = { text = "├" },
                delete = { text = "▸" },
                topdelete = { text = "▾", },
                changedelete = { text = "╎", },
            },
            signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
            numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
            linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
            word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = {
                interval = 1000,
                follow_files = true,
            },
            attach_to_untracked = true,
            current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
            -- sign_priority = 20,
            update_debounce = 100,
            status_formatter = nil, -- Use default
            max_file_length = 40000,
            preview_config = {
                -- Options passed to nvim_open_win
                border = "single",
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1,
            },
            on_attach = function(buffer_nr)
                local gitsigns = require("gitsigns")
                -- hunk navigation
                vim.keymap.set("n", "]c", function()
                    if vim.wo.diff then return "]c" end
                    vim.schedule(gitsigns.next_hunk)
                    return "<Ignore>"
                end, { expr = true, silent = true, buffer = buffer_nr, desc = "Go to next hunk" })

                vim.keymap.set("n", "[c", function()
                    if vim.wo.diff then return "[c" end
                    vim.schedule(gitsigns.prev_hunk)
                    return "<Ignore>"
                end, { expr = true, silent = true, buffer = buffer_nr, desc = "Go to previous hunk" })

                -- git actions
                vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, {
                    silent = true, buffer = buffer_nr, desc = "Preview hunk"
                })
                vim.keymap.set("n", "<leader>gt", gitsigns.toggle_deleted, {
                    silent = true, buffer = buffer_nr, desc = "Toggle deleted"
                })
                vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk, {
                    silent = true, buffer = buffer_nr, desc = "Reset hunk"
                })

                vim.keymap.set("n", "<leader>gs", function()
                    gitsigns.stage_hunk()
                    -- vim.schedule(refresh_fugitive)
                end, { silent = true, buffer = buffer_nr, desc = "Stage hunk" })

                vim.keymap.set("n", "<leader>gS", function()
                    gitsigns.stage_buffer()
                    -- vim.schedule(refresh_fugitive)
                end, { silent = true, buffer = buffer_nr, desc = "Stage buffer" })

                vim.keymap.set("n", "<leader>gR", function()
                    gitsigns.reset_buffer()
                    -- vim.schedule(refresh_fugitive)
                end, { silent = true, buffer = buffer_nr, desc = "Undo stage buffer" })

                vim.keymap.set("n", "<leader>gu", function()
                    gitsigns.undo_stage_hunk()
                    -- vim.schedule(refresh_fugitive)
                end, { silent = true, buffer = buffer_nr, desc = "Undo stage hunk" })

                local tb = require("telescope.builtin")
                vim.keymap.set("n", "<leader>gC", tb.git_commits, {
                    silent = true, desc = "Search commits"
                })
                vim.keymap.set("n", "<leader>gb", tb.git_branches, {
                    silent = true, desc = "Search branches"
                })
                -- git blame

                vim.keymap.set("n", "<leader>gB", gitsigns.toggle_current_line_blame, {
                    silent = true, desc = "Line Blame"
                })

                -- visual selection mappings
                vim.keymap.set("v", "<leader>gs", function()
                    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    -- vim.schedule(refresh_fugitive)
                end, { silent = true, buffer = buffer_nr, desc = "Stage hunk" })

                vim.keymap.set("v", "<leader>gu", function()
                    gitsigns.undo_stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    -- vim.schedule(refresh_fugitive)
                end, { silent = true, buffer = buffer_nr, desc = "Undo stage hunk" })

                vim.keymap.set("v", "<leader>gr", function()
                    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { silent = true, buffer = buffer_nr, desc = "Reset hunk" })

                -- text objects
                vim.keymap.set({ "o", "x" }, "ig", gitsigns.select_hunk, {
                    silent = true, buffer = buffer_nr, desc = "Select inside hunk"
                })
                vim.keymap.set({ "o", "x" }, "ag", gitsigns.select_hunk, {
                    silent = true, buffer = buffer_nr, desc = "Select around hunk"
                })
            end
        }
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",  -- required
            "sindrets/diffview.nvim", -- optional - Diff integration

            -- Only one of these is needed, not both.
            "nvim-telescope/telescope.nvim", -- optional
        },
        graph_style = "unicode",
        opts = {
            commit_editor = {
                kind = "floating",
                show_staged_diff = true,
                -- Accepted values:
                -- "split" to show the staged diff below the commit editor
                -- "vsplit" to show it to the right
                -- "split_above" Like :top split
                -- "vsplit_left" like :vsplit, but open to the left
                -- "auto" "vsplit" if window would have 80 cols, otherwise "split"
                staged_diff_split_kind = "split",
                spell_check = true,
            },

        },
        keys = {
            { "<leader>gg", "<cmd>Neogit <cr>",       "Neogit Status" },
            { "<leader>gc", "<cmd>Neogit commit<cr>", "Neogit Commit" },

        }
    }
}
