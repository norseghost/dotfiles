local jupyter = {
    {
        "GCBallesteros/NotebookNavigator.nvim",
        keys = {
            { "]h",        function() require("notebook-navigator").move_cell "d" end },
            { "[h",        function() require("notebook-navigator").move_cell "u" end },
            { "<leader>X", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
            { "<leader>x", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
        },
        dependencies = {
            "echasnovski/mini.comment",
            "hkupty/iron.nvim",
            "anuvyklack/hydra.nvim",
        },
        ft = "ipynb",
        config = function()
            local nn = require "notebook-navigator"
            local ai = require "mini.ai"
            nn.setup({ activate_hydra_keys = "<leader>h" })
            ai.setup(
                {
                    custom_textobjects = {
                        h = nn.miniai_spec,
                    },
                }
            )
        end,
    },
    {
        "lkhphuc/jupyter-kernel.nvim",
        opts = {
            inspect = {
                -- opts for vim.lsp.util.open_floating_preview
                window = {
                    max_width = 84,
                },
            },
            -- time to wait for kernel's response in seconds
            timeout = 0.5,
        },
        cmd = { "JupyterAttach", "JupyterInspect", "JupyterExecute" },
        build = ":UpdateRemotePlugins",
        keys = { { "<leader>k", "<Cmd>JupyterInspect<CR>", desc = "Inspect object in kernel" } },
    },
    {
        "quarto-dev/quarto-nvim",
        dev = false,
        ft = "quarto",
        dependencies = {
            { "hrsh7th/nvim-cmp" },
            {
                "jmbuhr/otter.nvim",
                dev = false,
            },
            {
                "quarto-dev/quarto-vim",
                ft = "quarto",
                dependencies = { "vim-pandoc/vim-pandoc-syntax" },
                -- note: needs additional syntax highlighting enabled for markdown
                --       in `nvim-treesitter`
                config = function()
                    -- see `:h conceallevel`
                    vim.opt.conceallevel = 1

                    -- disable conceal in markdown/quarto
                    vim.g["pandoc#syntax#conceal#use"] = false

                    -- embeds are already handled by treesitter injectons
                    vim.g["pandoc#syntax#codeblocks#embeds#use"] = false
                    vim.g["pandoc#syntax#conceal#blacklist"] = { "codeblock_delim", "codeblock_start" }

                    -- but allow some types of conceal in math regions:
                    -- see `:h g:tex_conceal`
                    vim.g["tex_conceal"] = "gm"
                end
            },

        },
        opts = {
            closePreviewOnExit = true,
            lspFeatures = {
                enabled = true,
                chunks = "curly",
                languages = { "r", "python", "julia", "bash", "lua", "html" },
                diagnostics = {
                    enabled = true,
                    triggers = { "BufWritePost" }
                },
                completion = {
                    enabled = true,
                },
            },
            keymap = {
                hover = "K",
                definition = "gd",
                rename = "<leader>lR",
                references = "gr",
            },
        }
    },
}

return {}
