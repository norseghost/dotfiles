return {
    "neovim/nvim-lspconfig", -- language server configurations
    event = "BufReadPre",
    dependencies = {
        "folke/neodev.nvim", -- neovim lua bindings
        "hrsh7th/cmp-nvim-lsp",
        {
            "lukas-reineke/lsp-format.nvim",
            config = true
        },
        "folke/lsp-colors.nvim", -- add missing LSP highlight groups
        {
            "williamboman/mason.nvim",
            dependencies = {
                "williamboman/mason-lspconfig",
            },
            config = function()
                require("plugins.lsp.mason")
            end
        },                      -- automatically install needed servers
        "b0o/schemastore.nvim", -- json schemas for jsonls
        {
            "SmiteshP/nvim-navic",
            config = function()
                vim.g.navic_silence = true
                require("nvim-navic").setup({ separator = " ", highlight = true, depth_limit = 5 })
            end,
        },
        --[[         {
        "jason0x43/nvim-navic",
        branch = "symbolinformation-support"
        }, ]]
    },
    config = function()
        require("plugins.lsp.handlers").setup()
        -- vim.lsp.set_log_level("debug")
    end
}
