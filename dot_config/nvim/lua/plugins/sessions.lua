return {
    "olimorris/persisted.nvim",
    event = "VeryLazy",
    config = function()
        require("persisted").setup({
            autoload = true,
            -- Resolves to ~/.local/share/nvim/sessions/
            save_dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
            use_git_branch = true,
            branch_separator = "_",
        })
        require("telescope").load_extension("persisted")
        vim.keymap.set("n", "<leader>ss", "<cmd>Telescope persisted<cr>", { desc = "Search Sessions" })
        vim.keymap.set("n", "<leader>tS", "<cmd>SessionToggle<cr>", { desc = "Toggle Sessions" })
    end
}
