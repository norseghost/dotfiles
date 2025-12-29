return {
    { -- color scheme
        "gbprod/nord.nvim",
        lazy = false,
        priority = 1000,
        init = function()
            vim.cmd.colorscheme("nord")
        end
    },
    "kyazdani42/nvim-web-devicons", -- file type icon 
}
