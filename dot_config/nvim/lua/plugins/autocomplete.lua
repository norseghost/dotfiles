local cmp = {
    "hrsh7th/nvim-cmp", -- autocompletion engine
    event = "InsertEnter",
    dependencies = {
        {
            "onsails/lspkind-nvim", -- fancy icons for LSP types
            config = function()
                require("lspkind").init()
            end,
        },
        "hrsh7th/cmp-buffer",                  -- buffer completion source
        "hrsh7th/cmp-path",                    -- filesystem completion source
        "f3fora/cmp-spell",                    -- spellsuggest completions
        "hrsh7th/cmp-cmdline",                 -- cmp autocomplete in the vim command prompt
        "dmitmel/cmp-cmdline-history",         -- cmp autocomplete in the vim command prompt
        "hrsh7th/cmp-nvim-lsp-signature-help", -- show function signatures and parameter help
        -- {
        --     dir = "~/Dev/zotex.nvim",
        --     config = function() require("zotex").setup {
        --             path = "~/.local/share/zotero/zotero.sqlite",
        --         }
        --     end,
        --     requires = { "kkharji/sqlite.lua" },
        -- },sync.lua:142: attempt to get length of local 'prev_line' (a nil value)
        -- "jc-doyle/cmp-pandoc-references", -- pandoc bibliography and references completion
        {
            "aspeddro/cmp-pandoc.nvim", -- pandoc completions (crossref, bibliography)
            dependencies = {
                "nvim-lua/plenary.nvim",
                "jbyuki/nabla.nvim" -- optional
            },
            config = {
                crossref = {
                    enable_nabla = true
                }
            }
        },
        "crispgm/cmp-beancount", -- Beancount account name completion
        {
            "L3MON4D3/LuaSnip",
            dependencies = {
                "saadparwaiz1/cmp_luasnip",
                "rafamadriz/friendly-snippets",
            },
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
                require("luasnip.loaders.from_lua").lazy_load()
            end
        }
    },
    config = function()
        local cmp = require("cmp")
        local compare = cmp.config.compare
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")
        cmp.setup({
            enabled = function()
                -- disable completion in comments
                local context = require "cmp.config.context"
                -- keep command mode completion enabled when cursor is in a comment
                if vim.api.nvim_get_mode().mode == "c" then
                    return true
                else
                    return not context.in_treesitter_capture("comment")
                        and not context.in_syntax_group("Comment")
                end
            end,
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete_common_string(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<C-k>"] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                },
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            matching = {
                disallow_fuzzy_matching = true,
                disallow_fullfuzzy_matching = true,
                disallow_partial_fuzzy_matching = true,
                disallow_partial_matching = false,
                disallow_prefix_unmatching = true,
            },
            formatting = {
                expandable_indicator = true,
                fields = {
                    cmp.ItemField.Kind,
                    cmp.ItemField.Abbr,
                    cmp.ItemField.Menu,
                },
                format = lspkind.cmp_format({
                    mode = "symbol",
                    maxwidth = 35,
                    before = function(entry, vim_item)
                        if entry.source.name == "nvim_lsp" then
                            vim_item.menu = entry.source.source.client.name
                        else
                            vim_item.menu = ({
                                luasnip = "snip",
                                rg = "buf",
                                path = "path",
                                spell = "spell",
                                pandoc_references = "ref"
                            })[entry.source.name]
                        end
                        return vim_item
                    end,
                }),
            },
            preselect = cmp.PreselectMode.Item,
            sorting = {
                comparators = {
                    compare.offset,
                    compare.exact,
                    compare.score,
                    compare.recently_used,
                    compare.kind,
                },
                priority_weight = 2
            },
            sources = {
                { name = "nvim_lsp_signature_help" },
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "jupyter" },
                { name = "mkdnflow", },
                { name = "spell",                  keyword_length = 3, max_item_count = 10, keyword_pattern = [[\w\+]] },
                { name = "buffer",                 keyword_length = 4, max_item_count = 5,  keyword_pattern = [[\w\+]] },
                { name = "path",                   max_item_count = 10 },
            },
            cmp.setup.filetype("beancount", {
                sources = {
                    cmp.config.sources {
                        { name = "beancount",
                            option = {
                                account = "~/Documents/Finances/main.beancount"
                            }
                        },
                    }
                }
            }),
            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                    { name = "cmdline_history" },
                },
            }),
            cmp.setup.cmdline("?", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                    { name = "cmdline_history" },
                },
            }),


            -- Use cmdline & path source for '' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                    { name = "cmdline" },
                    { name = "cmdline_history" },
                }),
            }),
        }
        )
    end
}

-- return cmp
return {}
