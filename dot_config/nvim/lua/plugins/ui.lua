return {
    function()
        if not IS_TERMUX then
            return {
                "gbprod/nord.nvim",
                lazy = false,
                priority = 1000,
                init = function()
                    vim.cmd.colorscheme("nord")
                end
            }
        else
            return {
                "miikanissi/modus-themes.nvim",
                lazy = false,
                priority = 1000,
                init = function()
                    vim.cmd.colorscheme("modus_operandi")
                    -- vim.cmd.colorscheme("wordsmith")
                end
            }
        end
    end,
    "kyazdani42/nvim-web-devicons", -- file type icon
}
