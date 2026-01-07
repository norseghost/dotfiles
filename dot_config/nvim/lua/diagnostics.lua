--- diagnostips
vim.diagnostic.config({
    virtual_text = {
        spacing = 4,
        prefix = "●",
    },
    signs = true,             -- simple gutter signs
    update_in_insert = false, -- do NOT update while typing
    underline = true,         -- underline errors/warnings
    severity_sort = true,
})
