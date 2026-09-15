return {
    {
        IS_TERMUX and "miikanissi/modus-themes.nvim" or "gbprod/nord.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            local theme = IS_TERMUX and "modus_operandi" or "nord"
            vim.cmd.colorscheme(theme)
        end,
    },
    "kyazdani42/nvim-web-devicons",
}
