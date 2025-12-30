local sessions = {
    "olimorris/persisted.nvim",
    event = "BufReadPre",
    opts = {
        autostart = true,
        autoload = true,
        on_autoload_no_session = function()
            vim.notify("No existing session to load.")
        end,
        -- Resolves to ~/.local/share/nvim/sessions/
        save_dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
        use_git_branch = true,
        branch_separator = "_",
    },
    keys = {
        { "<leader>tS", "<cmd>SessionToggle<cr>", desc = "Toggle Sessions" },
        { "<leader>ss", "<cmd>SessionSelect<cr>", desc = "Search Sessions" }
    },
}

return sessions
