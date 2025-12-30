local writing = {
    {
        "jaytyrrell13/static.nvim",
        opts = {
            strategy = "neovim"
        },

        keys = {
            { "<leader>Sb", ":Static build<cr>" },
            { "<leader>Ss", ":Static serve<cr>" },
            { "<leader>Sp", ":Static prod<cr>" },
        },
    }
}

return writing
