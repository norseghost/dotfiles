-- autocmds.lua

local ui = vim.api.nvim_create_augroup("ui", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = ui,
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end
})
-- show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
    group = ui,
    callback = function()
        local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
        if ok and cl then
            vim.wo.cursorline = true
            vim.api.nvim_win_del_var(0, "auto-cursorline")
        end
    end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
    group = ui,
    callback = function()
        local cl = vim.wo.cursorline
        if cl then
            vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
            vim.wo.cursorline = false
        end
    end,
})

-- create directories when needed, when saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
    callback = function(event)
        local file = vim.loop.fs_realpath(event.match) or event.match

        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
        local backup = vim.fn.fnamemodify(file, ":p:~:h")
        backup = backup:gsub("[/\\]", "%%")
        vim.go.backupext = backup
    end,
})

-- Fix conceallevel for json & help files
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = ui,
    pattern = { "json", "jsonc" },
    callback = function()
        vim.wo.spell = false
        vim.wo.conceallevel = 0
    end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = ui,
    pattern = {
        "qf",
        "help",
        "man",
        "notify",
        "lspinfo",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "PlenaryTestPopup",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})
-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = ui,
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
})

-- go to last location when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    group = ui,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})
