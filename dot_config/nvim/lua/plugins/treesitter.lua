return {
    "nvim-treesitter/nvim-treesitter", -- context aware syntax tree
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects", -- additional text objects
        "JoosepAlviste/nvim-ts-context-commentstring", -- treesitter aware comment string
        "lewis6991/spellsitter.nvim", -- treesitter enabled spell check where it makes sense
        "andymass/vim-matchup", -- better matching of keywords and blocks
    },
    build = ":TSUpdate",
    event = "BufReadPost",
    opts = {
        ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
        ignore_install = { "" }, -- List of parsers to ignore installing
        autopairs = {
            enable = true,
        },
        matchup = {
            enable = true, -- mandatory, false will disable the whole extension
        },
        highlight = {
            enable = true, -- false will disable the whole extension
            -- disable = { "beancount" }, -- list of language that will be disabled
            additional_vim_regex_highlighting = { "markdown" },
        },
        indent = {
            enable = true,
            -- disable = { "python", "yaml" }
        },
        context_commentstring = {
            enable = true,
            enable_autocmd = false,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "gnn",
                node_incremental = "grn",
                scope_incremental = "grc",
                node_decremental = "grm",
            },
        },
        textobjects = {
            -- TODO` do I need this? really need to figure out better mappings`
            select = {
                enable = true,
                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    ["]m"] = "@function.outer",
                    ["]]"] = "@class.outer",
                },
                goto_next_end = {
                    ["]M"] = "@function.outer",
                    ["]["] = "@class.outer",
                },
                goto_previous_start = {
                    ["[m"] = "@function.outer",
                    ["[["] = "@class.outer",
                },
                goto_previous_end = {
                    ["[M"] = "@function.outer",
                    ["[]"] = "@class.outer",
                },
            },
        },
    },
    init = function()
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end
}
