return {
    {
        "tadmccorkle/markdown.nvim",
        branch = "master",
        require = { "godlygeek/tabular" },
        dependencies = {
            "vim-pandoc/vim-pandoc-syntax",
            "vim-pandoc/vim-pandoc",
            {
                "ellisonleao/glow.nvim", -- inline preview of rendered markdown
                keys = { "<leader>mp", "<cmd>Glow<cr>", desc = "Markdown Preview" },
            }
        },
        ft = {
            "markdown",
            "md",
            "rmd",
            "Rmd",
            "pandoc"
        },
        config = function()
            vim.cmd([[
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
        ]]
            )
        end
    },
    -- {
    --     "jakewvincent/mkdnflow.nvim",
    --     config = function()
    --         require("mkdnflow").setup({
    --             modules = {
    --                 yaml = true,
    --                 cmp = true,
    --                 bib = false,
    --             },
    --             perspective = {
    --                 priority = "root",
    --                 fallback = "current",
    --                 root_tell = ".git",
    --                 nvim_wd_heel = false,
    --                 update = true
    --             },
    --             bib = {
    --                 default_path = "_bibliography/references.bib",
    --                 find_in_root = true
    --             },
    --             yaml = {
    --                 bib = { override = true }
    --             },
    --             mappings = {
    --                 MkdnFoldSection = { "n", "<leader>tf" },
    --                 MkdnUnfoldSection = { "n", "<leader>tF" }
    --             }
    --         })
    --     end,
    --     ft = {
    --         "markdown", "rmd", "md"
    --     }
    -- },
    -- {
    --     "jubnzv/mdeval.nvim",
    --     config = function()
    --         require("mdeval").setup(
    --         )
    --     end,
    --     keys = {
    --         { "<leader>mc", "<cmd>lua require 'mdeval'.eval_code_block()<CR>", desc = "Evaluate Code" },
    --     },
    -- }
}
