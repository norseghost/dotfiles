local lsps = {
    "lua_ls",
    "bashls",
    "basics_ls",
    "clangd",
    "marksman",
    "pylsp",
    "yamlls",
    "codebook",
    "harper_ls"
}

return {
    {
        "mason-org/mason-lspconfig.nvim",
        event        = "VeryLazy",
        opts         = {
            ensure_installed = lsps
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            {
                "neovim/nvim-lspconfig",
                dependencies = {
                    "folke/neodev.nvim",
                    "b0o/schemastore.nvim", -- json schemas for jsonls
                },
            },
        },
    },
}
