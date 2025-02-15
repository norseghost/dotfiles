local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
-- load lazy
require("lazy").setup("plugins", {
    defaults = { lazy = true },
    -- dev = { patterns = jit.os:find("Windows") and {} or { "folke" } },
    install = { colorscheme = { "nord" } },
    checker = { enabled = true },
    performance = {
        rtp = {
            reset = true,
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "tarPlugin",
                "netrwPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    debug = false,
})

vim.keymap.set("n", "<leader>pp", "<cmd>:Lazy<cr>", { desc = "Lazy Home" })
vim.keymap.set("n", "<leader>ps", "<cmd>:Lazy sync<cr>", { desc = "Sync Plugins" })
vim.keymap.set("n", "<leader>ph", "<cmd>:Lazy health<cr>", { desc = "Lazy Health" })
vim.keymap.set("n", "<leader>pP", "<cmd>:Lazy profile<cr>", { desc = "Profile Plugins" })
vim.keymap.set("n", "<leader>pc", "<cmd>:Lazy clean<cr>", { desc = "Clean Plugins" })
