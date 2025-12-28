return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        ft = { "markdown", "rmd", "pandoc" },
        opts = {
            -- Automatically handles frontmatter (YAML/TOML/JSON) visually
            code = {
                sign = false,
                width = "block",
                right_pad = 1,
            },
            heading = {
                sign = false,
                icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
            },
        },
    },

    {
        "ellisonleao/glow.nvim",
        cmd = "Glow",
        config = true,
        keys = { { "<leader>mp", "<cmd>Glow<cr>", desc = "Markdown Preview" } },
    },

    {
        "jakewvincent/mkdnflow.nvim",
        ft = { "markdown", "md" },
        config = function()
            local bib_file = "_bibliography/references.bib"
            -- Only enable bib module if the file actually exists
            local has_bib = vim.fn.filereadable(vim.fn.getcwd() .. "/" .. bib_file) == 1

            require("mkdnflow").setup({
                modules = {
                    bib = has_bib,
                    yaml = true,
                    lists = true,
                },
                bib = {
                    default_path = bib_file,
                    find_in_root = true
                },
                -- Use native-friendly mappings
                mappings = {
                    MkdnEnter = {{'i', 'n', 'v'}, '<CR>'},
                    MkdnNextLink = {'n ', '<Tab>'},
                }
            })
        end
    }
}
