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
                mappings = {
                    MkdnEnter = false,
                    MkdnTab = false,
                    MkdnSTab = false,
                    MkdnNextLink = { "n", "<Tab>" },
                    MkdnPrevLink = { "n", "<S-Tab>" },
                    MkdnNextHeading = { "n", "]]" },
                    MkdnPrevHeading = { "n", "[[" },
                    MkdnGoBack = { "n", "<BS>" },
                    MkdnGoForward = { "n", "<Del>" },
                    MkdnCreateLink = true,                                       -- see MkdnEnter
                    MkdnCreateLinkFromClipboard = { { "n", "v" }, "<leader>p" }, -- see MkdnEnter
                    MkdnFollowLink = false,                                      -- see MkdnEnter
                    MkdnDestroyLink = { "n", "<M-CR>" },
                    MkdnTagSpan = { "v", "<M-CR>" },
                    MkdnMoveSource = { "n", "<F2>" },
                    MkdnYankAnchorLink = { "n", "yaa" },
                    MkdnYankFileAnchorLink = { "n", "yfa" },
                    MkdnIncreaseHeading = { "n", "C-a" },
                    MkdnDecreaseHeading = { "n", "C-x" },
                    MkdnToggleToDo = { { "n", "v" }, "<C-Space>" },
                    MkdnNewListItem = false,
                    MkdnNewListItemBelowInsert = { "n", "o" },
                    MkdnNewListItemAboveInsert = { "n", "O" },
                    MkdnExtendList = false,
                    MkdnUpdateNumbering = { "n", "<leader>nn" },
                    MkdnTableNextCell = { "i", "<Tab>" },
                    MkdnTablePrevCell = { "i", "<S-Tab>" },
                    MkdnTableNextRow = false,
                    MkdnTablePrevRow = { "i", "<M-CR>" },
                    MkdnTableNewRowBelow = { "n", "<leader>ir" },
                    MkdnTableNewRowAbove = { "n", "<leader>iR" },
                    MkdnTableNewColAfter = { "n", "<leader>ic" },
                    MkdnTableNewColBefore = { "n", "<leader>iC" },
                    MkdnFoldSection = false,
                    MkdnUnfoldSection = false
                }
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
