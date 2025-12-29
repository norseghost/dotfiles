return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        ft = { "markdown", "rmd", "pandoc" },
        opts = {
            -- Automatically handles frontmatter (YAML/TOML/JSON) visually
            code = {
                sign = true,
                width = "block",
                right_pad = 1,
            },
            heading = {
                sign = true,
                icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
            },
            completions = { lsp = { enabled = true } },
        },
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
                    yaml = false,
                    lists = false
                },
                perspective = {
                    priority = "root",
                    root_tell = ".git",
                },
                bib = {
                    default_path = bib_file,
                    find_in_root = true
                },
            })
        end
    },
    {
        "tadmccorkle/markdown.nvim",
        ft = "markdown", -- or 'event = "VeryLazy"'
        opts = {
            on_attach = function(bufnr)
                local map = vim.keymap.set
                local opts = { buffer = bufnr }
                map({ "n", "i" }, "<C-CR>", "<Cmd>MDListItemBelow<CR>", opts)
                map({ "n", "i" }, "<M-C-CR>", "<Cmd>MDListItemAbove<CR>", opts)
                map("n", "<M-c>", "<Cmd>MDTaskToggle<CR>", opts)
                map("x", "<M-c>", ":MDTaskToggle<CR>", opts)
            end,
        },
    }
}
