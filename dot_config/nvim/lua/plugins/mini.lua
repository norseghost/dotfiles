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
    },
}
