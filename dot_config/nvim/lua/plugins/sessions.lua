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
        local group = vim.api.nvim_create_augroup("PersistedHooks", {})

        vim.api.nvim_create_autocmd({ "User" }, {
            pattern = "PersistedSavePre",
            group = group,
            callback = function()
                vim.cmd("bw fugitive Trouble")
            end,
        })
        vim.api.nvim_create_autocmd({ "User" }, {
            pattern = "PersistedLoadPre",
            group = group,
            callback = function()
                vim.lsp.stop_client(vim.lsp.get_active_clients())
                vim.cmd("edit")
            end,
        })
        vim.api.nvim_create_autocmd({ "User" }, {
            pattern = "PersistedTelescopeLoadPre",
            group = group,
            callback = function()
                vim.cmd("bufdo bwipeout")
            end,
        })
        vim.api.nvim_create_autocmd({ "User" }, {
            pattern = "PersistedTelescopeLoadPost",
            group = group,
            callback = function(session)
                pcall(vim.cmd, "git checkout " .. session.branch)
            end,
        })


        require("telescope").load_extension("persisted")
        vim.keymap.set("n", "<leader>ss", "<cmd>Telescope persisted<cr>", { desc = "Search Sessions" })
        vim.keymap.set("n", "<leader>tS", "<cmd>SessionToggle<cr>", { desc = "Toggle Sessions" })
    end
}
