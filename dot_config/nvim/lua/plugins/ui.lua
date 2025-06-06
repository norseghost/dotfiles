return {
    -- {
    --     "folke/noice.nvim",
    --     event = "VeryLazy",
    --     opts = {
    --         lsp = {
    --             -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    --             override = {
    --                 ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
    --                 ["vim.lsp.util.stylize_markdown"] = true,
    --                 ["cmp.entry.get_documentation"] = true,
    --             },
    --             hover = {
    --                 enabled = false,
    --                 view = nil, -- when nil, use defaults from documentation
    --             },
    --         },
    --         -- you can enable a preset for easier configurationhttps://github.com/norseghost/zotex.nvim.git
    --         presets = {
    --             bottom_search = true, -- use a classic bottom cmdline for search
    --             command_palette = true, -- position the cmdline and popupmenu together
    --             long_message_to_split = true, -- long messages will be sent to a split
    --             inc_rename = false, -- enables an input dialog for inc-rename.nvim
    --             lsp_doc_border = false, -- add a border to hover docs and signature help
    --         },
    --     },
    --     dependencies = {
    --         "MunifTanjim/nui.nvim",
    --         "rcarriga/nvim-notify",
    --     }
    -- },
    { -- color scheme
        "gbprod/nord.nvim",
        lazy = false,
        priority = 1000,
        init = function()
            vim.cmd.colorscheme("nord")
        end
    },
    "kyazdani42/nvim-web-devicons", -- file type icons
    -- {
    --     "stevearc/dressing.nvim", -- prettify ui wrapper
    --     event = "VeryLazy"
    -- },
    -- {
    --     "kevinhwang91/nvim-bqf",
    --     ft = "qf,
    -- },
}
