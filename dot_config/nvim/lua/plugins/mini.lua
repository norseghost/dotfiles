return {
    {
        "echasnovski/mini.align",
        event = "VeryLazy",
        config = true
    },
    {
        "echasnovski/mini.bufremove",
        config = true,
        -- event = "VeryLazy",
        keys = {
            {
                "<leader>c",
                function()
                    require("mini.bufremove").delete()
                end,
                desc = "Delete buffer"
            },
            {
                "<leader>C",
                function()
                    require("mini.bufremove").wipeout()
                end,
                desc = "Wipe buffer"
            },
        }
    },
    {
        "echasnovski/mini.move",
        version = false,
        event = "VeryLazy",
        config = true
    },
    -- comments
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        config = true
    },
    {
        "echasnovski/mini.surround",
        event = "VeryLazy",
        config = true
    },
    {
        "echasnovski/mini.indentscope",
        event  = "VeryLazy",
        config = true
    },
    -- better text-objects
    {
        "echasnovski/mini.ai",
        -- keys = {
        --   { "a", mode = { "x", "o" } },
        --   { "i", mode = { "x", "o" } },
        -- },
        event = "VeryLazy",
        dependencies = { "nvim-treesitter-textobjects" },
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                },
            }
        end,
        config = function(_, opts)
            require("mini.ai").setup(opts)
            -- register all text objects with which-key
            ---@type table<string, string|table>
            local i = {
                [" "] = "Whitespace",
                ['"'] = 'Balanced "',
                ["'"] = "Balanced '",
                ["`"] = "Balanced `",
                ["("] = "Balanced (",
                [")"] = "Balanced ) including white-space",
                [">"] = "Balanced > including white-space",
                ["<lt>"] = "Balanced <",
                ["]"] = "Balanced ] including white-space",
                ["["] = "Balanced [",
                ["}"] = "Balanced } including white-space",
                ["{"] = "Balanced {",
                ["?"] = "User Prompt",
                _ = "Underscore",
                a = "Argument",
                b = "Balanced ), ], }",
                c = "Class",
                f = "Function",
                o = "Block, conditional, loop",
                q = "Quote `, \", '",
                t = "Tag",
            }
            local a = vim.deepcopy(i)
            for k, v in pairs(a) do
                a[k] = v:gsub(" including.*", "")
            end

            local ic = vim.deepcopy(i)
            local ac = vim.deepcopy(a)
            for key, name in pairs({ n = "Next", l = "Last" }) do
                i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
                a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
            end
            require("which-key").register({
                mode = { "o", "x" },
                i = i,
                a = a,
            })
        end,
    },
}
