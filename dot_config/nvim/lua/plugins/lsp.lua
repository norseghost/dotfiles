local lsps = {
    "bashls",
    "basics_ls",
    "marksman",
    "yamlls",
    "pylsp",
}
local no_termux_lsps = {
    "lua_ls",
    "clangd",
    "codebook",
    "harper_ls"
}
if not IS_TERMUX then
    vim.list_extend(lsps, no_termux_lsps)
end

return {
    {
        "chaneyzorn/spellwand.nvim",
        init = function()
            vim.lsp.enable("spellwand")
        end,
    },

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
