return {
    "danymat/neogen", -- Generate inline documentation
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
        snippet_engine = "luasnip",
        languages = {
            python = {
                template = {
                    annotation_convention = "numpydoc"
                }
            }
        }
    },
    keys = {
        {
            "<leader>nn",
            function()
                require("neogen").generate({})
            end,
            desc = "Generate Comment",
        },
    },
}
