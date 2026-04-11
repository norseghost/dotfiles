return {
    "mickael-menu/zk-nvim", -- zettelkasten notes
    keys = {
        { "<leader>zc", "<cmd>ZkNew<CR>", desc = "New note" },
        { "<leader>zc", "<cmd>ZkNew<CR>", mode = "x", desc = "New note from selection" },
        { "<leader>zn", "<cmd>ZkNotes<CR>", desc = "List notes" },
        { "<leader>zb", "<cmd>ZkBacklinks<cr>", desc = "Show backlinks" },
        { "<leader>zl", "<cmd>ZkLinks<CR>", desc = "Show links" },
        { "<leader>zt", "<cmd>ZkTags<CR>", desc = "Search tags" }
    },
    config = function()
        require("zk").setup()
    end
}
