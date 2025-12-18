return {
    "neovim/nvim-lspconfig", -- language server configurations
    -- event = "BufReadPre",
    dependencies = {
        "folke/neodev.nvim",
        "b0o/schemastore.nvim", -- json schemas for jsonls
    },
}
-- return {}
