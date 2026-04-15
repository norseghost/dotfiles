return {
    { -- color scheme
        "gbprod/nord.nvim",
        lazy = false,
        priority = 1000,
        init = function()
            if not IS_TERMUX then
                vim.cmd.colorscheme("nord")
            else
                vim.cmd.colorscheme("wordsmith")
            end
        end
    },
    "kyazdani42/nvim-web-devicons", -- file type icon
}
